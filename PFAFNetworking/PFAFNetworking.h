//
//  PFAFNetworking.h
//  Test
//
//  Created by dlios on 15/11/6.
//  Copyright © 2015年 郭鹏飞. All rights reserved.
//

#import <Foundation/Foundation.h>
/* 枚举 */
typedef NS_ENUM(NSUInteger, PFResposeStyle) {
    PFJSON,
    PFXML,
    PFData,
};

typedef NS_ENUM(NSUInteger, QCRequestStyle) {
    RequestJSON,
    RequestString,
    RequestDefault
};

@interface PFAFNetworking : NSObject

/* GET请求 */
+ (void)getUrl:(NSString *)url body:(id)body response:(PFResposeStyle)style requestHeadFile:(NSDictionary *)headerFile success:(void (^)(NSURLSessionDataTask *task, id resposeObject))success failure:(void(^)(NSURLSessionDataTask *task, NSError *error))failure;

/* POST请求 */
+ (void)postUrlString:(NSString *)url
                 body:(id)body
             response:(QCRequestStyle)style
            bodyStyle:(QCRequestStyle)bodyStyle
      requestHeadFile:(NSDictionary *)headFile
              success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
              failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure;

@end
