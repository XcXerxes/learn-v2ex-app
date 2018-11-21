//
//  TabBarController.m
//  learn-v2ex-app
//
//  Created by Antony x on 2018/11/21.
//  Copyright © 2018年 iotek. All rights reserved.
//

#import "TabBarController.h"
#import "NavigationController.h"
#import "HomePageViewController.h"
#import "ProfileViewController.h"

@interface TabBarController ()

@end

@implementation TabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initTabBarWithViewController:[HomePageViewController new] title:@"首页" image:@"tabADeselected" selectedImage:@"tabASelected"];
    [self initTabBarWithViewController:[ProfileViewController new] title:@"个人中心" image:@"tabDDeselected" selectedImage:@"tabDSelected"];
    // Do any additional setup after loading the view.
}

+ (void)initialize
{
    // 设置 tabbarItem 的字体颜色 和 字体大小
    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:14], NSFontAttributeName,nil] forState:UIControlStateNormal];
    // 设置选中时 tabbarItem 的字体颜色
    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor colorWithRed:219/255.0 green:102/255.0 blue:81/255.0 alpha:1.0], NSForegroundColorAttributeName, [UIFont systemFontOfSize:14], NSFontAttributeName, nil] forState:UIControlStateSelected];
//    NSMutableDictionary *normalAttrs = [NSMutableDictionary dictionary];
//    normalAttrs[NSFontAttributeName] = [UIFont systemFontOfSize:14];
//    normalAttrs[NSForegroundColorAttributeName] = [UIColor whiteColor];
//
//    NSMutableDictionary *selectedAttrs = [NSMutableDictionary dictionary];
//    selectedAttrs[NSFontAttributeName] = normalAttrs[NSFontAttributeName];
//    selectedAttrs[NSForegroundColorAttributeName] = [UIColor orangeColor];
//
//    UITabBarItem *appearance = [UITabBarItem appearance];
//    [appearance setTitleTextAttributes:normalAttrs forState:UIControlStateNormal];
//    [appearance setTitleTextAttributes:selectedAttrs forState:UIControlStateSelected];
}

-(void) initTabBarWithViewController: (UIViewController *)childController title:(NSString *)title image:(NSString *)image selectedImage:(NSString *)selectedImage {
    // 设置当前tabbar 的label
    childController.tabBarItem.title = title;
    // UIImageView *imageView = [UIImageView new];
    // [imageView sd_setImageWithURL:[NSURL URLWithString:image] placeholderImage:[UIImage new]];
    // UIImageView *selectedImageView = [UIImageView new];
    // [selectedImageView sd_setImageWithURL:[NSURL URLWithString:selectedImage]];
    // 设置默认图片 和被选中时的图片
    [childController.tabBarItem setImage:[UIImage imageNamed:image]];
    [childController.tabBarItem setSelectedImage:[UIImage imageNamed:selectedImage]];
    NavigationController *nav = [[NavigationController alloc] initWithRootViewController:childController];
    childController.title = title;
    childController.tabBarController.tabBar.translucent = NO;
    [self addChildViewController:nav];
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
