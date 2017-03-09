//
//  CommonImageManager.h
//  CommonImageManager
//
//  Created by wyan assert on 2017/3/9.
//  Copyright © 2017年 wyan assert. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CommonImageManager : NSObject

+ (instancetype)sharedInstance;

- (void)configureBundlesName:(NSArray<NSString *> *)bundleNameArray;

@end
