//
//  DemoCustomView2.m
//  Demo
//
//  Created by 路 on 2019/2/20.
//  Copyright © 2019年 路. All rights reserved.
//

#import "DemoCustomView2.h"

@implementation DemoCustomView2

- (id)init {
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.layer.cornerRadius = 10;
        self.clipsToBounds = YES;
    } return self;
}

// 准备弹出(初始化弹层位置)
- (void)willPopupContainer:(DSHPopupContainer *)container; {
    CGRect frame = self.frame;
    frame.size = CGSizeMake(288, 333);
    frame.origin.x = (container.frame.size.width - frame.size.width) * .5;
    frame.origin.y = (container.frame.size.height - frame.size.height) * .5;
    self.frame = frame;
}

// 已弹出(做弹出动画)
- (void)didPopupContainer:(DSHPopupContainer *)container duration:(NSTimeInterval)duration; {
    self.transform = CGAffineTransformMakeScale(1.1, 1.1);
    [UIView animateWithDuration:duration animations:^{
        self.transform = CGAffineTransformMakeScale(1.f, 1.f);
    }];
}

// 将要移除(做移除动画)
- (void)willDismissContainer:(DSHPopupContainer *)container duration:(NSTimeInterval)duration; {
    CGRect frame = self.frame;
    frame.origin.y = container.frame.size.height;
    [UIView animateWithDuration:duration animations:^{
        self.alpha = 0.f;
    }];
}

@end
