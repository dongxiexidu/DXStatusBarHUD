

#import "ViewController.h"
#import "DXStatusBarHUD.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (IBAction)success {
    [DXStatusBarHUD showSuccess:@"加载数据成功！"];
}

- (IBAction)error {
    [DXStatusBarHUD showError:@"登录失败！"];
}

- (IBAction)loading {
    [DXStatusBarHUD showLoading:@"正在登录中..."];
}

- (IBAction)hide {
    [DXStatusBarHUD hide];
}

- (IBAction)normal {
    [DXStatusBarHUD showText:@"随便显示的文字！！！！"];
}

@end
