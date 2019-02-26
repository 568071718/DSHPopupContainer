//
//  DemoCustomView1.m
//  Demo
//
//  Created by 路 on 2019/2/20.
//  Copyright © 2019年 路. All rights reserved.
//

#import "DemoCustomView1.h"

@implementation DemoCustomView1 {
    NSArray *_listData;
    NSCache *_cacheData;
}

- (id)init {
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor lightGrayColor];
        self.layer.cornerRadius = 10.f;
        self.clipsToBounds = YES;
        
        _cacheData = [[NSCache alloc] init];
        _listData = @[@"https://ss2.bdstatic.com/70cFvnSh_Q1YnxGkpoWK1HF6hhy/it/u=1499844476,2082399552&fm=27&gp=0.jpg",
                      @"https://ss1.bdstatic.com/70cFuXSh_Q1YnxGkpoWK1HF6hhy/it/u=3378714559,740991406&fm=27&gp=0.jpg",
                      @"https://ss2.bdstatic.com/70cFvnSh_Q1YnxGkpoWK1HF6hhy/it/u=3484495061,2102329231&fm=27&gp=0.jpg",
                      @"https://ss1.bdstatic.com/70cFvXSh_Q1YnxGkpoWK1HF6hhy/it/u=1642641909,2747265704&fm=15&gp=0.jpg",];
        
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.minimumLineSpacing = 0;
        layout.minimumInteritemSpacing = 0;
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        _collectionView = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:layout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.pagingEnabled = YES;
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"UICollectionViewCell"];
        [self addSubview:_collectionView];
        
        _pageControl = [[UIPageControl alloc] init];
        _pageControl.currentPage = 0;
        _pageControl.numberOfPages = _listData.count;
        _pageControl.pageIndicatorTintColor = [UIColor whiteColor];
        _pageControl.currentPageIndicatorTintColor = [UIColor orangeColor];
        _pageControl.userInteractionEnabled = NO;
        [self addSubview:_pageControl];
    } return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    CGRect frame = _pageControl.frame;
    frame.size.width = self.frame.size.width;
    frame.size.height = 44;
    frame.origin.x = 0;
    frame.origin.y = self.frame.size.height - frame.size.height;
    _pageControl.frame = frame;
}

#pragma mark - scroll view
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    NSInteger pageIndex = round(scrollView.contentOffset.x / scrollView.frame.size.width);
    if (_pageControl.currentPage != pageIndex) {
        _pageControl.currentPage = pageIndex;
    }
}

#pragma mark - collection view
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section; {
    return _listData.count;
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath; {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"UICollectionViewCell" forIndexPath:indexPath];
    UIImageView *imageView = [cell viewWithTag:3];
    if (!imageView) {
        imageView = [[UIImageView alloc] initWithImage:nil];
        imageView.tag = 3;
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        imageView.clipsToBounds = YES;
        [cell addSubview:imageView];
    }
    imageView.frame = cell.bounds;
    NSURL *URL = [NSURL URLWithString:_listData[indexPath.row]];
    UIImage *image = [_cacheData objectForKey:URL.lastPathComponent];
    imageView.image = image;
    if (!image) {
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            UIImage *result = [UIImage imageWithData:[NSData dataWithContentsOfURL:URL]];
            if (result) {
                [self->_cacheData setObject:result forKey:URL.lastPathComponent];
                dispatch_async(dispatch_get_main_queue(), ^{
                    imageView.image = result;
                });
            }
        });
    }
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath; {
    return collectionView.bounds.size;
}

#pragma mark -
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
