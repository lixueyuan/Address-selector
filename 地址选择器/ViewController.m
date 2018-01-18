//
//  ViewController.m
//  地址选择器
//
//  Created by sTagRD on 2018/1/17.
//  Copyright © 2018年 sTagRD. All rights reserved.
//

#import "ViewController.h"
#import "SelectCityViewController.h"
@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIButton *addressButton;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (IBAction)selectAddressAction:(id)sender {
    SelectCityViewController *selectVc = [[SelectCityViewController alloc] init];
    
    selectVc.modalPresentationStyle = UIModalPresentationOverCurrentContext;
    
    selectVc.yourAddressBlock = ^(NSString *addressString) {
        [_addressButton setTitle:addressString forState:UIControlStateNormal];
    };
    //将选中的地址回传
    if (![self.addressButton.titleLabel.text isEqualToString:@"老铁,选择地址"]) {
        selectVc.oldAddressString = self.addressButton.titleLabel.text;
    };
    
    [self presentViewController:selectVc animated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
