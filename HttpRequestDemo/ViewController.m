//
//  ViewController.m
//  HttpRequestDemo
//
//  Created by mac on 16/5/24.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "ViewController.h"
#import "HttpDownLoadManager.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(100, 100, 80, 60)];
    button.backgroundColor = [UIColor orangeColor];
    [button addTarget:self action:@selector(buttonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
}

-(void)buttonClick
{
    //http://gateway.lincovip.com/api/mobileTeachershistory?pagingId=0&studentId=965b040e-8a70-44d2-a1c2-6066fc258e08
    
    //http://gateway.lincovip.com/api/JPushNotifications?studentId=965b040e-8a70-44d2-a1c2-6066fc258e08
//    NSString *strurl = @"http://gateway.lincovip.com/api/mobileTeachershistory?pagingId=0&studentId=965b040e-8a70-44d2-a1c2-6066fc258e08";
    
    HttpDownLoadManager *manager = [HttpDownLoadManager SharedManager];
    
//    [manager Get:strurl success:^(id data) {
//        
//        NSLog(@"~~~data~~%@",data);
//
//    } failure:^(NSError *error) {
//        NSLog(@"~~~error~~%@",error);
//    }];
    
    NSString *strUrl = @"http://gateway.lincovip.com/api/mobileTeacherskeywordsearch?studentId=965b040e-8a70-44d2-a1c2-6066fc258e08";
    NSString *keyWord = @"b";
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    NSString *keywords = [keyWord stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    params[@"Keyword"] = keywords;
    
    [manager Post:strUrl parameters:params success:^(id data) {
        NSLog(@"~~~data~~%@",data);
    } failure:^(NSError *error) {
        NSLog(@"~~~error~~%@",error);
    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
