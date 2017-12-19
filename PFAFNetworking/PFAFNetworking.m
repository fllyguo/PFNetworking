//
//  PFAFNetworking.m
//  Test
//
//  Created by dlios on 15/11/6.
//  Copyright © 2015年 郭鹏飞. All rights reserved.
//

#import "PFAFNetworking.h"
#import "AFNetworking.h"

@implementation PFAFNetworking

+ (void)getUrl:(NSString *)url body:(id)body response:(PFResposeStyle)style requestHeadFile:(NSDictionary *)headerFile success:(void (^)(NSURLSessionDataTask *task, id resposeObject))success failure:(void(^)(NSURLSessionDataTask *task, NSError *error))failure
{
    /* 1. 获取单例的网络管理对象 */
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    /* 2. 根据style的类型, 去选择返回值的类型 */
    switch (style) {
        case PFJSON:
            manager.responseSerializer = [AFJSONResponseSerializer serializer];
            break;
        case PFXML:
            manager.responseSerializer = [AFXMLParserResponseSerializer serializer];
            break;
        case PFData:
            
            manager.responseSerializer = [AFHTTPResponseSerializer serializer];
            break;
        default:
            break;
    }
    // 3. 设置响应数据支持类型
    [manager.responseSerializer setAcceptableContentTypes:[NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html",@"text/css",@"text/plain", @"application/javascript", nil]];
    
    /* 4. 给网络请求加请求头 */
    if (headerFile) {
        for (NSString *key in headerFile.allKeys) {
            [manager.requestSerializer setValue:headerFile[key] forHTTPHeaderField:key];
        }
    }
    /* 5. UTF8转码 */
    url = [url stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    
    /* 6. 发送请求 */
    [manager GET:url parameters:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        
        if (success) {
            success (task, responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(task, error);
        }
        
    }];
}

+ (void)postUrlString:(NSString *)url
                 body:(id)body
             response:(QCRequestStyle)style
            bodyStyle:(QCRequestStyle)bodyStyle
      requestHeadFile:(NSDictionary *)headFile
              success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
              failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure
{
    // 1.获取Session管理对象
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    // 2.设置网络请求返回时, responseObject的数据类型
    switch (style) {
        case RequestJSON:
            manager.responseSerializer = [AFJSONResponseSerializer serializer];
            break;
        case RequestString:
            manager.responseSerializer = [AFXMLParserResponseSerializer serializer];
            break;
        case RequestDefault:
            manager.responseSerializer = [AFHTTPResponseSerializer serializer];
            break;
        default:
            break;
    }
    // 3.判断body体的类型
    switch (bodyStyle) {
        case RequestJSON:
            // 以JSON格式发送
            manager.requestSerializer = [AFHTTPRequestSerializer serializer];
            break;
        case RequestString:
            // 保持字符串样式
            [manager.requestSerializer setQueryStringSerializationWithBlock:^NSString *(NSURLRequest *request, id parameters, NSError *__autoreleasing *error) {
                return parameters;
            }];
        case RequestDefault:
            // 默认情况会把JSON拼接成字符串, 但是没有顺序
            break;
            
        default:
            break;
    }
    // 4.给网络请求加请求头
    if (headFile) {
        for (NSString *key in headFile.allKeys) {
            [manager.requestSerializer setValue:headFile[key] forHTTPHeaderField:key];
        }
    }
    // 5.设置支持的响应头格式
    [manager.responseSerializer setAcceptableContentTypes:[NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html",@"text/css",@"text/plain", @"application/javascript", nil]];
    // 6.发送网络请求
    [manager GET:url parameters:body success:^(NSURLSessionDataTask *task, id responseObject) {
        if (success) {
            success(task, responseObject);
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        if (failure) {
            failure(task, error);
        }
    }];
    
    
}


@end
