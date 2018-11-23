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
#import "NetworkHelper.h"
#import "TopicsHotModel.h"
#import "HomeCollectionViewFlowLayout.h"
#import "MJRefresh.h"
#import "ProfileViewController.h"
#import "CateViewController.h"
#import "DetailViewController.h"

@interface HomePageViewController ()
<
UICollectionViewDelegate,
UICollectionViewDataSource,
UICollectionViewDelegateFlowLayout,
CateViewDelegate
>
@property (nonatomic, copy) NSMutableArray *hotList;
// 定义一个id, 保存数据的类型
@property (nonatomic, assign) NSInteger nodeId;

// 定义分类容器
@property (nonatomic, strong) CateViewController* cateView;
@end

@implementation HomePageViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        _hotList = [NSMutableArray new];
        _nodeId = -1;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBar.translucent = NO;
    self.title = @"Hot";
    self.tabBarController.tabBar.hidden = YES;
    _cateView = [CateViewController new];
    _cateView.delegate = self;
    [self initNavigationItem];
    [self initCollectionView];
    [self loadData:_nodeId];
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
    HomeCollectionViewFlowLayout *layout = [HomeCollectionViewFlowLayout new];
    // 自适应布局
    if (@available(iOS 10.0, *)) {
        NSLog(@"版本");
        layout.estimatedItemSize = CGSizeMake(1.0, 1.0);
    } else {
        
    }
    // 设置每列的间距
    layout.minimumLineSpacing = 10;
    layout.minimumInteritemSpacing = 0;
    // 初始化 collection 大小为全屏的
    _collectionView = [[UICollectionView alloc] initWithFrame: CGRectMake(0, 0, ScreenWidth, ScreenHeight) collectionViewLayout:layout];
    _collectionView.backgroundColor = [UIColor clearColor];
    // 适配 ios11 出现UI bug
    if (@available(iOS 11.0, *)) {
        // _collectionView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    // 不显示 竖向的 滚动条
    _collectionView.showsVerticalScrollIndicator = NO;
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    // 下拉刷新
    
    __weak typeof(self) wself = self;
    MJRefreshStateHeader *header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        sleep(2);
        if (wself.nodeId != -1) {
            [wself loadData:wself.nodeId];
        } else {
            [wself loadData:-1];
        }
        [wself.collectionView reloadSections:[NSIndexSet indexSetWithIndex:0]];
        [self.collectionView.mj_header endRefreshing];
    }];
    _collectionView.mj_header = header;
    [_collectionView registerClass:[MJRefreshStateHeader class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"headeId"];
    [_collectionView registerClass:[HotCollectionViewCell class] forCellWithReuseIdentifier:@"cellId"];
    
    [self.view addSubview:_collectionView];
}

-(void)navigationPress:(UIBarButtonItem *)btn {
    if (btn.tag == SettingBarBtnTag) {
        NSLog(@"设置中!!");
        // 自定义导航动画
        CATransition *animation = [CATransition animation];
        animation.duration =  .3;
        animation.type = @"push";
        // 设置动画的子类型， 例如动画的方向
        animation.subtype = kCATransitionFromLeft;
        // 运动轨迹
        animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        [self.navigationController.view.layer addAnimation:animation forKey:nil];
        [self.navigationController pushViewController:[ProfileViewController new] animated:NO];
    } else {
        NSLog(@"更多...");
        CATransition *anim = [CATransition animation];
        anim.duration = .4;
        anim.type = @"push";
        anim.subtype = kCATransitionFromTop;
        anim.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        [self.navigationController.view.layer addAnimation:anim forKey:nil];
        [self.navigationController pushViewController:_cateView animated:NO];
    }
}

// delegate collection
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _hotList.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    HotCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cellId" forIndexPath:indexPath];
    [cell initData: _hotList[indexPath.item]];
    cell.backgroundColor = [UIColor whiteColor];
    return cell;
}

// 选中单元格时调用
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    DetailViewController *detailView = [DetailViewController new];
    [self.navigationController pushViewController:detailView animated:YES];
}


-(void)loadData:(NSInteger) nodeId {
    TopicsHotModel *request = [TopicsHotModel new];
    NSString *url = TopicsHotURL;
    if(nodeId != -1) {
        request.node_id = nodeId;
        url = TopicsByNodeIdURL;
    }
    __weak typeof (self) wself = self;
    [NetworkHelper getWithUrlPath:url request:request success:^(id data) {
        [wself.hotList removeAllObjects];
        for (NSDictionary *dic in data) {
            TopicsHotModel *topicsHotModel = [TopicsHotModel new];
            NSDictionary *node = [dic objectForKey:@"member"];
            topicsHotModel.avatar_normal = [node objectForKey:@"avatar_large"];
            topicsHotModel.name = [node objectForKey:@"username"];
            topicsHotModel.last_modified = [dic objectForKey:@"last_modified"];
            topicsHotModel.content = [dic objectForKey:@"content"];
            [wself.hotList addObject:topicsHotModel];
        }
        [wself.collectionView reloadSections:[NSIndexSet indexSetWithIndex:0]];
    } failure:^(NSError *error) {
        NSLog(@"%@", error);
    }];
}

//根据id 重新渲染首页的数据
- (void)onCellTapAction:(NSInteger)nodeID WidthTitle:(NSString *)title {
    NSLog(@"id====%@", title);
    if(_nodeId == nodeID) {
        
    } else {
        self.title = title;
        [self loadData:nodeID];
        _nodeId = nodeID;
    }
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
