//
//  NSString+MD5HexDigest.h
//  Padgram
//
//  Created by zhao wei on 13-11-4.
//  Copyright (c) 2013年 Pinssible. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonDigest.h>

@interface NSString (MD5HexDigest)

- (NSString *)wy_md5HexDigest;

@end
