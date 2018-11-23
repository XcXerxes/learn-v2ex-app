//
//  CateViewController.m
//  learn-v2ex-app
//
//  Created by Antony x on 2018/11/23.
//  Copyright © 2018年 iotek. All rights reserved.
//

#import "CateViewController.h"
#import "Constants.h"
#import "CateModel.h"
#import "NetworkHelper.h"

@interface CateViewController ()
@property(nonatomic, copy) NSMutableArray<CateModel *> *cateData;
@end

@implementation CateViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        // 初始化数组
        _cateData = [NSMutableArray array];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"分类";
    // Do any additional setup after loading the view.
    // 初始化loading
    [self initTableView];
    [self loadData];
}
-(void) initGeneral {

}
// init tableView
- (void) initTableView {
    // 初始化
    _tableView = [[UITableView alloc] initWithFrame:ScreenFrame style:UITableViewStyleGrouped];
    _tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, CGFLOAT_MIN)];
    if (@available(iOS 11.0, *)) {
        _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
    // 代理协议
    _tableView.delegate = self;
    _tableView.dataSource = self;
    
    [self.view addSubview:_tableView];
}

// delegate

// 获取行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _cateData.count;
}

// 获取单元格内容
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *strID = @"ID";
    // 尝试获取可复用的单元格
    // 性能优化
    UITableViewCell *cell = [_tableView dequeueReusableCellWithIdentifier:strID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:strID];
    }
    // 设置标题
    CateModel *item = [_cateData objectAtIndex:indexPath.row];
    cell.textLabel.text = item != nil ? item.title : @"";
    return cell;
}
// 选中单元格时调用
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"选中...");
    CateModel *cateItem = [_cateData objectAtIndex:indexPath.row];
    [self.delegate onCellTapAction:cateItem.node_id WidthTitle:cateItem.title];
    [self.navigationController popViewControllerAnimated:YES];
}

// 获取数据
-(void) loadData {
    // 显示loading 效果
    _mbProgress = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    // 设置loading 的类型
    _mbProgress.mode = MBProgressHUDModeIndeterminate;
    // 设置 loading 的文字
    _mbProgress.label.text = @"玩命加载中...";
    // 当loading 控件隐藏之后 从视图中 删除掉
    _mbProgress.removeFromSuperViewOnHide = YES;
    JSONModel *request = [JSONModel new];
    __weak typeof(self) wself = self;
    [NetworkHelper getWithUrlPath:AllNodesURL request:request success:^(id data) {
        // 隐藏loading 控件
        [wself.mbProgress hideAnimated: YES];
        for (NSDictionary *dic in data) {
            CateModel *cateItem = [CateModel new];
            cateItem.node_id = [[dic objectForKey:@"id"] integerValue];
            cateItem.title = [dic objectForKey:@"title"];
            [wself.cateData addObject:cateItem];
            [wself.tableView reloadData];
        }
    } failure:^(NSError *error) {
        NSLog(@"错误信息为=======%@", error);
    }];
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
