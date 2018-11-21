//
//  HomePageViewController.h
//  learn-v2ex-app
//
//  Created by Antony x on 2018/11/21.
//  Copyright © 2018年 iotek. All rights reserved.
//

#import <UIKit/UIKit.h>
static const NSInteger SettingBarBtnTag = 0x01;
static const NSInteger MoreBarBtnTag = 0x02;

NS_ASSUME_NONNULL_BEGIN

@interface HomePageViewController : UIViewController
// 定义collection 视图
@property (nonatomic, strong) UICollectionView *collectionView;
// 定义导航控制器的设置按钮
@property (nonatomic, strong) UIBarButtonItem *settingBtnItem;
// 定义导航控制器的更多选择按钮
@property (nonatomic, strong) UIBarButtonItem *moreBtnItem;
@end

NS_ASSUME_NONNULL_END
