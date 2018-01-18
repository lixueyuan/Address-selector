//
//  ContentView.m
//  地址选择器
//
//  Created by sTagRD on 2018/1/17.
//  Copyright © 2018年 sTagRD. All rights reserved.
//
#define SCREEN_W [UIScreen mainScreen].bounds.size.width
#define SCREEN_H [UIScreen mainScreen].bounds.size.height
#define TITLETEXT @"请选择"
#define CELLIDENTITY  @"CELLIDENTITY"
#import "ContentView.h"

//NSString const *CELLIDENTITY = @"CELLIDENTITY";

@interface ContentView()<UITableViewDelegate,UITableViewDataSource>

//这是最上面的容器用来装三个控件
@property (nonatomic, strong) UIView *topView;
@property (nonatomic, strong) UIButton *cancelButton;
@property (nonatomic, strong) UIButton *downButton;
@property (nonatomic, strong) UILabel *titleLable;
//显示选择省份 城市 区级的三个label
@property (nonatomic, strong) UIView *secondView;
@property (nonatomic, strong) UILabel *proVincesLabel;
@property (nonatomic, strong) UILabel *cityLabel;
@property (nonatomic, strong) UILabel *areaLabel;

//创建一个大的scrView上面分别装三个不同的tableView用来展示上面对应的数据
@property (nonatomic, strong) UIScrollView *contentScrollView;
@property (nonatomic, strong) UITableView *proVincesTableView;
@property (nonatomic, strong) UITableView *cityTableView;
@property (nonatomic, strong) UITableView *areaTableView;

//
@property (nonatomic, strong) NSDictionary *datasourceDictionary;

@property (nonatomic, strong) NSDictionary *cityDictionary;


@end

@implementation ContentView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initDataSource];
        self.backgroundColor = [UIColor whiteColor];
        //
        [self addSubview:self.contentScrollView];
        [self.contentScrollView addSubview:self.proVincesTableView];
        [self.contentScrollView addSubview:self.cityTableView];
        [self.contentScrollView addSubview:self.areaTableView];
        //
        [self.topView addSubview:self.cancelButton];
        [self.topView addSubview:self.downButton];
        [self.topView addSubview:self.titleLable];
        [self addSubview:self.topView];
        [self.secondView addSubview:self.proVincesLabel];
        [self.secondView addSubview:self.cityLabel];
        [self.secondView addSubview:self.areaLabel];
        [self addSubview:self.secondView];
        
        
    }
    return self;
}

- (NSDictionary *)datasourceDictionary {
    if (!_datasourceDictionary) {
        _datasourceDictionary = [[NSDictionary alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"老铁" ofType:@"plist"]];
    }
    return _datasourceDictionary;
}

- (void)setAddressString:(NSString *)addressString {
    _addressString = addressString;
    if (addressString.length > 0) {
        NSArray *stringArray = [addressString componentsSeparatedByString:@"-"];
        _proVincesLabel.text = stringArray[0];
        _cityLabel.text = stringArray[1];
        _areaLabel.text = stringArray[2];
    }
}

//初始化数据源
- (void)initDataSource {
    [self.datasourceDictionary enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        [self.provincesArray addObject:key];
    }];
}

- (void)setSecondDataSource:(NSString *)provincesString {
    [self.cityArray removeAllObjects];
    self.cityDictionary = [self.datasourceDictionary objectForKey:provincesString];
    for (NSString *string in self.cityDictionary) {
        [self.cityArray addObject:string];
    }
}

