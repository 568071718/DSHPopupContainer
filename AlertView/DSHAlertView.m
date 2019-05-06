//
//  DSHAlertView.m
//  Demo
//
//  Created by 路 on 2019/5/5.
//  Copyright © 2019年 路. All rights reserved.
//

#import "DSHAlertView.h"
#import "DSHPopupContainer.h"
#import "DSHAlertViewCell.h"

@interface DSHAlertView () <DSHCustomPopupView ,UICollectionViewDelegateFlowLayout ,UICollectionViewDataSource>

@property (strong ,nonatomic) NSArray <DSHAlertObject *>*objects;
@property (strong ,nonatomic) NSArray <DSHAlertObject *>*options;
@property (strong ,nonatomic) UICollectionView *collectionView;
@end

@implementation DSHAlertView

- (id)initWithObjects:(NSArray <DSHAlertObject *>*)objects; {
    self = [super initWithFrame:CGRectMake(0, 0, 288.f, 0)];
    if (self) {
        
        self.backgroundColor = [UIColor whiteColor];
        self.layer.cornerRadius = 10.f;
        self.layer.masksToBounds = YES;
        
        _lineMode = DSHAlertViewTitleAndMessageLineHidden;
        
        NSMutableArray *list1 = [NSMutableArray array];
        NSMutableArray *list2 = [NSMutableArray array];
        for (DSHAlertObject *obj in objects) {
            if (obj.type == DSHAlertOptionObject) {
                [list2 addObject:obj];
            } else {
                [list1 addObject:obj];
            }
        }
        _objects = [list1 copy];
        _options = [list2 copy];
        
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        _collectionView = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:layout];
        _collectionView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.backgroundColor = [UIColor colorWithRed:233 / 255.f green:233 / 255.f blue:233 / 255.f alpha:1];
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.scrollEnabled = NO;
        [_collectionView registerClass:[DSHAlertViewCell class] forCellWithReuseIdentifier:@"DSHAlertViewCell"];
        [self addSubview:_collectionView];
    } return self;
}

- (void)show {
    DSHPopupContainer *container = [[DSHPopupContainer alloc] initWithCustomPopupView:self];
    container.maskColor = [[UIColor blackColor] colorWithAlphaComponent:.5];
    container.showAnimationDuration = .5;
    [container show];
}

- (void)dismiss {
    [self.container dismiss];
}

#pragma mark -
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView; {
    return 2;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section; {
    if (section == 0) {
        return _objects.count;
    }
    if (section == 1) {
        return _options.count;
    }
    return 0;
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath; {
    if (indexPath.section == 0) {
        DSHAlertObject *rowData = _objects[indexPath.row];
        DSHAlertViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"DSHAlertViewCell" forIndexPath:indexPath];
        cell.data = rowData;
        return cell;
    }
    if (indexPath.section == 1) {
        DSHAlertObject *rowData = _options[indexPath.row];
        DSHAlertViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"DSHAlertViewCell" forIndexPath:indexPath];
        cell.data = rowData;
        return cell;
    }
    return nil;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath; {
    if (indexPath.section == 0) {
        DSHAlertObject *rowData = _objects[indexPath.row];
        CGFloat width = collectionView.frame.size.width;
        NSAttributedString *string = rowData.attributedText;
        if (!string) {
            string = [[NSAttributedString alloc] initWithString:rowData.text attributes:rowData.attributes];
        }
        CGFloat height = [string boundingRectWithSize:CGSizeMake(width - rowData.insets.left - rowData.insets.right, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin context:nil].size.height;
        height = height + rowData.insets.top + rowData.insets.bottom;
        return CGSizeMake(width, height);
    }
    if (indexPath.section == 1) {
        DSHAlertObject *rowData = _options[indexPath.row];
        CGFloat width = collectionView.frame.size.width;
        if (_options.count == 2) {
            CGFloat minimumInteritemSpacing = [self collectionView:collectionView layout:collectionViewLayout minimumInteritemSpacingForSectionAtIndex:indexPath.section];
            width = (width - minimumInteritemSpacing) * .5;
        }
        NSAttributedString *string = rowData.attributedText;
        if (!string) {
            string = [[NSAttributedString alloc] initWithString:rowData.text attributes:rowData.attributes];
        }
        CGFloat height = [string boundingRectWithSize:CGSizeMake(width - rowData.insets.left - rowData.insets.right, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin context:nil].size.height;
        height = height + rowData.insets.top + rowData.insets.bottom;
        return CGSizeMake(width, height);
    }
    return CGSizeZero;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 1) {
        if ([_delegate respondsToSelector:@selector(alertView:clickedOptionWithOptionIndex:)]) {
            [_delegate alertView:self clickedOptionWithOptionIndex:indexPath.row];
        }
    }
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section; {
    if (section == 0) {
        return UIEdgeInsetsZero;
    }
    if (section == 1) {
        if (_options.count > 0) {
            if (_lineMode & DSHAlertViewOptionLineHidden) {
                return UIEdgeInsetsZero;
            } else {
                return UIEdgeInsetsMake(1, 0, 0, 0);
            }
        }
    }
    return UIEdgeInsetsZero;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section; {
    if (section == 0) {
        if (_lineMode & DSHAlertViewTitleAndMessageLineHidden) {
            return 0;
        }
    }
    if (section == 1) {
        if (_lineMode & DSHAlertViewOptionLineHidden) {
            return 0;
        }
    }
    return 1;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section; {
    if (section == 0) {
        if (_lineMode & DSHAlertViewTitleAndMessageLineHidden) {
            return 0;
        }
    }
    if (section == 1) {
        if (_lineMode & DSHAlertViewOptionLineHidden) {
            return 0;
        }
    }
    return 1;
}

#pragma mark -
- (void)willPopupContainer:(DSHPopupContainer *)container; {
    CGRect bounds = self.bounds;
    bounds.size.height = _collectionView.collectionViewLayout.collectionViewContentSize.height;
    self.bounds = bounds;
    self.center = CGPointMake(container.frame.size.width * .5, container.frame.size.height * .5);
}

- (void)didPopupContainer:(DSHPopupContainer *)container duration:(NSTimeInterval)duration; {
    self.transform = CGAffineTransformMakeScale(1.1, 1.1);
    [UIView animateWithDuration:duration delay:0 usingSpringWithDamping:.5 initialSpringVelocity:.1 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.transform = CGAffineTransformMakeScale(1, 1);
    } completion:^(BOOL finished) {
        
    }];
}

- (void)willDismissContainer:(DSHPopupContainer *)container duration:(NSTimeInterval)duration; {
    [UIView animateWithDuration:duration animations:^{
        self.alpha = 0.f;
    }];
}

@end
