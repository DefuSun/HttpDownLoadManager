//
//  HttpDownLoadManager.m
//  HttpRequestDemo
//
//  Created by mac on 16/5/24.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "HttpDownLoadManager.h"

@implementation HttpDownLoadManager

+ (HttpDownLoadManager *)SharedManager
{
    static HttpDownLoadManager *DownLoadManger = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        DownLoadManger = [[self alloc] init];
    });
    
    return DownLoadManger;
    
}

//http://api.photochina.china.cn/phone/category_4_1_10.html
-(void)Get:(NSString *)url success:(HttpDownLoadSuccess)success failure:(HttpDownLoadFailure)failure
{
//    self.downLoadSuccess = success;
//    self.downLoadFailure = failure;
    
    NSString *encodeUrl ;
    encodeUrl = [url stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet characterSetWithCharactersInString:@"`#%^{}\"[]|\\<> "].invertedSet];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:encodeUrl]];
    
    //NSURLConnection 请求
//    _myConnection = [NSURLConnection connectionWithRequest:request delegate:self];
    
    
    //NSURLSession 请求
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        if (error) {
            failure(error);
        }else{
            id result = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            success(result);
        }
        
    }];
    [dataTask resume];
    
}

-(void)Post:(NSString *)url parameters:(NSDictionary *)param success:(HttpDownLoadSuccess)success failure:(HttpDownLoadFailure)failure
{
//    self.downLoadSuccess = success;
//    self.downLoadFailure = failure;
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]];
    request.timeoutInterval = 15;
    request.HTTPMethod = @"POST";
    
    NSString *str = [self getParamStringByDictionary:param];
    NSData *data = [str dataUsingEncoding:NSUTF8StringEncoding];
    request.HTTPBody = data;
    
    //NSURLSession 请求
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        if (error) {
            failure(error);
        }else{
            id result = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            success(result);
        }
        
    }];
    [dataTask resume];
    
    //NSURLConnection 请求
//    _myConnection = [NSURLConnection connectionWithRequest:request delegate:self];
}

-(NSString*)getParamStringByDictionary:(NSDictionary*)dic
{
    NSMutableString *mutableString = [[NSMutableString alloc] initWithCapacity:0];
    
    for (id key in dic) {
        NSString *string = [NSString stringWithFormat:@"%@=%@&",key,[dic objectForKey:key]];
        [mutableString appendString:string];
    }
    
    [mutableString deleteCharactersInRange:NSMakeRange(mutableString.length-1, 1)];
    return mutableString;
}

#pragma mark Connection Delegate
//-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
//{
//    //接收到数据，开始接收数据
//    self.data=[NSMutableData dataWithCapacity:0];
//}
//
//-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
//{
//    //持续接收数据
//    [self.data appendData:data];
//}
//
//-(void)connectionDidFinishLoading:(NSURLConnection *)connection
//{
//    id result = [NSJSONSerialization JSONObjectWithData:self.data options:NSJSONReadingMutableContainers error:nil];
//    
//    if (self.downLoadSuccess) {
//        self.downLoadSuccess(result);
//    }
//}
//
//-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
//{
//    if (self.downLoadFailure) {
//        self.downLoadFailure(error);
//    }
//}

@end
