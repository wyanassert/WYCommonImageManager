//
//  CommonImageManager.m
//  CommonImageManager
//
//  Created by wyan assert on 2017/3/9.
//  Copyright © 2017年 wyan assert. All rights reserved.
//

#import "CommonImageManager.h"

@interface CommonImageManager ()

@property (nonatomic, strong) NSMutableDictionary<NSString *, NSBundle *> *imageBundleMap;

@end

@implementation CommonImageManager

+ (instancetype)sharedInstance {
    static CommonImageManager *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[CommonImageManager alloc] init];
    });
    return instance;
}

- (void)configureBundlesName:(NSArray<NSString *> *)bundleNameArray {
    for(NSString *bundleName in bundleNameArray) {
        NSString *resourceBundlePath = [[NSBundle mainBundle] pathForResource:bundleName ofType:@"bundle"];
        if(resourceBundlePath.length == 0) {
            continue;
        }
        NSBundle *resourceBundle = [NSBundle bundleWithPath:resourceBundlePath];
        NSArray *files = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:resourceBundlePath error:NULL];
        for (NSString *fileName in files) {
            NSRange range = [fileName rangeOfString:@"." options:NSBackwardsSearch];
            NSString *imageName = [fileName substringToIndex:range.location];
            if(imageName == nil || imageName.length == 0) {
                continue;
            }
            [self.imageBundleMap setObject:resourceBundle forKey:imageName];
        }
    }
    NSLog(@"%@", self.imageBundleMap);
}


#pragma mark - Getter
- (NSMutableDictionary<NSString *,NSBundle *> *)imageBundleMap {
    if(!_imageBundleMap) {
        _imageBundleMap = [NSMutableDictionary dictionary];
    }
    return _imageBundleMap;
}

@end
