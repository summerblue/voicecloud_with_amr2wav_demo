//
//  AFRViewController.m
//  MSCDemo_UI
//
//  Created by junmei on 14-2-24.
//
//

#import "AFRViewController.h"
#import "Definition.h"
#import "iflyMSC/IFlySpeechUtility.h"
#import "iflyMSC/IFlySpeechRecognizer.h"
#import "PopupView.h"
#import "iflyMSC/IFlySpeechConstant.h"

#import "amrFileCodec.h"

@interface AFRViewController ()
{
    NSString *pcmFilePath;//音频文件路径
}
@end

@implementation AFRViewController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    
    if (self) {
    }
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"音频流识别";
    
	// Do any additional setup after loading the view.
    self.uploadWordBtn.hidden = YES;
    self.uploadContactBtn.hidden = YES;
    
    UILabel *custom = (UILabel *)[self.view viewWithTag:9527];
    custom.hidden = YES;
    
    UIButton *audiobtn = [UIButton buttonWithType:UIButtonTypeRoundedRect] ;
    [audiobtn setTitle:@"音频流识别" forState:UIControlStateNormal];
    
    audiobtn.frame = CGRectMake(Padding, custom.frame.origin.y + custom.frame.size.height+10, self.view.frame.size.width-Padding*2, ButtonHeight);
    [self.view addSubview:audiobtn];
    
    [audiobtn addTarget:self action:@selector(audioFileRcg:) forControlEvents:UIControlEventTouchUpInside];
    
    self.audiobtn = audiobtn;
    
    [self audioFileRcg:nil];
}


