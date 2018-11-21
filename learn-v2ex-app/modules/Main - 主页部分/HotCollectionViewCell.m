//
//  HotCollectionViewCell.m
//  learn-v2ex-app
//
//  Created by Antony x on 2018/11/21.
//  Copyright © 2018年 iotek. All rights reserved.
//

#import "HotCollectionViewCell.h"
#import "Masonry.h"

@implementation HotCollectionViewCell
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // 定义头像容器
        _avatarImageView = [[UIImageView alloc] initWithImage: [UIImage new]];
        _avatarImageView.layer.borderWidth = 1;
        _avatarImageView.layer.borderColor = [UIColor blackColor].CGColor;
        [self.contentView addSubview:_avatarImageView];
        [_avatarImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self).offset(10);
            make.left.equalTo(self).offset(10);
            make.width.height.mas_equalTo(50);
        }];
        // 定义名字
        _nameLabel = [UILabel new];
        _nameLabel.text = @"antony";
        _nameLabel.font = [UIFont systemFontOfSize: 16];
        [self.contentView addSubview:_nameLabel];
        [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.avatarImageView.mas_top);
            make.left.mas_equalTo(self.avatarImageView.mas_right).offset(10);
        }];
        // 定义注册时间
        _releaseTimeLabel = [UILabel new];
        _releaseTimeLabel.text = @"2018-02-20 21:00:00";
        _releaseTimeLabel.font = [UIFont systemFontOfSize:14];
        [self.contentView addSubview:_releaseTimeLabel];
        [_releaseTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(self.avatarImageView.mas_bottom);
            make.left.mas_equalTo(self.nameLabel.mas_left);
        }];
        // 定义发布的内容
        _descriptionLabel = [UILabel new];
        _descriptionLabel.numberOfLines = 0;
        _descriptionLabel.text = @"首先声明，我对于有赞这家公司是很有好感的，不止一次跟人推荐使用有赞的付费服务。";
        [self.contentView addSubview:_descriptionLabel];
        [_descriptionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.releaseTimeLabel.mas_bottom).offset(15);
            make.left.mas_equalTo(self.avatarImageView.mas_left);
            make.right.mas_equalTo(self.mas_right).inset(10);
        }];
    }
    return self;
}

// 自适应高度设置
- (UICollectionViewLayoutAttributes *)preferredLayoutAttributesFittingAttributes:(UICollectionViewLayoutAttributes *)layoutAttributes {
    [self setNeedsLayout];
    [self  layoutIfNeeded];
    CGSize size = [self.contentView systemLayoutSizeFittingSize:layoutAttributes.size];
    NSLog(@"size的高度-====%f", size.height);
    CGRect cellFrame = layoutAttributes.frame;
    cellFrame.size.height = size.height;
    layoutAttributes.frame = cellFrame;
    return layoutAttributes;
}
- (CGSize)systemLayoutSizeFittingSize:(CGSize)targetSize withHorizontalFittingPriority:(UILayoutPriority)horizontalFittingPriority verticalFittingPriority:(UILayoutPriority)verticalFittingPriority {
    if (@available(iOS 11.0, *)) {
        return [self.contentView sizeThatFits:CGSizeMake(targetSize.width - self.safeAreaInsets.left - self.safeAreaInsets.right, targetSize.height)];
    } else {
        return [self.contentView sizeThatFits:targetSize];
    }
}

@end
