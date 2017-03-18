//
//  ViewController.m
//  DWQRuntime_2_ExchangeMethod
//
//  Created by 杜文全 on 17/3/18.
//  Copyright © 2017年 com.iOSDeveloper.duwenquan. All rights reserved.
//

#import "ViewController.h"
#import "UIImage+DWQcategory.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // imageNamed:
    // 实现方法:底层调用dwq_imageNamed
    
    // 本质:交换两个方法的实现imageNamed和xmg_imageNamed方法
    // 调用imageNamed其实就是调用dwq_imageNamed
   UIImage *image=  [UIImage imageNamed:@"runtime"];
    
   
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
