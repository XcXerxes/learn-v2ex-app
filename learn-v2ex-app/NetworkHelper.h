//
//  NetworkHelper.h
//  learn-v2ex-app
//
//  Created by xiacan on 2018/11/20.
//  Copyright © 2018 iotek. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFHTTPSessionManager.h"
#import "JSONModel.h"

// 请求的基础地址
extern NSString * const BaseURL;

// 获取Site 信息
extern NSString * const SiteInfoURL;

// 获取Site state
extern NSString * const SiteStatsURL;

// 获取所有的 node
extern NSString * const AllNodesURL;
// 根据id 获取的nodes
extern NSString * const NodesByIdURL;
// 根据名称获取 nodes
extern NSString * const NodesByNameURL;

// 获取社区热门主题
extern NSString * const TopicsHotURL;
// 根据id 获取主题信息
extern NSString * const TopicsByIdURL;
// 根据用户名获取用户的主题列表接口
extern NSString * const TopicsByUserNameURL;
// 通过节点获取该节点下的主题
extern NSString * const TopicsByNameURL;
// 通过id 获取主题
extern NSString * const TopicsByNodeIdURL;

// 定义成功的 block
typedef void (^HttpSuccess)(id data);
// 定义失败的 block
typedef void (^HttpFailure)(NSError *error);

NS_ASSUME_NONNULL_BEGIN

@interface NetworkHelper : NSObject

// 定义 创建 http 的连接管理对象
+(AFHTTPSessionManager *)sharedManager;

// GET 请求
+(NSURLSessionDataTask *)getWithUrlPath:(NSString *)urlPath request:(JSONModel *)request success:(HttpSuccess)success failure:(HttpFailure)failure;

@end

NS_ASSUME_NONNULL_END
