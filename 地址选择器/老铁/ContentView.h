//
//  ContentView.h
//  地址选择器
//
//  Created by sTagRD on 2018/1/17.
//  Copyright © 2018年 sTagRD. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^cancelBlock)(void);
typedef void(^downBlock)(NSString *selectResultString);

@interface ContentView : UIView

@property (copy, nonatomic) cancelBlock cancelActionBlock;
@property (copy, nonatomic) downBlock downActionBlock;

@property (copy, nonatomic) NSString *addressString;
//这里接受主界面传回来的值

//下面是三个不同的数据源
@property (nonatomic, strong) NSMutableArray *provincesArray;
@property (nonatomic, strong) NSMutableArray *cityArray;
@property (nonatomic, strong) NSMutableArray *areaArray;

@end
