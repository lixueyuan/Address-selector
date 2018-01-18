//
//  SelectCityViewController.h
//  地址选择器
//
//  Created by sTagRD on 2018/1/17.
//  Copyright © 2018年 sTagRD. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^giveYourAddressBlock)(NSString *addressString);

@interface SelectCityViewController : UIViewController

@property (copy, nonatomic) giveYourAddressBlock yourAddressBlock;
//这是从主界面传过来已经选过的地址
@property (nonatomic, copy) NSString *oldAddressString;

+ (void)presentSelectCityViewController:(UIViewController *)senderViewController successBlock:(giveYourAddressBlock)successBlock;

@end
