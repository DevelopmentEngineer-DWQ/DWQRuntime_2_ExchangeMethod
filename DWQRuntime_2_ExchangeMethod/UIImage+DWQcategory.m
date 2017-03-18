//
//  UIImage+DWQcategory.m
//  DWQRuntime_2_ExchangeMethod
//
//  Created by 杜文全 on 17/3/18.
//  Copyright © 2017年 com.iOSDeveloper.duwenquan. All rights reserved.
//

#import "UIImage+DWQcategory.h"
#import <objc/message.h>
@implementation UIImage (DWQcategory)
+ (void)load
{
    
    // 交换方法实现,方法都是定义在类里面
    // class_getInstanceMethod:获取对象
    // class_getClassMethod:获取类方法
    // IMP:方法实现
    
    // imageNamed
    // Class:获取哪个类方法
    // SEL:获取方法编号,根据SEL就能去对应的类找方法
    Method imageNameMethod = class_getClassMethod([UIImage class], @selector(imageNamed:));
    
    // xmg_imageNamed
    Method dwq_imageNamedMethod = class_getClassMethod([UIImage class], @selector(dwq_imageNamed:));
    
    // 交换方法实现
    method_exchangeImplementations(imageNameMethod, dwq_imageNamedMethod);
    
}

// 运行时

+ (UIImage *)dwq_imageNamed:(NSString *)imageName
{
    // 1.加载图片
    UIImage *image = [UIImage dwq_imageNamed:imageName];
    
    // 2.判断功能
    if (image == nil) {
        NSLog(@"图片为空");
    }
    
    return image;
}@end
