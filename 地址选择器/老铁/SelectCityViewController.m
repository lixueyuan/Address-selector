//
//  SelectCityViewController.m
//  地址选择器
//
//  Created by sTagRD on 2018/1/17.
//  Copyright © 2018年 sTagRD. All rights reserved.
//

#define SCREEN_W [UIScreen mainScreen].bounds.size.width
#define SCREEN_H [UIScreen mainScreen].bounds.size.height

#import "SelectCityViewController.h"
#import "ContentView.h"

@interface SelectCityViewController ()
//展示所有内容的视图
@property (nonatomic, strong) ContentView *contentView;
//用来去取消控制器的视图
@property (nonatomic, strong) UIView *tapDismissView;

@end

@implementation SelectCityViewController

+ (void)presentSelectCityViewController:(UIViewController *)senderViewController successBlock:(giveYourAddressBlock)successBlock {
    SelectCityViewController *selectVc = [[SelectCityViewController alloc] init];
    [senderViewController presentViewController:selectVc animated:YES completion:^{
        
    }];
}


#pragma mark ----懒加载----
- (ContentView *)contentView {
    if (!_contentView) {
        _contentView = [[ContentView alloc] initWithFrame:CGRectMake(0, SCREEN_H / 2, SCREEN_W, SCREEN_H / 2)];
        __weak typeof(self) weakSelf = self;
        _contentView.addressString = _oldAddressString;
        _contentView.cancelActionBlock = ^{
            [weakSelf dismissViewControllerAnimated:YES completion:nil];
        };
        _contentView.downActionBlock = ^(NSString *selectResultString) {
            [weakSelf dismissViewControllerAnimated:YES completion:^{
                weakSelf.yourAddressBlock(selectResultString);
            }];
        };
    }
    return _contentView;
}

- (UIView *)tapDismissView {
    if (!_tapDismissView) {
        _tapDismissView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_W, SCREEN_H / 2)];
    }
    return _tapDismissView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.contentView];
    [self.view addSubview:self.tapDismissView];
    self.view.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.2];
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismiss:)];
    [self.tapDismissView addGestureRecognizer:tapGesture];
}

- (void)dismiss:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
