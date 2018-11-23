//
//  ProfileViewController.m
//  learn-v2ex-app
//
//  Created by Antony x on 2018/11/21.
//  Copyright © 2018年 iotek. All rights reserved.
//

#import "ProfileViewController.h"

@interface ProfileViewController ()

@end

@implementation ProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor orangeColor];
    // Do any additional setup after loading the view.
}

- (void)viewWillDisappear:(BOOL)animated {
    CATransition *anim = [CATransition animation];
    anim.type = @"push";
    anim.duration =  .3;
    anim.subtype = kCATransitionFromRight;
    // 运动轨迹
    anim.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    [super viewWillDisappear:animated];
    [self.navigationController.view.layer addAnimation:anim forKey:nil];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
