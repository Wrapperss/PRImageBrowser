//
//  PRImageData.h
//  Pods-PRPhotoBrowser_Example
//
//  Created by 张力明 on 2020/8/17.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    PRImageDataTypeNetwork = 0, // 网络图片
    PRImageDataTypeLocal = 1, // 本地图片
} PRImageDataType;

NS_ASSUME_NONNULL_BEGIN

@interface PRImageData : NSObject

// 本地图片
@property (nonatomic, strong)UIImage *localImage;

// 网络图片URL
@property (nonatomic, copy)NSString *imageUrl;

// 默认图
@property (nonatomic, strong)UIImage *placeHolderImage;

- (instancetype)initWithType:(PRImageDataType)type;

- (instancetype)initLocalImage:(UIImage *)localImage;

- (instancetype)initNetworkImage:(NSString *)imageUrl;

- (instancetype)initNetworkImage:(NSString *)imageUrl placeHolderImage:(UIImage *)placeHolderImage;

@end

NS_ASSUME_NONNULL_END
