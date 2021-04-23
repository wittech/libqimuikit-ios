//
//  QIMNavController.h
//  qunarChatIphone
//
//  Created by xueping on 15/6/29.
//
//

#import <UIKit/UIKit.h>
//增加mpaas的框架引用
#import <APMobileFramework/APMobileFramework.h>

@interface UINavigationController(QTalk)
//- (void)popToViewControllor:(UIViewController *)popViewController ThenPush:(UIViewController *)toViewController animated:(BOOL)animated;
- (void)popToRootVCThenPush:(UIViewController *)toViewController animated:(BOOL)animated;
@end

@interface QIMNavController : UINavigationController

@property (nonatomic, assign) BOOL cancelMotion;

@end

//此处修改为继承mpaas的DTViewControoler，便于后续能力扩展；
@interface QTalkViewController : DTViewController

- (void)selfPopedViewController;

@end
