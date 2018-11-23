//
//  NetworkHelper.m
//  learn-v2ex-app
//
//  Created by xiacan on 2018/11/20.
//  Copyright © 2018 iotek. All rights reserved.
//

#import "NetworkHelper.h"

// 请求的基础地址
NSString * const BaseURL = @"https://www.v2ex.com/api";

// 获取Site 信息
NSString * const SiteInfoURL = @"/site/info.json";

// 获取Site state
NSString * const SiteStatsURL = @"/site/stats.json";

// 获取所有的 node
NSString * const AllNodesURL = @"/nodes/all.json";
// 根据id 获取的nodes
NSString * const NodesByIdURL = @"/nodes/show.json?id=";
// 根据名称获取 nodes
NSString * const NodesByNameURL = @"/nodes/show.json?name=";

// 获取社区热门主题
NSString * const TopicsHotURL = @"/topics/hot.json";
// 根据id 获取主题信息
NSString * const TopicsByIdURL = @"/topics/show.json?id=";
// 根据用户名获取用户的主题列表接口
NSString * const TopicsByUserNameURL = @"/topics/show.json?username=";
// 通过节点获取该节点下的主题
NSString * const TopicsByNameURL = @"/topics/show.json?node_name=";
// 通过id 获取主题
NSString * const TopicsByNodeIdURL = @"/topics/show.json";

@implementation NetworkHelper
+ (AFHTTPSessionManager *)sharedManager {
    // 使用dispatch_one 创建单例
    static dispatch_once_t once;
    static AFHTTPSessionManager *manager;
    dispatch_once(&once, ^{
        manager = [AFHTTPSessionManager manager];
        // 设置超时时间
        manager.requestSerializer.timeoutInterval = 15.0f;
    });
    return manager;
}

+(void) processResponseData:(id)responseObject success:(HttpSuccess)success failure:(HttpFailure)failure{
    // 判断接口是否返回字典数据
    if ([responseObject isKindOfClass:[NSArray class]]) {
        success(responseObject);
    } else {
        NSError *error = [NSError errorWithDomain: @"" code:-200 userInfo:nil];
        failure(error);
    }
}

// GET 请求
+ (NSURLSessionDataTask *)getWithUrlPath:(NSString *)urlPath request:(JSONModel *)request success:(HttpSuccess)success failure:(HttpFailure)failure {
    // 将请求的参数转为字典
    NSDictionary *parameters = [request toDictionary];
    // 返回一个 dataTask
    return [[NetworkHelper sharedManager] GET: [BaseURL stringByAppendingString:urlPath] parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [NetworkHelper processResponseData:responseObject success:success failure:failure];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(error);
    }];
}
@end
