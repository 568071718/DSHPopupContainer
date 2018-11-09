//
//  DSHPopupContainer.h
//  tetstst
//
//  Created by 路 on 2018/11/8.
//  Copyright © 2018年 路. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DSHPopupContainer;

typedef NS_ENUM(NSInteger ,DSHPopupContainerBackgroundMode) {
    DSHPopupContainerBackgroundModeBlurExtraLight = UIBlurEffectStyleExtraLight,
    DSHPopupContainerBackgroundModeBlurLight = UIBlurEffectStyleLight,
    DSHPopupContainerBackgroundModeBlurDark = UIBlurEffectStyleDark,
    DSHPopupContainerBackgroundModeDefault,
};

@protocol DSHCustomPopupView <NSObject>
// 自定义弹层动画接口
- (void)willPopupContainer:(DSHPopupContainer *)container; // 准备弹出(初始化弹层位置)
- (void)didPopupContainer:(DSHPopupContainer *)container duration:(NSTimeInterval)duration; // 已弹出(做弹出动画)
- (void)willDismissContainer:(DSHPopupContainer *)container duration:(NSTimeInterval)duration; // 将要移除(做移除动画)
@optional
@property (readonly) DSHPopupContainer *container; // 用来获取当前弹层容器
@end

@protocol DSHPopupContainerDelegate <NSObject>
@optional
- (void)popupContainer:(DSHPopupContainer *)popupContainer willShowCustomView:(UIView <DSHCustomPopupView>*)customPopupView;
- (void)popupContainer:(DSHPopupContainer *)popupContainer willDismissCustomView:(UIView <DSHCustomPopupView>*)customPopupView;
@end

@interface DSHPopupContainer : UIVisualEffectView

- (id)initWithCustomPopupView:(UIView <DSHCustomPopupView>*)customPopupView;
- (id)initWithCustomPopupView:(UIView <DSHCustomPopupView>*)customPopupView containerView:(UIView *)containerView backgroundMode:(DSHPopupContainerBackgroundMode)backgroundMode;
- (void)show;
- (void)dismiss;

@property (assign ,nonatomic) NSTimeInterval showAnimationDuration;
@property (assign ,nonatomic) NSTimeInterval dismissAnimationDuration;
@property (assign ,nonatomic) BOOL maskEnabled; // 蒙层交互开关(点击蒙层自动隐藏，默认YES)
@property (weak ,nonatomic) id <DSHPopupContainerDelegate>delegate;
@end
