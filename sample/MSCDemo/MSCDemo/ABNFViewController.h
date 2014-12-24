//
//  ABNFViewController.h
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
@class IFlySpeechRecognizer;

/**
 abnf语法识别demo
 使用该功能需要下面步骤：
 1. 创建识别对象，数据上传对象；
 2. 上传语法内容，然后获取grammarID；
 3. 将grammarID作为参数设置到识别对象中；
 4. 有选择的实现识别回调；
 5. 启动识别
 */
@interface ABNFViewController : UIViewController<IFlySpeechRecognizerDelegate,UIActionSheetDelegate>

//语法识别对象
@property (nonatomic, strong) IFlySpeechRecognizer * iFlySpeechRecognizer;

//数据上传对象
@property (nonatomic, strong) IFlyDataUploader     * uploader;

@property (nonatomic, weak)   UITextView           * resultView;
@property (nonatomic, strong) PopupView            * popUpView;
@property (nonatomic, weak)   UIButton             * startBtn;
@property (nonatomic, weak)   UIButton             * stopBtn;
@property (nonatomic, weak)   UIButton             * cancelBtn;
@property (nonatomic, weak)   UIButton             * uploadBtn;

@property (nonatomic, strong) NSMutableString      * curResult;//当前session的结果
@property (nonatomic)         BOOL                  isCanceled;

@property (nonatomic)         NSString             * grammarType;//语法类型

-(void)setViewSize:(BOOL)movedUp Notification:(NSNotification*) notification;
@end
