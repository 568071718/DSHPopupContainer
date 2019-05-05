//
//  DSHAlertObject.h
//  Demo
//
//  Created by 路 on 2019/5/5.
//  Copyright © 2019年 路. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSInteger {
    DSHAlertTitleObject,
    DSHAlertMessageObject,
    DSHAlertOptionObject,
} DSHAlertObjectType;

@interface DSHAlertObject : NSObject

@property (strong ,nonatomic) UIColor *backgroundColor;
@property (assign ,nonatomic) UIEdgeInsets insets;
@property (assign ,nonatomic) NSTextAlignment alignment;
@property (assign ,nonatomic) DSHAlertObjectType type;

@property (strong ,nonatomic) NSString *text;
@property (strong ,nonatomic) UIFont *font;
@property (strong ,nonatomic) UIColor *color;
@property (strong ,nonatomic ,readonly) NSMutableDictionary *attributes;
@property (strong ,nonatomic) NSAttributedString *attributedText;

+ (DSHAlertObject *)makeTitle:(NSString *)text;
+ (DSHAlertObject *)makeMessage:(NSString *)text;
+ (DSHAlertObject *)makeOption:(NSString *)text;
@end
