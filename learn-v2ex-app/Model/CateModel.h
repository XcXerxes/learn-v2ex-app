//
//  CateModel.h
//  learn-v2ex-app
//
//  Created by Antony x on 2018/11/23.
//  Copyright © 2018年 iotek. All rights reserved.
//

#import "BaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface CateModel : BaseModel
// 定义数据的id
@property(nonatomic, assign) NSInteger node_id;
// 定义数据的标题
@property(nonatomic, copy) NSString *title;
@end

NS_ASSUME_NONNULL_END
