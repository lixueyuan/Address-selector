# Address-selector
一个简单的地址选择器



SelectCityViewController *selectVc = [[SelectCityViewController alloc] init];
#设置模态弹出时的状态(避免黑屏)
selectVc.modalPresentationStyle = UIModalPresentationOverCurrentContext;
//选择完毕后点击确认按钮的回调
selectVc.yourAddressBlock = ^(NSString *addressString) {
[_addressButton setTitle:addressString forState:UIControlStateNormal];
};
//将选中的地址回传
if (![self.addressButton.titleLabel.text isEqualToString:@"老铁,选择地址"]) {
selectVc.oldAddressString = self.addressButton.titleLabel.text;
};
[self presentViewController:selectVc animated:YES completion:nil];



[老铁git](https://github.com/lixueyuan)

