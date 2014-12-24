
@*******************************

科大讯飞iOS平台语音SDK Demo使用说明

@*******************************

一 demo功能介绍

@"语音识别控件",
	带录音界面的语音听写使用示例
	ASRDialogViewController

@"语音听写",
	不带录音界面的语音听写使用示例
	ISRViewController

@"语义理解",
	不带界面的语义理解使用示例
	UnderstandViewController

@"语法识别",
	针对abnf语法的语音识别使用示例
	ABNFViewController

@"音频流识别",
	以音频流数据作为输入源的语音识别使用示例
	AFRViewController
	ISRViewController
	两个类配合实现

@"语音合成",
	不带界面的语音合成使用示例
	TTSViewController

@"文本语义理解"];
	以文本内容作为输入源的语义理解使用示例
	TextUnderstanderViewController

二 目录结构说明

   Definition为放置appid的头文件定义，在登陆时需要传入appid；

   MSCAppDelegate为App进入点，包含了demo的登陆配置代码，log日志设置代码，建议登陆在app最开始时调用，仅调用一次则可；

   RootViewController为Demo功能的菜单实现，罗列了demo所展示的菜单内容；

   RecognizerFactory为创建识别类对象的实现类；

   ISRDataHelper为解析各种识别结果的工具类；

   SBJson为解析json的工具类；

   bnf为放置abnf语法内容的文件夹；
 
   View为界面显示模块的工具类。
   

