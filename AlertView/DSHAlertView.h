//
//  DSHAlertView.h
//  Demo
//
//  Created by 路 on 2019/5/5.
//  Copyright © 2019年 路. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DSHAlertObject.h"

@class DSHAlertView;
@protocol DSHAlertViewDelegate <NSObject>
@optional
- (void)alertView:(DSHAlertView *)alertView clickedOptionWithOptionIndex:(NSInteger)index;
@end

@interface DSHAlertView : UIView

- (id)initWithObjects:(NSArray <DSHAlertObject *>*)objects;
@property (weak ,nonatomic) id <DSHAlertViewDelegate>delegate;
- (void)show;
- (void)dismiss;

@property (strong ,nonatomic) id info; // 携带数据
@end
