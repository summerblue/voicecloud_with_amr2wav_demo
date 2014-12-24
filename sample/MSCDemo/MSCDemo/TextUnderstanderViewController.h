//
//  TextUnderstanderViewController.h
//  MSCDemo
//
//  Created by AlexHHC on 4/24/14.
//  Copyright (c) 2014 iflytek. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PopupView;

/**
 文本语义理解demo
 使用该功能需要下面步骤：
 1.创建文本语义理解对象；
 2.启动文本语义搜索；
 3.监视服务返回的block
 */

@interface TextUnderstanderViewController : UIViewController<UITextViewDelegate>

//右上角的清空按钮
@property (nonatomic,strong)        UIBarButtonItem     * clearBtn;

//默认语义理解文本
@property (nonatomic, copy)         NSString            * defaultText;
@property (nonatomic, weak)         UITextView          * resultView;
@property (nonatomic, strong)       PopupView           * popUpView;
@end
