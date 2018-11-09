//
//  DSHPopupContainer.m
//  tetstst
//
//  Created by 路 on 2018/11/8.
//  Copyright © 2018年 路. All rights reserved.
//

#import "DSHPopupContainer.h"
#import <objc/runtime.h>

@interface UIView (DSHCustomPopupView)
@property (weak ,nonatomic) DSHPopupContainer *container;
@end
@implementation UIView (DSHCustomPopupView)
- (void)setContainer:(DSHPopupContainer *)container {objc_setAssociatedObject(self, @selector(container), container, 0);}
- (DSHPopupContainer *)container {return objc_getAssociatedObject(self, _cmd);}
@end


@interface DSHPopupContainer ()

@property (weak ,nonatomic ,readonly) UIView *containerView;
@property (strong ,nonatomic ,readonly) UIView <DSHCustomPopupView>*customPopupView;
@property (assign ,nonatomic ,readonly) DSHPopupContainerBackgroundMode backgroundMode;
@end

@implementation DSHPopupContainer

- (id)initWithCustomPopupView:(UIView<DSHCustomPopupView> *)customPopupView {
    return [self initWithCustomPopupView:customPopupView containerView:nil backgroundMode:DSHPopupContainerBackgroundModeDefault];
}
- (id)initWithCustomPopupView:(UIView <DSHCustomPopupView>*)customPopupView containerView:(UIView *)containerView backgroundMode:(DSHPopupContainerBackgroundMode)backgroundMode; {
    if (![customPopupView isKindOfClass:[UIView class]]) return nil;
    UIBlurEffect *blurEffect = [UIBlurEffect effectWithStyle:(UIBlurEffectStyle)backgroundMode];
    if (backgroundMode == DSHPopupContainerBackgroundModeDefault) {
        blurEffect = nil;
    }
    self = [super initWithEffect:blurEffect];
    if (self) {
        self.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        _containerView = containerView;
        if (!_containerView) {
            _containerView = [UIApplication sharedApplication].keyWindow;
        }
        
        _customPopupView = customPopupView;
        _customPopupView.container = self;
        _backgroundMode = backgroundMode;
        _showAnimationDuration = .25;
        _dismissAnimationDuration = .25;
        _maskEnabled = YES;
        
        UIControl *backgroudControl = [[UIControl alloc] init];
        backgroudControl.autoresizingMask = self.autoresizingMask;
        backgroudControl.frame = self.bounds;
        [backgroudControl addTarget:self action:@selector(clickedBackgroudControl:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:backgroudControl];
    } return self;
}

- (void)show; {
    if (self.superview) {
        return;
    }
    
    self.frame = _containerView.bounds;
    
    CAKeyframeAnimation *anim = [CAKeyframeAnimation animationWithKeyPath:@"opacity"];
    anim.values = @[@(0) ,@(1)];
    anim.duration = _showAnimationDuration;
    [self.layer addAnimation:anim forKey:nil];
    
    if ([_delegate respondsToSelector:@selector(popupContainer:willShowCustomView:)]) {
        [_delegate popupContainer:self willShowCustomView:_customPopupView];
    }
    
    [self.contentView addSubview:_customPopupView];
    if ([_customPopupView respondsToSelector:@selector(willPopupContainer:)]) {
        [_customPopupView willPopupContainer:self];
    }
    
    [_containerView addSubview:self];
    if ([_customPopupView respondsToSelector:@selector(didPopupContainer:duration:)]) {
        [_customPopupView didPopupContainer:self duration:_showAnimationDuration];
    }
}

- (void)dismiss; {
    if ([_delegate respondsToSelector:@selector(popupContainer:willDismissCustomView:)]) {
        [_delegate popupContainer:self willDismissCustomView:_customPopupView];
    }
    if ([_customPopupView respondsToSelector:@selector(willDismissContainer:duration:)]) {
        [_customPopupView willDismissContainer:self duration:_dismissAnimationDuration];
    }
    [UIView animateWithDuration:_dismissAnimationDuration animations:^{
        self.alpha = 0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

- (void)clickedBackgroudControl:(id)sender {
    if (_maskEnabled) {
        [self dismiss];
    }
}

@end
