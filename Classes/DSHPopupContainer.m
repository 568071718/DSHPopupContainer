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

@interface _DSHContainerBackgroundView : UIControl
@property (assign ,nonatomic) BOOL penetrable;
@end
@implementation _DSHContainerBackgroundView
- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {UIView *view = [super hitTest:point withEvent:event]; if (_penetrable && view == self) return nil; return view;}
@end

@interface DSHPopupContainer ()

@property (weak ,nonatomic ,readonly) UIView *containerView;
@property (strong ,nonatomic) UIView <DSHCustomPopupView>*customPopupView;
@property (strong ,nonatomic ,readonly) UIControl *backgroudControl;
@end

@implementation DSHPopupContainer

+ (DSHPopupContainer *)findContainerFromView:(UIView *)view; {
    return [self findContainersFromView:view].firstObject;
}

+ (__kindof UIView <DSHCustomPopupView>*)findPopupViewFromView:(UIView *)view class:(Class)aClass; {
    return [self findPopupViewsFromView:view class:aClass].firstObject;
}

+ (NSArray <DSHPopupContainer *>*)findContainersFromView:(UIView *)view; {
    if (view) {
        NSMutableArray *result = [NSMutableArray array];
        for (DSHPopupContainer *subview in view.subviews) {
            if ([subview isKindOfClass:[DSHPopupContainer class]]) {
                [result addObject:subview];
            }
        }
        return result;
    }
    return nil;
}

+ (NSArray <__kindof UIView <DSHCustomPopupView>*>*)findPopupViewsFromView:(UIView *)view class:(Class)aClass; {
    if (view && aClass) {
        NSArray *array = [self findContainersFromView:view];
        if (array.count > 0) {
            NSMutableArray *result = [NSMutableArray array];
            for (DSHPopupContainer *container in array) {
                for (UIView *subview in container.subviews) {
                    if ([subview conformsToProtocol:@protocol(DSHCustomPopupView)] && [subview isMemberOfClass:aClass]) {
                        [result addObject:subview];
                    }
                }
            }
            return result;
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
        _penetrable = NO;
        
        _backgroudControl = [[_DSHContainerBackgroundView alloc] init];
        _backgroudControl.autoresizingMask = self.autoresizingMask;
        _backgroudControl.frame = self.bounds;
        _backgroudControl.backgroundColor = _maskColor;
        [(_DSHContainerBackgroundView *)_backgroudControl setPenetrable:_penetrable];
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
        self.backgroudControl.alpha = 0;
    } completion:^(BOOL finished) {
        [self.customPopupView removeFromSuperview]; self.customPopupView = nil;
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
    if (!backgroundColor) {
        [super setBackgroundColor:backgroundColor];
    }
    self.maskColor = backgroundColor;
}

- (void)setPenetrable:(BOOL)penetrable {
    _penetrable = penetrable;
    ((_DSHContainerBackgroundView *)_backgroudControl).penetrable = _penetrable;
}

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {UIView *view = [super hitTest:point withEvent:event]; if (_penetrable && view == self) return nil; return view;}
@end