- (void)setAreaDataSource:(NSString *)cityString {
    [self.areaArray removeAllObjects];
    NSDictionary *areaDatasource = [self.cityDictionary objectForKey:cityString];
    for (NSString *string in areaDatasource) {
        [self.areaArray addObject:string];
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
    //
    [_contentScrollView setFrame:CGRectMake(0, 80, SCREEN_W, SCREEN_H / 2 - 80)];
    [_proVincesTableView setFrame:CGRectMake(0, 0, SCREEN_W, SCREEN_H / 2 - 80)];
    [_cityTableView setFrame:CGRectMake(SCREEN_W, 0, SCREEN_W, SCREEN_H / 2 - 80)];
    [_areaTableView setFrame:CGRectMake(SCREEN_W * 2, 0, SCREEN_W, SCREEN_H / 2 - 80)];
    
    //
    [_cancelButton setFrame:CGRectMake(10, 5, 60, 30)];
    [_downButton setFrame:CGRectMake(SCREEN_W - 70, 5, 60, 30)];
    [_titleLable setFrame:CGRectMake(70, 5, SCREEN_W - 140, 30)];
    [_topView setFrame:CGRectMake(0, 0, SCREEN_W, 40)];
    //
    [_proVincesLabel setFrame:CGRectMake(0, 0, SCREEN_W / 3, 40)];
    [_cityLabel setFrame:CGRectMake(SCREEN_W / 3, 0, SCREEN_W / 3, 40)];
    [_areaLabel setFrame:CGRectMake(SCREEN_W / 3 * 2, 0, SCREEN_W / 3, 40)];
    [_secondView setFrame:CGRectMake(0, 40, SCREEN_W, 40)];
}

#pragma mark ----主要内容的控件懒加载----
- (UIScrollView *)contentScrollView {
    if (!_contentScrollView) {
        _contentScrollView = [[UIScrollView alloc] init];
        _contentScrollView.contentSize = CGSizeMake(SCREEN_W * 3, SCREEN_H / 2 - 80);
        _contentScrollView.backgroundColor = [UIColor lightGrayColor];
        _contentScrollView.scrollEnabled = NO;
    }
    return _contentScrollView;
}

- (UITableView *)proVincesTableView {
    if (!_proVincesTableView) {
        _proVincesTableView = [[UITableView alloc] init];
        _proVincesTableView.delegate = self;
        _proVincesTableView.dataSource = self;
        _proVincesTableView.backgroundColor = [[UIColor redColor] colorWithAlphaComponent:0.3];
    }
    return _proVincesTableView;
}

- (UITableView *)cityTableView {
    if (!_cityTableView) {
        _cityTableView = [[UITableView alloc] init];
        _cityTableView.delegate = self;
        _cityTableView.dataSource = self;
        _cityTableView.backgroundColor = [[UIColor yellowColor] colorWithAlphaComponent:0.3];
    }
    return _cityTableView;
}

- (UITableView *)areaTableView {
    if (!_areaTableView) {
        _areaTableView = [[UITableView alloc] init];
        _areaTableView.delegate = self;
        _areaTableView.dataSource = self;
        _areaTableView.backgroundColor = [[UIColor greenColor] colorWithAlphaComponent:0.3];
    }
    return _areaTableView;
}

#pragma mark ----第一栏的控件懒加载----
- (UIView *)topView {
    if (!_topView) {
        _topView = [[UIView alloc] init];
        _topView.backgroundColor = [UIColor darkGrayColor];
    }
    return _topView;
}

- (UILabel *)titleLable {
    if (!_titleLable) {
        _titleLable = [[UILabel alloc] init];
        _titleLable.textAlignment = NSTextAlignmentCenter;
        [_titleLable setTextColor:[UIColor whiteColor]];
        NSMutableAttributedString *attributedString = [self setAttributedString:@"老铁" firstStringSize:32 secondString:@"没毛病" secondStringSize:12];
        [_titleLable setAttributedText:attributedString];
    }
    return _titleLable;
}

#pragma mark ----刚写到这里的时候一个老铁问我富文本的问题,我就顺势写了这个接口-----
- (NSMutableAttributedString *)setAttributedString:(NSString *)firstSting
                                   firstStringSize:(CGFloat)firstSize
                                      secondString:(NSString *)secondString secondStringSize:(CGFloat)secondSize {
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc]init];
    
    //设置字体格式和大小
    NSDictionary *dictAttr0 = @{NSFontAttributeName:[UIFont systemFontOfSize:firstSize]};
    NSAttributedString *attr0 = [[NSAttributedString alloc]initWithString:firstSting attributes:dictAttr0];
    [attributedString appendAttributedString:attr0];
    
    //设置字体颜色
    NSDictionary *dictAttr1 = @{NSFontAttributeName:[UIFont systemFontOfSize:secondSize]};
    NSAttributedString *attr1 = [[NSAttributedString alloc]initWithString:secondString attributes:dictAttr1];
    [attributedString appendAttributedString:attr1];
    return attributedString;
}

