//
//  DSHAlertView.h
//  Demo
//
//  Created by 路 on 2019/5/5.
//  Copyright © 2019年 路. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DSHAlertObject.h"

typedef NS_ENUM(NSUInteger ,DSHAlertViewLineMode) {
    DSHAlertViewLineModeNone                = 0,
    DSHAlertViewTitleAndMessageLineHidden   = 1 << 0, // 隐藏标题和内容间的分隔线 (默认)
    DSHAlertViewOptionLineHidden            = 1 << 1, // 隐藏选项区域的分隔线
};

@class DSHAlertView;
@protocol DSHAlertViewDelegate <NSObject>
@optional
- (void)alertView:(DSHAlertView *)alertView clickedOptionWithOptionIndex:(NSInteger)index;
@end

@interface DSHAlertView : UIView

- (id)initWithObjects:(NSArray <DSHAlertObject *>*)objects;
@property (weak ,nonatomic) id <DSHAlertViewDelegate>delegate;
@property (assign ,nonatomic) DSHAlertViewLineMode lineMode;
- (void)show;
- (void)dismiss;

@property (strong ,nonatomic) id info; // 携带数据
@end
