//
//  BDJDownloader.m
//  Baisibudejie
//
//  Created by qianfeng on 16/11/22.
//  Copyright © 2016年 zhb. All rights reserved.
//

#import "BDJDownloader.h"

@implementation BDJDownloader

+ (void)downloadWithURLString:(NSString *)urlString success:(void (^)(NSData *))finishBlock fail:(void (^)(NSError *))failBlock {
    
    NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:config];
    
    //1.创建NSURL
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    //2.创建request
   
    
    //设置返回的数据是原始的二进制数据
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    NSURLSessionDataTask *downloadTask = [manager dataTaskWithRequest:request completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        if (error) {
            //请求失败
            failBlock(error);
        }else {
            //请求成功
            NSHTTPURLResponse *r = (NSHTTPURLResponse *)response;
            if (r.statusCode == 200) {
                //返回正确数据
                finishBlock(responseObject);
            }else {
                //请求数据失败
                NSError *e = [NSError errorWithDomain:urlString code:r.statusCode userInfo:@{@"msg":@"下载失败"}];
                failBlock(e);
            }
        }
    }];
    
    [downloadTask resume];
    
}
@end
