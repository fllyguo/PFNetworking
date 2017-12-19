//
//  ViewController.m
//  PFNetworkingExample
//
//  Created by flyrees on 2017/12/19.
//  Copyright © 2017年 flyrees. All rights reserved.
//

#import "ViewController.h"
#import "PFAFNetworking.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self getDataList];
}
- (void)getDataList {
    [PFAFNetworking getUrl:@"http://123.234.227.107:19000/csp/api/getAppRegionTreeList?userId=1&devType=DEV_CLASS1" body:nil response:PFJSON requestHeadFile:nil success:^(NSURLSessionDataTask *task, id resposeObject) {
        NSLog(@"%@", resposeObject);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
