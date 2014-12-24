//
//  ISRViewController.h
//  MSCDemo
//
//  Created by iflytek on 13-6-6.
//  Copyright (c) 2013年 iflytek. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "iflyMSC/IFlySpeechRecognizerDelegate.h"

//forward declare
@class PopupView;
@class IFlyDataUploader;
@class IFlySpeechUnderstander;

/**
 语音理解demo
 使用该功能仅仅需要三步
 1.创建语义理解对象；
 2.有选择的实现识别回调；
 3.启动语义理解
 */
@interface UnderstandViewController : UIViewController<IFlySpeechRecognizerDelegate>

//语义理解对象
@property (nonatomic,strong) IFlySpeechUnderstander *iFlySpeechUnderstander;

@property (nonatomic,weak)   UITextView             *resultView;
@property (nonatomic,strong) PopupView              *popUpView;
@property (nonatomic,weak)   UIButton               *startBtn;
@property (nonatomic,weak)   UIButton               *stopBtn;
@property (nonatomic,weak)   UIButton               *cancelBtn;

@property (nonatomic,strong) NSString               *result;
@property (nonatomic)         BOOL                  isCanceled;

@end
