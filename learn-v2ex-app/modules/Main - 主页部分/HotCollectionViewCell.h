//
//  HotCollectionViewCell.h
//  learn-v2ex-app
//
//  Created by Antony x on 2018/11/21.
//  Copyright © 2018年 iotek. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TopicsHotModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface HotCollectionViewCell : UICollectionViewCell
// 定义头像
@property (nonatomic, strong) UIImageView *avatarImageView;
// 定义名字
@property (nonatomic, strong) UILabel *nameLabel;
// 定义发布时间
@property (nonatomic, strong) UILabel *releaseTimeLabel;
// 定义内容
@property (nonatomic, strong) UILabel *descriptionLabel;
//
@property (nonatomic, copy) TopicsHotModel *topicsModel;

-(void)initData:(TopicsHotModel *)topicsModel;

@end

NS_ASSUME_NONNULL_END
