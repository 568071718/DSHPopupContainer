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
#import "DSHAlertView.h"

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
            DSHAlertObject *title = [DSHAlertObject makeTitle:@"温馨提示"];
            title.color = [UIColor redColor];
            DSHAlertObject *message = [DSHAlertObject makeMessage:@"内容房间了圣诞节福利世纪东方决胜巅峰你口味放开那能收到"];
            DSHAlertObject *option1 = [DSHAlertObject makeOption:@"好的"];
            DSHAlertObject *option2 = [DSHAlertObject makeOption:@"测试"];
            option2.color = [UIColor brownColor];
            DSHAlertView *alert = [[DSHAlertView alloc] initWithObjects:@[title ,message, option1 ,option2]];
            [alert show];
        }
            break;
            
        default:
            break;
    }
}

@end