-(void)viewWillDisappear:(BOOL)animated
{
    NSLog(@"AFRViewController viewWillDisappear");
    
    [super viewWillDisappear:animated];
    
    //确保引擎已经停止
    [self.iFlySpeechRecognizer cancel];
    //不再接受引擎回调
    self.iFlySpeechRecognizer.delegate = nil;
    //设置音频数据模式
    [self.iFlySpeechRecognizer setParameter:IFLY_AUDIO_SOURCE_MIC forKey:@"audio_source"];
    //关闭保存录音
    [super.iFlySpeechRecognizer setParameter:nil forKey:[IFlySpeechConstant ASR_AUDIO_PATH]];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//音频流识别按钮响应函数
- (void)sendAudioThread
{
    NSLog(@"sendAudioThread[IN]");
    
    //从文件中读取音频
//    NSData *data = [NSData dataWithContentsOfFile:pcmFilePath];
    
    
#warning 转换 amr 文件为 wav
    NSString *mediaPath = @"http://oralmaster-ugc.qiniudn.com/user_1_2014-12-23_10:13:39-SmKxmA.amr";
    NSURL *url = [[NSURL alloc] initWithString:mediaPath];
    NSData * audioData = [NSData dataWithContentsOfURL:url];
    // Conversion
    NSData *data = DecodeAMRToWAVE(audioData);
    
    
    int count = 10;
    unsigned long audioLen = data.length/count;
    
    //分割音频
    for (int i =0 ; i< count-1; i++) {
        char * part1Bytes = malloc(audioLen);
        NSRange range = NSMakeRange(audioLen*i, audioLen);
        [data getBytes:part1Bytes range:range];
        NSData * part1 = [NSData dataWithBytes:part1Bytes length:audioLen];
        //写入音频，让SDK识别
        int ret = [self.iFlySpeechRecognizer writeAudio:part1];
        free(part1Bytes);
        
        //检测数据发送是否正常
        if(!ret)
        {
            NSLog(@"sendAudioThread[ERROR]");
            
            [self.iFlySpeechRecognizer stopListening];
            
            self.startBtn.enabled = YES;
            self.audiobtn.enabled = YES;
            
            return;
        }
    }
    
    //处理最后一部分
    unsigned long writtenLen = audioLen * (count-1);
    char * part3Bytes = malloc(data.length-writtenLen);
    NSRange range = NSMakeRange(writtenLen, data.length-writtenLen);
    [data getBytes:part3Bytes range:range];
    NSData * part3 = [NSData dataWithBytes:part3Bytes length:data.length-writtenLen];
    
    [self.iFlySpeechRecognizer writeAudio:part3];
    
    free(part3Bytes);
    
    //音频数据写入完成，进入等待状态
    [self.iFlySpeechRecognizer stopListening];
    
    NSLog(@"sendAudioThread[OUT]");
}

//音频流识别按钮响应函数
- (void)audioFileRcg:(id)sender
{
    
    if( [super.iFlySpeechRecognizer isListening])
    {
        [self.popUpView setText: @"启动识别服务失败，请稍后重试"];//可能是上次请求未结束，暂不支持多路并发
        
        [self.iFlySpeechRecognizer setParameter:IFLY_AUDIO_SOURCE_MIC forKey:@"audio_source"];
        
        [self.view addSubview:self.popUpView];
        
        return;
    }
    
    //获取音频文件
    NSString *docdir = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
    NSFileManager *fm = [NSFileManager defaultManager];
    
    pcmFilePath = [[NSString alloc] initWithFormat:@"%@",[docdir stringByAppendingPathComponent:@"asr.pcm"]];
    if(!pcmFilePath || [pcmFilePath length] == 0)
    {
        return;
    }
    
    if (![fm fileExistsAtPath:pcmFilePath]) {
        
        [self.popUpView setText:@"文件不存在"];
            
        [self.view addSubview:self.popUpView];
        
        NSLog(@"文件不存在");
        
        return;
    }

    self.startBtn.enabled = NO;
    self.audiobtn.enabled = NO;
    
    //设置音频数据模式为音频流
    [self.iFlySpeechRecognizer setParameter:IFLY_AUDIO_SOURCE_STREAM forKey:@"audio_source"];
    
    //启动服务
    BOOL ret = [self.iFlySpeechRecognizer startListening];
    if (ret) {
        
        self.isCanceled = NO;
        
        //启动发送数据线程
        //    [self sendAudioThread];
        [NSThread detachNewThreadSelector:@selector(sendAudioThread) toTarget:self withObject:nil];
    }
}

/*
 * @开始录音
 */
- (void) onBtnStart:(id) sender
{
    if( [super.iFlySpeechRecognizer isListening])
    {
        [self.popUpView setText: @"启动识别服务失败，请稍后重试"];//可能是上次请求未结束，暂不支持多路并发
        [self.view addSubview:self.popUpView];
        
        return;
    }
    
    self.audiobtn.enabled = NO;
    
    //设置录音保存文件
    [super.iFlySpeechRecognizer setParameter:@"asr.pcm" forKey:[IFlySpeechConstant ASR_AUDIO_PATH]];
    
    [super onBtnStart:sender];
}

/**
 * @fn      onError
 * @brief   识别结束回调
 *
 * @param   errorCode   -[out] 错误类，具体用法见IFlySpeechError
 */
- (void) onError:(IFlySpeechError *) error
{
    NSLog(@"AFRViewController onError=%d",[error errorCode]);

    NSString *text ;
    if (self.isCanceled) {
        
        text = @"识别取消";
    }
    else if (error.errorCode ==0 ) {
        
        if (self.result.length==0) {
            text = @"无识别结果";
        }
        else
        {
            text = @"识别成功";
        }
    }
    else
    {
        text = [NSString stringWithFormat:@"发生错误：%d %@",error.errorCode,error.errorDesc];
        NSLog(@"text= %@",text);
    }
    
    [self.popUpView setText: text];
    [self.view addSubview:self.popUpView];
    
    [self.stopBtn setEnabled:NO];
    [self.cancelBtn setEnabled:NO];
    [self.audiobtn setEnabled:YES];
    [self.startBtn setEnabled :YES];
}


@end
