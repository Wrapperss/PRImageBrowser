//
//  PRImageData.m
//  Pods-PRPhotoBrowser_Example
//
//  Created by 张力明 on 2020/8/17.
//

#import "PRImageData.h"

@implementation PRImageData

- (instancetype)initWithType:(PRImageDataType)type {
    self = [super init];
    if (self) {
        self.type = type;
    }
    return self;
}

- (instancetype)initLocalImage:(UIImage *)localImage {
    self = [self initWithType:PRImageDataTypeLocal];
    if (self) {
        self.localImage = localImage;
    }
    return self;
}

- (instancetype)initNetworkImage:(NSString *)imageUrl {
    self = [self initWithType:PRImageDataTypeNetwork];
    if (self) {
        self.imageUrl = imageUrl;
    }
    return self;
}


- (instancetype)initNetworkImage:(NSString *)imageUrl placeHolderImage:(UIImage *)placeHolderImage {
    self = [self initWithType:PRImageDataTypeNetwork];
    if (self) {
        self.imageUrl = imageUrl;
        self.placeHolderImage = placeHolderImage;
    }
    return self;
}

@end
