//
//  DemoCustomView1.m
//  Demo
//
//  Created by 路 on 2019/2/20.
//  Copyright © 2019年 路. All rights reserved.
//

#import "DemoCustomView1.h"

@implementation DemoCustomView1

- (id)init {
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor lightGrayColor];
        self.layer.cornerRadius = 10.f;
        self.clipsToBounds = YES;
    } return self;
}

// 准备弹出(初始化弹层位置)
- (void)willPopupContainer:(DSHPopupContainer *)container; {
    CGRect frame = self.frame;
    frame.size = CGSizeMake(315, 350);
    frame.origin.x = (container.frame.size.width - frame.size.width) * .5;
    frame.origin.y = - frame.size.height;
    self.frame = frame;
}

// 已弹出(做弹出动画)
- (void)didPopupContainer:(DSHPopupContainer *)container duration:(NSTimeInterval)duration; {
    CGRect frame = self.frame;
    frame.origin.y = (container.frame.size.height - frame.size.height) * .5;
    [UIView animateWithDuration:duration
                          delay:0.f
         usingSpringWithDamping:.7
          initialSpringVelocity:.1
                        options:UIViewAnimationOptionCurveLinear
                     animations:^{
                         self.frame = frame;
                     }
                     completion:nil];
}

// 将要移除(做移除动画)
- (void)willDismissContainer:(DSHPopupContainer *)container duration:(NSTimeInterval)duration; {
    [UIView animateWithDuration:duration
                          delay:0.f
         usingSpringWithDamping:.7
          initialSpringVelocity:.1
                        options:UIViewAnimationOptionCurveLinear
                     animations:^{
                         [self willPopupContainer:container];
                     }
                     completion:nil];
}

@end
