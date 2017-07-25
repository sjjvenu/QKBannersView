//
//  ViewController.m
//  BannersView
//
//  Created by tdx on 2017/7/25.
//  Copyright © 2017年 sjjvenu. All rights reserved.
//

#import "ViewController.h"
#import "QKBannersView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)showNotification:(id)sender {
    
    __weak typeof (self) weakSelft = self;
    [[QKBannersView sharedInstance] showMessage:@"一段很长的文字内容测试，一段很长的文字内容测试，一段很长的文字内容测试" showTitle:@"Logo" animaDelay:0.3 icon:[UIImage imageNamed:@"icon"] clickEvent:^(id sender) {
        [weakSelft btnTitleClick:sender];
    } configuration:^{
        [QKBannersView sharedInstance].showTime = 5;
    }];
}

- (void)btnTitleClick:(id)sender
{
    
}

@end
