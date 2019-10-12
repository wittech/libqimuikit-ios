//
//  QIMFlutterModule.m
//  QIMUIKit
//
//  Created by lilu on 2019/9/20.
//

#import "QIMFlutterModule.h"
#import "QIMJSONSerializer.h"
#import "QIMFlutterViewController.h"
#import "QIMFastEntrance.h"
#import "UIApplication+QIMApplication.h"
#import <Flutter/Flutter.h>

@interface QIMFlutterModule ()

@property (nonatomic, strong) FlutterMethodChannel *medalChannel;

@property (nonatomic, strong) QIMFlutterViewController *flutterVc;

@end

@implementation QIMFlutterModule

static QIMFlutterModule *_flutterModule = nil;
+ (instancetype)sharedInstance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _flutterModule = [[QIMFlutterModule alloc] init];
    });
    return _flutterModule;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        self.medalChannel;
        
    }
    return self;
}

- (QIMFlutterViewController *)flutterVc {
    if (!_flutterVc) {
        _flutterVc = [QIMFlutterViewController new];
        //取消闪App启动图
        _flutterVc.splashScreenView = nil;
    }
    return _flutterVc;
}

- (FlutterMethodChannel *)medalChannel {
    if (!_medalChannel) {
        _medalChannel = [FlutterMethodChannel methodChannelWithName:@"data.flutter.io/medal" binaryMessenger:self.flutterVc];
        __weak typeof(self) weakSelf = self;
        [_medalChannel setMethodCallHandler:^(FlutterMethodCall * _Nonnull call, FlutterResult  _Nonnull result) {
            if ([@"getMedalList" isEqualToString:call.method]) {
                NSLog(@"getMedalList Channel");
                //获取我的勋章列表
                NSDictionary *callArguments = (NSDictionary *)call.arguments;
                NSDictionary *userId = [callArguments objectForKey:@"userId"];
                NSArray *array = [[QIMKit sharedInstance] getUserWearMedalStatusByUserid:userId];
                NSString *jsonStr2 = [[QIMJSONSerializer sharedInstance] serializeObject:array];
                result(jsonStr2);

            } else if ([@"getNickInfo" isEqualToString:call.method]) {
                
                NSDictionary *callArguments = (NSDictionary *)call.arguments;
                NSString *userId = [callArguments objectForKey:@"userid"];
                NSString *userNickInfo = [self getNickInfoWithUserXmppId:userId];
                result(userNickInfo);
            } else if ([@"getUsersInMedal" isEqualToString:call.method]) {
                
                //获取这个勋章下的所有用户
                NSDictionary *callArguments = (NSDictionary *)call.arguments;
                NSInteger medalId = [[callArguments objectForKey:@"medalId"] integerValue];
                NSInteger limit = [[callArguments objectForKey:@"limit"] integerValue];
                NSInteger offset = [[callArguments objectForKey:@"offset"] integerValue];
                NSArray *userInfoList = [[QIMKit sharedInstance] getUsersInMedal:medalId withLimit:limit withOffset:offset];
                NSString *jsonStr2 = [[QIMJSONSerializer sharedInstance] serializeObject:userInfoList];
                result(jsonStr2);
            } else if ([@"updateUserMedalStatus" isEqualToString:call.method]) {
                //设置勋章状态
                NSDictionary *callArguments = (NSDictionary *)call.arguments;
                NSInteger medalId = [[callArguments objectForKey:@"medalId"] integerValue];
                NSInteger status = [[callArguments objectForKey:@"status"] integerValue];
                [[QIMKit sharedInstance] userMedalStatusModifyWithStatus:status withMedalId:medalId withCallBack:^(BOOL success, NSString *errmsg) {
                    if (success == YES) {
                        NSLog(@"medaiId : %ld, status : %ld", medalId, status);
                        NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithCapacity:3];
                        [dic setObject:@(YES) forKey:@"isOK"];
                        NSDictionary *medalDic = [[QIMKit sharedInstance] getUserMedalWithMedalId:medalId withUserId:[[QIMKit sharedInstance] getLastJid]];
                        [dic setObject:medalDic forKey:@"medal"];
                        NSString *jsonStr2 = [[QIMJSONSerializer sharedInstance] serializeObject:dic];
                        result(jsonStr2);
                    } else {
                        NSLog(@"medaiId : %ld, status : %ld", medalId, status);
                        NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithCapacity:3];
                        [dic setObject:@(NO) forKey:@"isOK"];
                        NSString *jsonStr2 = [[QIMJSONSerializer sharedInstance] serializeObject:dic];
                        result(jsonStr2);
                    }
                }];
            } else if ([@"nativeLocalLog" isEqualToString:call.method]) {
                NSDictionary *callArguments = (NSDictionary *)call.arguments;
                NSString *logCode = [callArguments objectForKey:@"logCode"];
                NSString *logDes = [callArguments objectForKey:@"logDes"];
                
                
            } else {
              result(FlutterMethodNotImplemented);
            }
        }];
    }
    return _medalChannel;
}

- (NSString *)getNickInfoWithUserXmppId:(NSString *)userId {
    NSDictionary *dic = [[QIMKit sharedInstance] getUserInfoByUserId:userId];
    NSMutableDictionary *userInfoDic = [NSMutableDictionary dictionaryWithDictionary:dic];
    [userInfoDic setObject:@"" forKey:@"UserInfo"];
    NSString *str = [[QIMJSONSerializer sharedInstance] serializeObject:userInfoDic];
    return str;
}

- (void)openUserMedalFlutterWithUserId:(NSString *)userId {
    dispatch_async(dispatch_get_main_queue(), ^{
//        NSDictionary *dic = [[QIMKit sharedInstance] getUserInfoByUserId:userId];
//        NSMutableDictionary *userInfoDic = [NSMutableDictionary dictionaryWithDictionary:dic];
//        [userInfoDic setObject:@"" forKey:@"UserInfo"];
//        NSString *str = [[QIMJSONSerializer sharedInstance] serializeObject:userInfoDic];
        [self.flutterVc setInitialRoute:[[QIMKit sharedInstance] getLastJid]];
  
        UINavigationController *navVC = [[UIApplication sharedApplication] visibleNavigationController];
        if (!navVC) {
            navVC = [[QIMFastEntrance sharedInstance] getQIMFastEntranceRootNav];
        }
        [navVC pushViewController:self.flutterVc animated:YES];
    });
}

@end