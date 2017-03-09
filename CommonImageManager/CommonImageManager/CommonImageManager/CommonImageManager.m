//
//  CommonImageManager.m
//  CommonImageManager
//
//  Created by wyan assert on 2017/3/9.
//  Copyright © 2017年 wyan assert. All rights reserved.
//

#import "CommonImageManager.h"
#import <UIKit/UIKit.h>
#import "RNDecryptor.h"

static NSString *tailIdentifier = @"cxy";
static NSString *encryptKey = @"wyan";

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

- (UIImage *)getImageWithName:(NSString *)name {
    NSString *originImageName = [self transNameToMD5:[self getImageOriginName:name]];
    NSString *scaleImageName = [self transNameToMD5:[NSString stringWithFormat:@"%@@%@x", originImageName, @([UIScreen mainScreen].scale).stringValue]];
    
    NSString *findName = nil;
    NSBundle *findBundle = nil;
    if(scaleImageName.length) {
        findBundle = [self.imageBundleMap objectForKey:scaleImageName];
        if(findBundle) {
            findName = scaleImageName;
        }
    }
    if(!findName || !findBundle) {
        findBundle = [self.imageBundleMap objectForKey:originImageName];
        if(findBundle) {
            findName = originImageName;
        }
    }
    
    if(findName && findBundle) {
        return [self readImageWithName:findName bundle:findBundle];
    }
    
    
    return nil;
}


#pragma mark - Private
- (NSString *)getImageOriginName:(NSString *)name {
    NSRange originScaleMarkRange = [name rangeOfString:@"@" options:NSBackwardsSearch];
    if(originScaleMarkRange.length == 0 || originScaleMarkRange.location == NSNotFound) {
        return name;
    } else {
        return [name substringToIndex:originScaleMarkRange.location];
    }
}

- (NSString *)transNameToMD5:(NSString *)name {
    return name;
}

- (UIImage *)readImageWithName:(NSString *)name bundle:(NSBundle *)bundle {
    NSData *encryptedData = [NSData dataWithContentsOfFile:[bundle pathForResource:[NSString stringWithFormat:@"%@.%@", name, tailIdentifier] ofType:nil]];
    if(encryptedData) {
        NSError *error;
        NSData *decryptedData = [RNDecryptor decryptData:encryptedData
                                            withPassword:encryptKey
                                                   error:&error];
        if (!error) {
            UIImage *image = [UIImage imageWithData:decryptedData];
            return image;
            
        }
    }
    return nil;
}


#pragma mark - Getter
- (NSMutableDictionary<NSString *,NSBundle *> *)imageBundleMap {
    if(!_imageBundleMap) {
        _imageBundleMap = [NSMutableDictionary dictionary];
    }
    return _imageBundleMap;
}

@end
