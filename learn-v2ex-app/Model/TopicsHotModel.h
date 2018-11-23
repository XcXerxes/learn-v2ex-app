//
//  TopicsHotModel.h
//  learn-v2ex-app
//
//  Created by xiacan on 2018/11/21.
//  Copyright © 2018 iotek. All rights reserved.
//

#import "BaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface TopicsHotModel : BaseModel
@property (nonatomic, assign) NSInteger node_id;
// 定义头像的地址
@property(nonatomic, copy) NSString *avatar_normal;
// 定义名字
@property (nonatomic, copy) NSString *name;
// 定义时间
@property (nonatomic, assign) NSNumber *last_modified;

//发表的内容
@property (nonatomic, copy) NSString *content;

@end

NS_ASSUME_NONNULL_END
