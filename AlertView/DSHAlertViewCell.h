//
//  DSHAlertViewCell.h
//  Demo
//
//  Created by 路 on 2019/5/5.
//  Copyright © 2019年 路. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DSHAlertObject.h"

@interface DSHAlertViewCell : UICollectionViewCell

@property (strong ,nonatomic) UILabel *label;
@property (weak ,nonatomic) DSHAlertObject *data;
@end
