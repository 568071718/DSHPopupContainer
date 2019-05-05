//
//  DSHAlertViewCell.m
//  Demo
//
//  Created by 路 on 2019/5/5.
//  Copyright © 2019年 路. All rights reserved.
//

#import "DSHAlertViewCell.h"

@implementation DSHAlertViewCell

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        _label = [[UILabel alloc] init];
        _label.numberOfLines = 0;
        [self addSubview:_label];
    } return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    _label.frame = ({
        CGRect frame = self.bounds;
        frame.origin.x = _data.insets.left;
        frame.origin.y = _data.insets.top;
        frame.size.width = frame.size.width - _data.insets.left - _data.insets.right;
        frame.size.height = frame.size.height - _data.insets.top - _data.insets.bottom;
        frame;
    });
}

- (void)setData:(DSHAlertObject *)data {
    _data = data;
    _label.textAlignment = _data.alignment;
    _label.font = _data.font;
    _label.textColor = _data.color;
    if (_data.attributedText) {
        _label.attributedText = _data.attributedText;
    } else {
        _label.attributedText = [[NSAttributedString alloc] initWithString:_data.text attributes:_data.attributes];
    }
    self.backgroundColor = _data.backgroundColor;
    [self setNeedsLayout];
}

@end
