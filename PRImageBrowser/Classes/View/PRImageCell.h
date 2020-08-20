//
//  PRImageCell.h
//  PRImageBrowser
//
//  Created by 张力明 on 2020/8/17.
//

#import <UIKit/UIKit.h>
#import "PRImageData.h"

NS_ASSUME_NONNULL_BEGIN

@interface PRImageCell : UICollectionViewCell

- (void)config:(PRImageData *)imageData;

- (void)adjustFrame;

@end

NS_ASSUME_NONNULL_END
