//
//  AFRViewController.h
//  MSCDemo_UI
//
//  Created by junmei on 14-2-24.
//
//

#import "ISRViewController.h"

/**
 音频流识别demo
 使用该功能需要下面步骤：
 1. 创建识别对象；
 2. 设置识别输入模式为音频流；
 [self.iFlySpeechRecognizer setParameter:IFLY_AUDIO_SOURCE_STREAM forKey:@"audio_source"];
 3. 有选择的实现识别回调；
 4. 启动识别；
 5. 使用writeAudio往识别对象中传递音频数据；
 6. 传递完毕后结束识别，进入等待结果状态。
 [self.iFlySpeechRecognizer stopListening];
 */
//forward declare
@class PopupView;

@interface AFRViewController : ISRViewController

@property (weak) UIButton *audiobtn;
@property (nonatomic, strong) PopupView            * popUpView;

@end
