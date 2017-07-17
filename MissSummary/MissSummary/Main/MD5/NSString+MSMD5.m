//
//  NSString+MSMD5.m
//  Miss
//
//  Created by miss on 17/3/29.
//  Copyright © 2017年 mukr. All rights reserved.
//

#import "NSString+MSMD5.h"
#import <CommonCrypto/CommonCrypto.h>

@implementation NSString (MSMD5)

- (id)MD5 {
    const char *cStr = [self UTF8String];
    unsigned char digest[CC_MD5_DIGEST_LENGTH];
    CC_MD5(cStr,(UInt32)strlen(cStr),digest);
    
    NSMutableString *output = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH];
    
    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
        [output appendFormat:@"%02x", digest[i]];
    
    return  output;

}

@end
