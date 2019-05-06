//
//  DSHAlertObject.m
//  Demo
//
//  Created by 路 on 2019/5/5.
//  Copyright © 2019年 路. All rights reserved.
//

#import "DSHAlertObject.h"

@implementation DSHAlertObject

- (id)init {
    self = [super init];
    if (self) {
        _insets = UIEdgeInsetsMake(0, 0, 0, 0);
        _alignment = NSTextAlignmentCenter;
        _attributes = [NSMutableDictionary dictionary];
        _backgroundColor = [UIColor whiteColor];
        self.font = [UIFont systemFontOfSize:15];
        self.color = [UIColor blackColor];
    } return self;
}

- (void)setFont:(UIFont *)font {
    _font = font;
    [_attributes setObject:_font forKey:NSFontAttributeName];
}

- (void)setColor:(UIColor *)color {
    _color = color;
    [_attributes setObject:_color forKey:NSForegroundColorAttributeName];
}

+ (DSHAlertObject *)makeTitle:(NSString *)text; {
    DSHAlertObject *object = [[DSHAlertObject alloc] init];
    object.text = text;
    object.insets = UIEdgeInsetsMake(15, 15, 7.5, 15);
    object.font = [UIFont systemFontOfSize:17];
    object.type = DSHAlertTitleObject;
    object.color = [UIColor blackColor];
    return object;
}

+ (DSHAlertObject *)makeMessage:(NSString *)text; {
    DSHAlertObject *object = [[DSHAlertObject alloc] init];
    object.text = text;
    object.insets = UIEdgeInsetsMake(7.5, 15, 15, 15);
    object.font = [UIFont systemFontOfSize:14];
    object.type = DSHAlertMessageObject;
    object.color = [UIColor lightGrayColor];
    return object;
}

+ (DSHAlertObject *)makeOption:(NSString *)text; {
    DSHAlertObject *object = [[DSHAlertObject alloc] init];
    object.text = text;
    object.insets = UIEdgeInsetsMake(15, 5, 15, 5);
    object.font = [UIFont systemFontOfSize:15];
    object.type = DSHAlertOptionObject;
    object.color = [UIColor darkTextColor];
    return object;
}

@end
