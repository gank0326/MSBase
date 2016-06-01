//
//  UIImage+Compress.m
//  MQ
//
//  Created by wywk on 15/12/14.
//  Copyright © 2015年 juchuang. All rights reserved.
//

#import "UIImage+Compress.h"

#define MQ_1k 1024.0          // 1k
#define MAX_IMAGEDATA_LEN 400*MQ_1k  // max data length 400K

@implementation UIImage (Compress)

- (NSData *)mqCompressImage {
    
    NSData *imageData = UIImageJPEGRepresentation(self, 1.0);
    if ([imageData length]<=MAX_IMAGEDATA_LEN) {
        return imageData;
    }
    else {
        CGFloat compression = 0.9f;
        CGFloat maxCompression = 0.1f;
        NSData *compressImageData = UIImageJPEGRepresentation(self, compression);
        
        while ([compressImageData length] > MAX_IMAGEDATA_LEN && compression > maxCompression) {
            compression -= 0.1;
            compressImageData = UIImageJPEGRepresentation(self, compression);
        }
        return compressImageData;
    }
}

@end
