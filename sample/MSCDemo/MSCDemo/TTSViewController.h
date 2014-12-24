//
//  TTSViewController.h
//  MSCDemo
//
//  Created by iflytek on 13-6-6.
//  Copyright (c) 2013年 iflytek. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "iflyMSC/IFlySpeechSynthesizerDelegate.h"

@class AlertView;
@class PopupView;
@class IFlySpeechSynthesizer;

//合成的状态
typedef NS_OPTIONS(NSInteger, Status) {
    NotStart                 = 0,
    /**高，异常分析需要的级别*/
    Playing              = 2,
    
    Paused              = 4,
};


/**
 语音合成demo
 使用该功能需要下面步骤：
 1.创建合成对象；
 2.设置合成服务参数，比如发音人；
 [_iFlySpeechSynthesizer setParameter:@"xiaoyan" forKey:[IFlySpeechConstant VOICE_NAME]];
 3.有选择行的实现回调；
 4.启动合成。
 */

@interface TTSViewController : UIViewController<IFlySpeechSynthesizerDelegate,UIActionSheetDelegate>

//合成对象
@property (nonatomic, strong) IFlySpeechSynthesizer * iFlySpeechSynthesizer;

//合成状态
@property (nonatomic)         Status                 state;

@property (nonatomic, weak)   UITextView            * toBeSynthersedTextView;
@property (nonatomic, strong) PopupView             * popUpView;
@property (nonatomic, strong) AlertView             * bufferAlertView;
@property (nonatomic, strong) AlertView             * cancelAlertView;

@property (nonatomic, weak)   UIButton              * startBtn;
@property (nonatomic, weak)   UIButton              * cancelBtn;
@property (nonatomic, weak)   UIButton              * pauseBtn;
@property (nonatomic, weak)   UIButton              * resumeBtn;
@property (nonatomic, weak)   UIButton              * synthesizeBtn;


@property (nonatomic)         BOOL                   isCanceled;
@property (nonatomic)         BOOL                   hasError;
@property (nonatomic)         BOOL                   isViewDidDisappear;
@property (nonatomic)         CGFloat                textViewHeight;
@property (nonatomic)         BOOL                   synthesizeNotPlay;

-(void)setViewSize:(BOOL)movedUp Notification:(NSNotification*) notification;
@end
