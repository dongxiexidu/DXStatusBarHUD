

#import "DXStatusBarHUD.h"

@implementation DXStatusBarHUD
static UIWindow *window_;
static NSTimer *timer_;

/** HUD控件的高度 */
//#define DXWindowH = isIphoneX == true ? 44 : 20;
//#define isIphoneX = [UIScreen mainScreen].bounds.size.width == 812.0 ? true : false

/** HUD控件的高度 */
static CGFloat const DXWindowH = 20;
/** HUD控件的动画持续时间（出现\隐藏） */
static CGFloat const DXAnimationDuration = 0.25;
/** HUD控件默认会停留多长时间 */
static CGFloat const DXHUDStayDuration = 1.5;

+ (void)showImage:(UIImage *)image text:(NSString *)text
{
    // 停止之前的定时器
    [timer_ invalidate];
    
    // 创建窗口
    window_.hidden = YES; // 先隐藏之前的window
    window_ = [[UIWindow alloc] init];
    window_.backgroundColor = [UIColor blackColor];
    window_.windowLevel = UIWindowLevelAlert;
    
    if ([UIScreen mainScreen].bounds.size.height == 812.0) {
        window_.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, DXWindowH);
    }else{
        window_.frame = CGRectMake(0, - DXWindowH, [UIScreen mainScreen].bounds.size.width, DXWindowH);
    }
    
    window_.hidden = NO;
    
    // 添加按钮
    UIButton *button = [[UIButton alloc] init];
    button.frame = window_.bounds;
    // 文字
    [button setTitle:text forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:13];
    // 图片
    if (image) {
        [button setImage:image forState:UIControlStateNormal];
        button.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 5);
        button.titleEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 0);
    }
    [window_ addSubview:button];
    
    // 动画
    [UIView animateWithDuration:DXAnimationDuration animations:^{
        CGRect frame = window_.frame;
         if ([UIScreen mainScreen].bounds.size.height == 812.0) {
             frame.origin.y = DXWindowH;
         }else{
             frame.origin.y = 0;
         }
        
        window_.frame = frame;
    }];
    
    // 开启一个新的定时器
    timer_ = [NSTimer scheduledTimerWithTimeInterval:DXHUDStayDuration target:self selector:@selector(hide) userInfo:nil repeats:NO];
}

+ (void)showImageName:(NSString *)imageName text:(NSString *)text
{
    [self showImage:[UIImage imageNamed:imageName] text:text];
}

+ (void)showSuccess:(NSString *)text
{
    [self showImageName:@"DXStatusBarHUD.bundle/success" text:text];
}

+ (void)showError:(NSString *)text
{
    [self showImageName:@"DXStatusBarHUD.bundle/error" text:text];
}

+ (void)showText:(NSString *)text
{
    [self showImage:nil text:text];
}

+ (void)showLoading:(NSString *)text
{
    // 停止之前的定时器
    [timer_ invalidate];
    timer_ = nil;
    
    // 创建窗口
    window_.hidden = YES; // 先隐藏之前的window
    window_ = [[UIWindow alloc] init];
    window_.backgroundColor = [UIColor blackColor];
    window_.windowLevel = UIWindowLevelAlert;
    window_.frame = CGRectMake(0, - DXWindowH, [UIScreen mainScreen].bounds.size.width, DXWindowH);
    window_.hidden = NO;
    
    // 添加按钮
    UIButton *button = [[UIButton alloc] init];
    button.frame = window_.bounds;
    // 文字
    [button setTitle:text forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:13];
    [window_ addSubview:button];
    
    // 圈圈
    UIActivityIndicatorView *loadingView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    [loadingView startAnimating];
    loadingView.center = CGPointMake(button.titleLabel.frame.origin.x - 60, DXWindowH * 0.5);
    [window_ addSubview:loadingView];
    
    // 动画
    [UIView animateWithDuration:DXAnimationDuration animations:^{
        CGRect frame = window_.frame;
        frame.origin.y = 0;
        window_.frame = frame;
    }];
}

+ (void)hide
{
    // 清空定时器
    [timer_ invalidate];
    timer_ = nil;
    
    // 退出动画
    [UIView animateWithDuration:DXAnimationDuration animations:^{
        CGRect frame = window_.frame;
        frame.origin.y =  - DXWindowH;
        window_.frame = frame;
    } completion:^(BOOL finished) {
        window_ = nil;
    }];
}
@end
