//
//  QIMNewMoivePlayerVC.h
//  QIMUIKit
//
//  Created by lilu on 2019/8/7.
//

#import "QIMCommonUIFramework.h"
#import "QIMVideoModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface QIMNewMoivePlayerVC : UIViewController

@property (nonatomic, strong) QIMVideoModel *videoModel;

/*
@property (nonatomic, strong) NSDictionary *videoInfoDic;

@property (nonatomic, assign) BOOL localVideo;

@property (nonatomic, copy) NSString *localVideoCoverImagePath; //本地视频Cover图片路径

@property (nonatomic, copy) NSString *localVideoPath;   //本地视频路径

@property (nonatomic, copy) NSString *remoteVideoCoverImagePath;    //远程视频Cover图片路径

@property (nonatomic, copy) NSString *remoteVideoUrl;   //远程视频路径
*/

@end

NS_ASSUME_NONNULL_END