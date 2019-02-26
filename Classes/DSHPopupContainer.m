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
@property (strong ,nonatomic ,readonly) UIControl *backgroudControl;
@end

@implementation DSHPopupContainer

+ (DSHPopupContainer *)findContainerFromView:(UIView *)view; {
    if (view) {
        for (DSHPopupContainer *subview in view.subviews) {
            if ([subview isKindOfClass:[DSHPopupContainer class]]) {
                return subview;
            }
        }
    }
    return nil;
}

+ (__kindof UIView <DSHCustomPopupView>*)findPopupViewFromView:(UIView *)view class:(Class)aClass; {
    if (view && aClass) {
        DSHPopupContainer *container = [DSHPopupContainer findContainerFromView:view];
        if (container) {
            for (UIView *subview in container.subviews) {
                if ([subview conformsToProtocol:@protocol(DSHCustomPopupView)] && [subview isMemberOfClass:aClass]) {
                    return (UIView <DSHCustomPopupView>*)subview;
                }
            }
        }
    }
    return nil;
}

- (id)initWithCustomPopupView:(UIView<DSHCustomPopupView> *)customPopupView {
    return [self initWithCustomPopupView:customPopupView containerView:nil];
}
- (id)initWithCustomPopupView:(UIView <DSHCustomPopupView>*)customPopupView containerView:(UIView *)containerView; {
    if (![customPopupView isKindOfClass:[UIView class]]) return nil;
    self = [super initWithFrame:containerView.bounds];
    if (self) {
        self.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        self.backgroundColor = nil;
        _containerView = containerView;
        if (!_containerView) {
            _containerView = [UIApplication sharedApplication].keyWindow;
        }
        
        _customPopupView = customPopupView;
        _customPopupView.container = self;
        _showAnimationDuration = .25;
        _dismissAnimationDuration = .25;
        _autoDismissWhenClickedBackground = YES;
        _maskColor = nil;
        
        _backgroudControl = [[UIControl alloc] init];
        _backgroudControl.autoresizingMask = self.autoresizingMask;
        _backgroudControl.frame = self.bounds;
        _backgroudControl.backgroundColor = _maskColor;
        [_backgroudControl addTarget:self action:@selector(clickedBackgroudControl:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_backgroudControl];
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
    [self.backgroudControl.layer addAnimation:anim forKey:nil];
    
    if ([_delegate respondsToSelector:@selector(popupContainer:willShowCustomView:)]) {
        [_delegate popupContainer:self willShowCustomView:_customPopupView];
    }
    
    [self addSubview:_customPopupView];
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
    if (_autoDismissWhenClickedBackground) {
        [self dismiss];
    }
}

- (void)setMaskColor:(UIColor *)maskColor {
    _maskColor = maskColor;
    _backgroudControl.backgroundColor = _maskColor;
}

- (void)setBackgroundColor:(UIColor *)backgroundColor {
    if (backgroundColor) {
        self.maskColor = backgroundColor;
    } else {
        [super setBackgroundColor:backgroundColor];
    }
}

@end
