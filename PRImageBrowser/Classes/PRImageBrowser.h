//
//  PRImageBrowser.h
//  PRImageBrowser
//
//  Created by 张力明 on 2020/8/17.
//

#import <UIKit/UIKit.h>
#import "PRImageData.h"

NS_ASSUME_NONNULL_BEGIN

@interface PRImageBrowser : UIView

- (void)showImages:(NSArray *)images;

- (void)showImages:(NSArray *)images currentIndex:(NSInteger)currentIndex;

- (void)showImages:(NSArray *)images toView:(UIView *)view;

- (void)showImages:(NSArray *)images currentIndex:(NSInteger)currentIndex toView:(UIView *)view;

- (void)dismiss;

@end

NS_ASSUME_NONNULL_END
