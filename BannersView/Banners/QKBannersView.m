//
//  QKBannersView.m
//  tdxTools
//
//  Created by tdx on 2017/7/24.
//  Copyright © 2017年 qk. All rights reserved.
//

#import "QKBannersView.h"

@interface QKBannersView()
{
    UIWindow                *m_window;
    CGFloat                 m_animaDelay;                               //动画延时
    UIView                  *m_backView;                                //背景视图
    ClickEventBlock         m_block;                                    //按钮回调block
    UIImageView             *m_iconImageView;                           //app图标
    UILabel                 *m_titleLabel;                              //标题
    UILabel                 *m_subTitleLabel;                           //副标题
    UIView                  *m_upView;                                  //上视图
    UIView                  *m_downView;                                //下视图
    UILabel                 *m_titleLabelRight;                         //右侧文字
}

@end

@implementation QKBannersView

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        m_animaDelay = 0.7;
        _windowLevel = UIWindowLevelAlert;
        _showTime = 2;
        _windowHeight = 100;
        _upBackgroundColor = [UIColor colorWithRed:200.0f/255.0f green:195.0f/255.0f blue:197.0f/255.0f alpha:1];
        _downBackgroundColor = [UIColor colorWithRed:206.0f/255.0f green:180.0f/255.0f blue:182.0f/255.0f alpha:1];
        _upFontSize = 14;
        _downFontSize = 14;
        _upTextColor = [UIColor colorWithRed:91/255.0f green:91/255.0f blue:91/255.0f alpha:1];
        _downTextColor = [UIColor blackColor];
        
        m_window = [[UIWindow alloc] init];
        m_window.frame = CGRectMake(0, -_windowHeight, [UIScreen mainScreen].bounds.size.width, _windowHeight);
        /** window的显示级别 */
        m_window.windowLevel = self.windowLevel;
        m_window.hidden = NO;
        m_window.backgroundColor = [UIColor clearColor];
        
        m_backView = [[UIView alloc] initWithFrame:CGRectMake(10, 5, m_window.frame.size.width-20, m_window.frame.size.height-15)];
        m_backView.layer.cornerRadius = 10;
        m_backView.backgroundColor = [UIColor clearColor];
        m_backView.layer.masksToBounds = true;
        [m_window addSubview:m_backView];
        
        m_upView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, m_backView.frame.size.width, 30)];        //cab9ba
        m_upView.clipsToBounds = YES;
        [m_backView addSubview:m_upView];
        
        m_downView = [[UIView alloc] initWithFrame:CGRectMake(0, m_upView.frame.size.height, m_backView.frame.size.width, m_backView.frame.size.height-m_upView.frame.size.height)];        //caabac
        m_downView.clipsToBounds = YES;
        [m_backView addSubview:m_downView];
        
        //点击手势
        UITapGestureRecognizer *singleFingerTap =
        [[UITapGestureRecognizer alloc] initWithTarget:self
                                                action:@selector(btnClick:)];
        [m_upView addGestureRecognizer:singleFingerTap];
        [m_downView addGestureRecognizer:singleFingerTap];
        
        //上滑手势
        UISwipeGestureRecognizer *recognizer = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(handleSwipeFrom:)];
        [recognizer setDirection:(UISwipeGestureRecognizerDirectionUp)];
        [m_upView addGestureRecognizer:recognizer];
        [m_downView addGestureRecognizer:recognizer];
        
        m_subTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, m_backView.frame.size.width-20, m_downView.frame.size.height-10)];        //f8a9a1
        m_subTitleLabel.backgroundColor = [UIColor clearColor];
        m_subTitleLabel.clipsToBounds = YES;
        m_subTitleLabel.numberOfLines = 2;
        [m_downView addSubview:m_subTitleLabel];
        
        m_iconImageView = [[UIImageView alloc] initWithFrame:CGRectMake(8, 5, 20, 20)];
        m_iconImageView.layer.cornerRadius = 5;
        m_iconImageView.layer.masksToBounds = YES;
        [m_upView addSubview:m_iconImageView];
        m_titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(35, 5, 100, 20)];
        m_titleLabel.textAlignment = NSTextAlignmentLeft;
        [m_upView addSubview:m_titleLabel];
        
        m_titleLabelRight = [[UILabel alloc] initWithFrame:CGRectMake(m_upView.frame.size.width-60, 5, 40, 20)];
        m_titleLabelRight.textColor = _upTextColor;
        m_titleLabelRight.text = @"现在";
        m_titleLabelRight.textAlignment = NSTextAlignmentRight;
        [m_upView addSubview:m_titleLabelRight];

    }
    return self;
}

