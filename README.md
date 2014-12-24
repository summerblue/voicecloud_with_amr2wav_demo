## 说明

此项目是 [科大讯飞 - 语音识别](http://open.voicecloud.cn/index.php/default/doccenter/doccenterInner?itemTitle=eXlqcw==&anchor=Y29udGl0bGUyNg==) 转换 amr 音频格式的 DEMO. 

因为科大讯飞 IOS SDK 只支持 `PCM或者WAV格式的音频` 的识别, 所以使用了 [Amr2Wav](https://github.com/summerblue/Amr2Wav) 项目把已有的 amr 文件转为 wav 文件, 再提交给科大讯飞服务器转换.

## 注意

最新版的 sdk , 请到官网下载 : http://open.voicecloud.cn/index.php/services/voicebase?type=tts&tab_index=1 