- (UIButton *)cancelButton {
    if (!_cancelButton) {
        _cancelButton = [[UIButton alloc] init];
        [_cancelButton setTitle:@"cancel" forState:UIControlStateNormal];
        [_cancelButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_cancelButton addTarget:self action:@selector(cancelAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cancelButton;
}

- (UIButton *)downButton {
    if (!_downButton) {
        _downButton = [[UIButton alloc] init];
        [_downButton setTitle:@"down" forState:UIControlStateNormal];
        [_downButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_downButton addTarget:self action:@selector(downAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _downButton;
}

#pragma mark ----第二栏的控件的懒加载----
- (UIView *)secondView {
    if (!_secondView) {
        _secondView = [[UIView alloc] init];
        _secondView.backgroundColor = [UIColor grayColor];
    }
    return _secondView;
}

- (UILabel *)proVincesLabel {
    if (!_proVincesLabel) {
        _proVincesLabel = [[UILabel alloc] init];
        _proVincesLabel.textAlignment = NSTextAlignmentCenter;
        _proVincesLabel.backgroundColor = [[UIColor orangeColor] colorWithAlphaComponent:0.3];
        _proVincesLabel.userInteractionEnabled = YES;
        UITapGestureRecognizer *tapGest = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(jumpProvinceTableView:)];
        [_proVincesLabel addGestureRecognizer:tapGest];
    }
    return _proVincesLabel;
}
//点击省份lable的事件
- (void)jumpProvinceTableView:(UILabel *)senderView {
    if (_proVincesLabel.text.length == 0) {
        return;
    }
    [self reloadScrollViewAndTableView:CGPointMake(0, 0)
                     tableViewIdentity:_proVincesTableView
                    provincesLableText:_proVincesLabel.text
                         cityLableText:_cityLabel.text
                         areaLableText:_areaLabel.text];
}

- (UILabel *)cityLabel {
    if (!_cityLabel) {
        _cityLabel = [[UILabel alloc] init];
        _cityLabel.textAlignment = NSTextAlignmentCenter;
        _cityLabel.backgroundColor = [[UIColor orangeColor] colorWithAlphaComponent:0.3];
        _cityLabel.userInteractionEnabled = YES;
        UITapGestureRecognizer *tapGest = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(jumpCityTableView:)];
        [_cityLabel addGestureRecognizer:tapGest];
    }
    return _cityLabel;
}

- (void)jumpCityTableView:(UILabel *)senderView {
    if (_cityLabel.text.length
        == 0) {
        return;
    }
    [self reloadScrollViewAndTableView:CGPointMake(SCREEN_W, 0)
                     tableViewIdentity:_cityTableView
                    provincesLableText:_proVincesLabel.text
                         cityLableText:_cityLabel.text
                         areaLableText:_areaLabel.text];
}

- (UILabel *)areaLabel {
    if (!_areaLabel) {
        _areaLabel = [[UILabel alloc] init];
        _areaLabel.textAlignment = NSTextAlignmentCenter;
        _areaLabel.backgroundColor = [[UIColor orangeColor] colorWithAlphaComponent:0.3];
        _areaLabel.userInteractionEnabled = YES;
        UITapGestureRecognizer *tapGest = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(jumpAreaTableView:)];
        [_areaLabel addGestureRecognizer:tapGest];
    }
    return _areaLabel;
}

- (void)jumpAreaTableView:(id)senderView {
    if (_areaLabel.text.length == 0) {
        return;
    }
    [self reloadScrollViewAndTableView:CGPointMake(SCREEN_W * 2, 0)
                     tableViewIdentity:_areaTableView
                    provincesLableText:_proVincesLabel.text
                         cityLableText:_cityLabel.text
                         areaLableText:_areaLabel.text];
}

#pragma mark ----数据源的懒加载----
- (NSMutableArray *)provincesArray {
    if (!_provincesArray) {
        _provincesArray = [NSMutableArray arrayWithCapacity:0];
    }
    return _provincesArray;
}

- (NSMutableArray *)cityArray {
    if (!_cityArray) {
        _cityArray = [NSMutableArray arrayWithCapacity:0];
    }
    return _cityArray;
}

- (NSMutableArray *)areaArray {
    if (!_areaArray) {
        _areaArray = [NSMutableArray arrayWithCapacity:0];
    }
    return _areaArray;
}


#pragma mark ----点击事件-----
- (void)cancelAction:(UIButton *)sender {
    if (_cancelActionBlock) {
        _cancelActionBlock();
    }
}

- (void)downAction:(UIButton *)sender {
    if (_areaLabel.text.length == 0 || _cityLabel.text.length == 0 || _proVincesLabel.text.length == 0) {
        return;
    }
    if (_downActionBlock) {
        _downActionBlock([NSString stringWithFormat:@"%@-%@-%@",_proVincesLabel.text,_cityLabel.text,_areaLabel.text]);
    }
}

#pragma mark ----tableview的代理
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (tableView == _proVincesTableView) {
        return self.provincesArray.count;
    }else if (tableView == _cityTableView) {
        return self.cityArray.count;
    }else if (tableView == _areaTableView) {
        return self.areaArray.count;
    }else {
        return 0;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CELLIDENTITY];
    NSString *labelText;
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CELLIDENTITY];
    }
    if (tableView == _proVincesTableView) {
        labelText = self.provincesArray[indexPath.row];
    }else if (tableView == _cityTableView) {
        labelText = self.cityArray[indexPath.row];
    }else if (tableView == _areaTableView) {
        labelText = self.areaArray[indexPath.row];
    }
    cell.textLabel.text = labelText;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView == _proVincesTableView) {
        
        [self setSecondDataSource:self.provincesArray[indexPath.row]];
        
        [self reloadScrollViewAndTableView:CGPointMake(SCREEN_W, 0)
                         tableViewIdentity:_cityTableView
                        provincesLableText:self.provincesArray[indexPath.row]
                             cityLableText:TITLETEXT
                             areaLableText:@""];
        
    }else if (tableView == _cityTableView) {
        [self setAreaDataSource:self.cityArray[indexPath.row]];
        [self reloadScrollViewAndTableView:CGPointMake(SCREEN_W * 2, 0)
                         tableViewIdentity:_areaTableView
                        provincesLableText:_proVincesLabel.text
                             cityLableText:self.cityArray[indexPath.row]
                             areaLableText:TITLETEXT];
    }else if (tableView == _areaTableView) {
        _areaLabel.text = self.areaArray[indexPath.row];
    }
}

//选择对应的cell做出不同的的改变
- (void)reloadScrollViewAndTableView:(CGPoint)contentOffset
                   tableViewIdentity:(UITableView *)tableViewIdentity
                  provincesLableText:(NSString *)provincesLableText
                       cityLableText:(NSString *)cityLableText
                       areaLableText:(NSString *)areaLableText{
    _proVincesLabel.text = provincesLableText;
    _cityLabel.text = cityLableText;
    _areaLabel.text = areaLableText;
    [_contentScrollView setContentOffset:contentOffset animated:YES];
    [tableViewIdentity reloadData];
}

@end
