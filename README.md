# QKBannersView
通知弹窗，仿系统Banners模式



使用方式：
将QKBannersView.h和QKBannersView.m添加到要使用的工程中，在需要使用的地方添加QKBannersView.h头文件。
Demo中有使用示例：

```objc
[[QKBannersView sharedInstance] showMessage:@"标题" showTitle:@"Logo" animaDelay:0.3 icon:[UIImage imageNamed:@"icon"] clickEvent:^(id sender) {
        //[weakSelft btnTitleClick:sender];
    } configuration:^{
        [QKBannersView sharedInstance].showTime = 5;
    }];
```

第一个block是点击事件的回调，可以这个block中完成点击所需要处理的事件；第二个block是对该视图做的一些配置，支持的配置有：
```objc
@property (nonatomic, assign)UIWindowLevel          windowLevel;            //视图显示级别
@property (nonatomic, assign)CGFloat                windowHeight;           //视图高度
@property (nonatomic, assign)NSInteger              showTime;               //视图显示时长
@property (nonatomic, copy)UIColor                  *upBackgroundColor;     //上背景
@property (nonatomic, copy)UIColor                  *downBackgroundColor;   //下背景
@property (nonatomic, assign)CGFloat                upFontSize;             //上文字大小
@property (nonatomic, assign)CGFloat                downFontSize;           //下文字大小
@property (nonatomic, copy)UIColor                  *upTextColor;           //上文字颜色
@property (nonatomic, copy)UIColor                  *downTextColor;         //下文字颜色
```

![image](http://wx2.sinaimg.cn/mw690/a9a6744agy1fhvy4gue8kj20bi0l23yr.jpg)
![image](http://wx1.sinaimg.cn/mw690/a9a6744agy1fhvy3d6mhzj20bi0l2aag.jpg)
