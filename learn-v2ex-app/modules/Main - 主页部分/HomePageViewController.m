//
//  HomePageViewController.m
//  learn-v2ex-app
//
//  Created by Antony x on 2018/11/21.
//  Copyright © 2018年 iotek. All rights reserved.
//

#import "HomePageViewController.h"
#import "HotCollectionViewCell.h"
#import "Constants.h"

@interface HomePageViewController ()
<
UICollectionViewDelegate,
UICollectionViewDataSource,
UICollectionViewDelegateFlowLayout
>
@end

@implementation HomePageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBar.translucent = NO;
    [self initNavigationItem];
    [self initCollectionView];
    // Do any additional setup after loading the view.
}

-(void) initNavigationItem {
    _settingBtnItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"slide_menu_setting"] style:UIBarButtonItemStylePlain target:self action:@selector(navigationPress:)];
    [_settingBtnItem setTintColor:ColorThemeGrayLight];
    _settingBtnItem.tag = SettingBarBtnTag;
    _moreBtnItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"nav_more"] style:UIBarButtonItemStylePlain target:self action:@selector(navigationPress:)];
    [_moreBtnItem setTintColor:ColorThemeGrayLight];
    _moreBtnItem.tag = MoreBarBtnTag;
    self.navigationItem.leftBarButtonItem = _settingBtnItem;
    self.navigationItem.rightBarButtonItem = _moreBtnItem;
}

// 设置collection 的UI
-(void) initCollectionView {
    // 设置容器的样式
    UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
    layout.minimumLineSpacing = 1;
    layout.minimumInteritemSpacing = 0;
    layout.estimatedItemSize = CGSizeMake(ScreenWidth, 300);
    // 初始化 collection 大小为全屏的
    self.tabBarController.tabBar.hidden = YES;
    NSLog(@"tabbar的高度====%f", self.tabBarController.tabBar.frame.size.height);
    NSLog(@"navigationBar的高度=====%f", self.navigationController.navigationBar.frame.size.height);
    _collectionView = [[UICollectionView alloc] initWithFrame: CGRectMake(0, 0, ScreenWidth, ScreenHeight - 64 - 30) collectionViewLayout:layout];
    // 适配 ios11 出现UI bug
    if (@available(iOS 11.0, *)) {
        _collectionView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    // 不显示 竖向的 滚动条
    _collectionView.showsVerticalScrollIndicator = NO;
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    [_collectionView registerClass:[HotCollectionViewCell class] forCellWithReuseIdentifier:@"cellId"];
    
    [self.view addSubview:_collectionView];
}

-(void)navigationPress:(UIBarButtonItem *)btn {
    if (btn.tag == SettingBarBtnTag) {
        NSLog(@"设置中!!");
    } else {
        NSLog(@"更多...");
    }
}

// delegate collection
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 10;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cellId" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor whiteColor];
    return cell;
}
//- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
//    return CGSizeMake(ScreenWidth, coll);
//}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
