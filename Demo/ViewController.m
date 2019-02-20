//
//  ViewController.m
//  Demo
//
//  Created by 路 on 2019/2/20.
//  Copyright © 2019年 路. All rights reserved.
//

#import "ViewController.h"
#import "DemoCustomView1.h"
#import "DemoCustomView2.h"

@interface ViewController ()

@end

@implementation ViewController

#pragma mark - controller
- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
}

- (void)dealloc {
    
}

#pragma mark - action
- (IBAction)clickActions:(UIView *)sender {
    switch ([sender tag]) {
        case 1:
        {
            DemoCustomView1 *customView = [[DemoCustomView1 alloc] init];
            DSHPopupContainer *container = [[DSHPopupContainer alloc] initWithCustomPopupView:customView];
            container.showAnimationDuration = .5;
            container.dismissAnimationDuration = .5;
            [container show];
        }
            break;
        case 2:
        {
            DemoCustomView2 *customView = [[DemoCustomView2 alloc] init];
            DSHPopupContainer *container = [[DSHPopupContainer alloc] initWithCustomPopupView:customView];
            container.maskColor = [[UIColor blackColor] colorWithAlphaComponent:.5];
            [container show];
        }
            break;
        case 3:
        {
            
        }
            break;
            
        default:
            break;
    }
}

@end
