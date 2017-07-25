//
//  QKBannersView.h
//  tdxTools
//
//  Created by tdx on 2017/7/24.
//  Copyright © 2017年 qk. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ClickEventBlock)(id sender);
typedef void(^ConfigBlock)(void);

@interface QKBannersView : NSObject

/**
 *  窗口的优先级
 */
@property (nonatomic, assign)UIWindowLevel          windowLevel;            //视图显示级别
@property (nonatomic, assign)CGFloat                windowHeight;           //视图高度
@property (nonatomic, assign)NSInteger              showTime;               //视图显示时长
@property (nonatomic, copy)UIColor                  *upBackgroundColor;     //上背景
@property (nonatomic, copy)UIColor                  *downBackgroundColor;   //下背景
@property (nonatomic, assign)CGFloat                upFontSize;             //上文字大小
@property (nonatomic, assign)CGFloat                downFontSize;           //下文字大小
@property (nonatomic, copy)UIColor                  *upTextColor;           //上文字颜色
@property (nonatomic, copy)UIColor                  *downTextColor;         //下文字颜色

+ (QKBannersView*)sharedInstance;


/**

 @param message 消息内容
 @param title 消息标题
 @param animaDelay 视图动画时间
 @param iconImage 图标
 @param callBackBlock 点击视图事件回调
 @param configBlock 配置事件
 */
- (void)showMessage:(NSString *)message showTitle:(NSString *)title animaDelay:(CGFloat)animaDelay icon:(UIImage *)iconImage clickEvent:(ClickEventBlock)callBackBlock configuration:(ConfigBlock)configBlock;

@end
