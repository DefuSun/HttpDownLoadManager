//
//  HttpDownLoadManager.h
//  HttpRequestDemo
//
//  Created by mac on 16/5/24.
//  Copyright © 2016年 mac. All rights reserved.
//

/*
 ios9 网络请求要在Info.plist配置以下代码
 <key>NSAppTransportSecurity</key>
	<dict>
 <key>NSAllowsArbitraryLoads</key>
 <true/>
	</dict>
 */

#import <Foundation/Foundation.h>

//typedef void (^HttpDownLoad)(BOOL success, id data);

typedef void (^HttpDownLoadSuccess)(id data);
typedef void (^HttpDownLoadFailure)(NSError *error);

@interface HttpDownLoadManager : NSObject<NSURLConnectionDataDelegate,NSURLConnectionDelegate>

//@property(nonatomic, copy)HttpDownLoadSuccess downLoadSuccess;
//@property(nonatomic, copy)HttpDownLoadFailure downLoadFailure;

//@property(nonatomic,strong)NSURLConnection *myConnection;
//@property(nonatomic,strong) NSMutableData *data;

+ (HttpDownLoadManager *)SharedManager;


-(void)Get:(NSString*)url success:(HttpDownLoadSuccess)success failure:(HttpDownLoadFailure)failure;

-(void)Post:(NSString*)url parameters:(NSDictionary*)param success:(HttpDownLoadSuccess)success failure:(HttpDownLoadFailure)failure;


@end
