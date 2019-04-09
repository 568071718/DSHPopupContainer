//
//  DSHPopupContainer.h
//  tetstst
//
//  Created by 路 on 2018/11/8.
//  Copyright © 2018年 路. All rights reserved.
//  弹层容器

#import <UIKit/UIKit.h>

@class DSHPopupContainer;
@protocol DSHCustomPopupView <NSObject>
// 准备弹出(初始化弹层位置)
- (void)willPopupContainer:(DSHPopupContainer *)container;
// 已弹出(做弹出动画)
- (void)didPopupContainer:(DSHPopupContainer *)container duration:(NSTimeInterval)duration;
// 将要移除(做移除动画)
- (void)willDismissContainer:(DSHPopupContainer *)container duration:(NSTimeInterval)duration;
@optional
@property (readonly) DSHPopupContainer *container; // 用来获取当前弹层容器
@end

@protocol DSHPopupContainerDelegate <NSObject>
@optional
- (void)popupContainer:(DSHPopupContainer *)popupContainer willShowCustomView:(UIView <DSHCustomPopupView>*)customPopupView;
- (void)popupContainer:(DSHPopupContainer *)popupContainer willDismissCustomView:(UIView <DSHCustomPopupView>*)customPopupView;
@end

@interface DSHPopupContainer : UIView

- (id)initWithCustomPopupView:(UIView <DSHCustomPopupView>*)customPopupView;
- (id)initWithCustomPopupView:(UIView <DSHCustomPopupView>*)customPopupView containerView:(UIView *)containerView;
- (void)show;
- (void)dismiss;

@property (assign ,nonatomic) NSTimeInterval showAnimationDuration;
@property (assign ,nonatomic) NSTimeInterval dismissAnimationDuration;
@property (strong ,nonatomic) UIColor *maskColor; // 蒙层背景色 默认:nil
@property (assign ,nonatomic) BOOL penetrable;
@property (assign ,nonatomic) BOOL autoDismissWhenClickedBackground; // 蒙层交互开关(点击蒙层自动隐藏，默认:YES)
@property (weak ,nonatomic) id <DSHPopupContainerDelegate>delegate;

+ (DSHPopupContainer *)findContainerFromView:(UIView *)view DEPRECATED_MSG_ATTRIBUTE("Please use findContainersFromView:");
+ (__kindof UIView <DSHCustomPopupView>*)findPopupViewFromView:(UIView *)view class:(Class)aClass DEPRECATED_MSG_ATTRIBUTE("Please use findPopupViewsFromView::");

+ (NSArray <DSHPopupContainer *>*)findContainersFromView:(UIView *)view;
+ (NSArray <__kindof UIView <DSHCustomPopupView>*>*)findPopupViewsFromView:(UIView *)view class:(Class)aClass;
@end
