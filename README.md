# QKBannersView
通知弹窗，仿系统Banners模式



使用方式：
将QKBannersView.h和QKBannersView.m添加到要使用的工程中，在需要使用的地方添加QKBannersView.h头文件。
Demo中有使用示例：
[[QKBannersView sharedInstance] showMessage:@"标题" showTitle:@"Logo" animaDelay:0.3 icon:[UIImage imageNamed:@"icon"] clickEvent:^(id sender) {
        //[weakSelft btnTitleClick:sender];
    } configuration:^{
        [QKBannersView sharedInstance].showTime = 5;
    }];
