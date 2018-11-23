//
//  CateViewController.h
//  learn-v2ex-app
//
//  Created by Antony x on 2018/11/23.
//  Copyright © 2018年 iotek. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"

NS_ASSUME_NONNULL_BEGIN
@protocol CateViewDelegate
@required
-(void)onCellTapAction:(NSInteger)id WidthTitle:(NSString *)title;
@end
@interface CateViewController : UIViewController
<
UITableViewDelegate,
UITableViewDataSource
>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) MBProgressHUD *mbProgress;
@property (nonatomic, weak) id<CateViewDelegate> delegate;
@end

NS_ASSUME_NONNULL_END
