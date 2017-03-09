//
//  UIImage+WYImageNamed.m
//  CommonImageManager
//
//  Created by wyan assert on 2017/3/9.
//  Copyright © 2017年 wyan assert. All rights reserved.
//

#import "UIImage+WYImageNamed.h"
#import <objc/runtime.h>

@implementation UIImage (WYImageNamed)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        Class selfClass = object_getClass([self class]);
        
        SEL oriSEL = @selector(imageNamed:);
        Method oriMethod = class_getInstanceMethod(selfClass, oriSEL);
        
        SEL cusSEL = @selector(wy_imageNamed:);
        Method cusMethod = class_getInstanceMethod(selfClass, cusSEL);
        
        BOOL addSucc = class_addMethod(selfClass, oriSEL, method_getImplementation(cusMethod), method_getTypeEncoding(cusMethod));
        if (addSucc) {
            class_replaceMethod(selfClass, cusSEL, method_getImplementation(oriMethod), method_getTypeEncoding(oriMethod));
        }else {
            method_exchangeImplementations(oriMethod, cusMethod);
        }
        
    });
}

#pragma mark - Method Swizzling


+ (UIImage *)wy_imageNamed:(NSString *)name {
    
    return [self wy_imageNamed:name];
}

@end
