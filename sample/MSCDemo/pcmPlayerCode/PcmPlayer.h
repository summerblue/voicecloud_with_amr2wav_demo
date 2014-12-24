//
//  pcmPlayer.h
//  MSCDemo
//
//  Created by wangdan on 14-11-4.
//
//

#import <Foundation/Foundation.h>
#import<AVFoundation/AVFoundation.h>

@interface PcmPlayer : NSObject<AVAudioPlayerDelegate>


@property (nonatomic,strong) AVAudioPlayer *player;
@property (nonatomic,assign) BOOL isAutoPlay;


/*  初始化播放器，并传入音频的本地路径
 * @praram pcmFile 本地音频的完整路径,支持pcm格式
 */
- (id)initWithPcmFile:(NSString *)pcmFile;


/*  初始化播放器完毕之后，传入音频的本地路径
 * @praram pcmFile 本地音频的完整路径,支持pcm格式
 */
- (void)setAudioData:(NSString *)pcmFile;
//播放器开始播放

- (void)play;
//播放器停止播放
- (void)stop;

@end