+ (QKBannersView*)sharedInstance
{
    static QKBannersView *sharedSingleton = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedSingleton = [[self alloc] init];
    });
    return sharedSingleton;
}


- (void)showWindow
{
    m_upView.backgroundColor = _upBackgroundColor;
    m_downView.backgroundColor = _downBackgroundColor;
    m_subTitleLabel.font = [UIFont systemFontOfSize:_downFontSize];
    m_subTitleLabel.textColor = _downTextColor;
    m_titleLabel.textColor = _upTextColor;
    m_titleLabel.font = [UIFont systemFontOfSize:_upFontSize];
    m_titleLabelRight.font = [UIFont systemFontOfSize:_upFontSize];
    /** 添加动画 */
    [UIView animateWithDuration:m_animaDelay animations:^{
        CGRect windowF = m_window.frame;
        windowF.origin.y = 0;
        m_window.frame = windowF;
    }];
}

- (void)showMessage:(NSString *)message showTitle:(NSString *)title animaDelay:(CGFloat)animaDelay icon:(UIImage *)iconImage clickEvent:(ClickEventBlock)callBackBlock configuration:(ConfigBlock)configBlock
{
    m_animaDelay = animaDelay;
    m_block = callBackBlock;
    
    configBlock();
    
    CGSize size = [message sizeWithAttributes:@{NSFontAttributeName: [UIFont systemFontOfSize:_downFontSize]}];
    if (size.width < m_window.frame.size.width - 40)
    {
        m_backView.frame = CGRectMake(10, 5, m_window.frame.size.width-20, 70);
        m_downView.frame = CGRectMake(0, m_upView.frame.size.height, m_backView.frame.size.width, m_backView.frame.size.height-m_upView.frame.size.height);
        m_subTitleLabel.frame = CGRectMake(10, 5, m_backView.frame.size.width-20, m_downView.frame.size.height-10);
        m_subTitleLabel.numberOfLines = 1;
    }
    else
    {
        m_backView.frame = CGRectMake(10, 5, m_window.frame.size.width-20, m_window.frame.size.height-15);
        m_downView.frame = CGRectMake(0, m_upView.frame.size.height, m_backView.frame.size.width, m_backView.frame.size.height-m_upView.frame.size.height);
        m_subTitleLabel.frame = CGRectMake(10, 5, m_backView.frame.size.width-20, m_downView.frame.size.height-10);
        m_subTitleLabel.numberOfLines = 2;
    }
    
    [self showWindow];
    m_subTitleLabel.text = message;
    
    m_iconImageView.image = iconImage;
    m_titleLabel.text = title;
    
    [self performSelector:@selector(hidden) withObject:nil afterDelay:self.showTime];
}


- (void)hidden
{
    [UIView animateWithDuration:m_animaDelay animations:^{
        CGRect windowF = m_window.frame;
        windowF.origin.y = - _windowHeight;
        m_window.frame = windowF;
    } completion:^(BOOL finished) {
        
    }];
}

- (void)btnClick:(id)sender
{
    if (m_block)
    {
        m_block(sender);
    }
}

- (void)handleSwipeFrom:(id)sender
{
    [UIView animateWithDuration:m_animaDelay animations:^{
        CGRect windowF = m_window.frame;
        windowF.origin.y = - _windowHeight;
        m_window.frame = windowF;
    } completion:^(BOOL finished) {
        
    }];
}
@end
