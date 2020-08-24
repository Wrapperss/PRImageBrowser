//
//  PRImageCell.m
//  PRImageBrowser
//
//  Created by 张力明 on 2020/8/17.
//

#import "PRImageCell.h"
#import <SDWebImage/SDWebImage.h>
#import "PRImageBrowserDefine.h"
#import "PRImageBrowserDefine.h"

@interface PRImageCell() <UIScrollViewDelegate, UIGestureRecognizerDelegate>

@property (nonatomic, strong) UIActivityIndicatorView *activityIndicator;

@property (nonatomic, strong) UIImageView *imageView;

@property (nonatomic, strong) UIScrollView *imageScrollView;

@property (nonatomic, assign) BOOL isZoom;

@end

@implementation PRImageCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
        [self addGesture];
    }
    return self;
}

- (void)setupUI {
    self.imageScrollView.frame = self.bounds;
    [self.contentView addSubview:self.imageScrollView];
    
    [self.imageScrollView addSubview:self.imageView];
    
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    CGFloat height = [UIScreen mainScreen].bounds.size.height;
    self.activityIndicator.frame = CGRectMake(width / 2 - 50, height / 2 - 50, 100, 100);
    [self.imageScrollView addSubview:self.activityIndicator];
}

#pragma mark - Config
- (void)config:(PRImageData *)imageData {
    switch (imageData.type) {
        case PRImageDataTypeLocal:
            self.imageView.image = imageData.localImage;
            [self adjustFrame];
            break;
        case PRImageDataTypeNetwork:
        {
            [self.activityIndicator startAnimating];
            NSURL *url = [NSURL URLWithString:imageData.imageUrl];

            __weak __typeof(self) wself = self;

            if (imageData.placeHolderImage) {
                [self.imageView sd_setImageWithURL:url placeholderImage:imageData.placeHolderImage completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
                    [wself adjustFrame];
                    [wself.activityIndicator stopAnimating];
                }];
            } else {
                [self.imageView sd_setImageWithURL:url completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
                    [wself adjustFrame];
                    [wself.activityIndicator stopAnimating];
                }];
            }
            break;
        }
    }
}

#pragma mark - Frame
- (void)adjustFrame {
    CGRect frame = self.imageScrollView.frame;
    if (frame.size.width == 0 || frame.size.height == 0) {
        return;
    }
    
    if (self.imageView.image) {
        CGSize imageSize = self.imageView.image.size;
        CGRect imageF = (CGRect){{0, 0}, imageSize};
        
        // 图片的宽度 = 屏幕的宽度
        CGFloat ratio = frame.size.width / imageF.size.width;
        imageF.size.width  = frame.size.width;
        imageF.size.height = ratio * imageF.size.height;
        
        // 图片的高度 > 屏幕的高度
        if (imageF.size.height > frame.size.height) {
            CGFloat scale = imageF.size.width / imageF.size.height;
            imageF.size.height = frame.size.height;
            imageF.size.width  = imageF.size.height * scale;
        }
        
        // 设置图片的frame
        self.imageView.frame = imageF;
        
        self.imageScrollView.contentSize = self.imageView.frame.size;
        
        if (imageF.size.height <= self.imageScrollView.bounds.size.height) {
            self.imageView.center = CGPointMake(self.imageScrollView.bounds.size.width * 0.5, self.imageScrollView.bounds.size.height * 0.5);
        } else {
            self.imageView.center = CGPointMake(self.imageScrollView.bounds.size.width * 0.5, imageF.size.height * 0.5);
        }
    }
}

#pragma mark - Gesture
- (void)addGesture {
    UITapGestureRecognizer *tapSingle = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(respondsToTapSingle:)];
    tapSingle.numberOfTapsRequired = 1;
    UITapGestureRecognizer *tapDouble = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(respondsToTapDouble:)];
    tapDouble.numberOfTapsRequired = 2;
    
    [tapSingle requireGestureRecognizerToFail:tapDouble];
    
    [self addGestureRecognizer:tapSingle];
    [self addGestureRecognizer:tapDouble];
}

- (void)respondsToTapSingle:(UITapGestureRecognizer *)tap {
    [[NSNotificationCenter defaultCenter] postNotificationName:@"PRImageBrowserDismiss" object:nil];
}

- (void)respondsToTapDouble:(UITapGestureRecognizer *)tap {
    if (self.isZoom) {
        [self.imageScrollView setZoomScale:1.0 animated:YES];
    } else {
        CGPoint point = [tap locationInView:self];
        CGRect zoomRect = [self zoomRectForScrollView:self.imageScrollView withScale:3.0 withCenter:point];
        [self.imageScrollView zoomToRect:zoomRect animated:YES];
    }
    self.isZoom = (self.imageScrollView.zoomScale != 1.0);
}

- (CGRect)zoomRectForScrollView:(UIScrollView *)scrollView withScale:(float)scale withCenter:(CGPoint)center {
 
    CGRect zoomRect;

    zoomRect.size.height = scrollView.frame.size.height / scale;
    zoomRect.size.width  = scrollView.frame.size.width  / scale;
 
    zoomRect.origin.x = center.x - (zoomRect.size.width  / 2.0);
    zoomRect.origin.y = center.y - (zoomRect.size.height / 2.0);
 
    return zoomRect;
}

#pragma mark - <UIGestureRecognizerDelegate>

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return YES;
}

#pragma mark - UIScrollViewDelegate

- (CGPoint)centerOfScrollViewContent:(UIScrollView *)scrollView {
    CGFloat offsetX = (scrollView.bounds.size.width > scrollView.contentSize.width) ? (scrollView.bounds.size.width - scrollView.contentSize.width) * 0.5 : 0;
    CGFloat offsetY = (scrollView.bounds.size.height > scrollView.contentSize.height) ? (scrollView.bounds.size.height - scrollView.contentSize.height) * 0.5 : 0;
    CGPoint actualCenter = CGPointMake(scrollView.contentSize.width * 0.5 + offsetX, scrollView.contentSize.height * 0.5 + offsetY);
    return actualCenter;
}

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    return self.imageView;
}

- (void)scrollViewDidZoom:(UIScrollView *)scrollView {
    self.imageView.center = [self centerOfScrollViewContent:scrollView];
}

#pragma mark - getter

- (UIActivityIndicatorView *)activityIndicator {
    if (!_activityIndicator) {
        _activityIndicator = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:(UIActivityIndicatorViewStyleGray)];
        [_activityIndicator setHidesWhenStopped:YES];
        [_activityIndicator setColor:[UIColor whiteColor]];
    }
    return _activityIndicator;
}

- (UIImageView *)imageView {
    if (!_imageView) {
        _imageView = [[UIImageView alloc] init];
        _imageView.contentMode = UIViewContentModeScaleAspectFit;
        _imageView.layer.masksToBounds = YES;
    }
    return _imageView;
}

- (UIScrollView *)imageScrollView {
    if (!_imageScrollView) {
        _imageScrollView = [[UIScrollView alloc] init];
        _imageScrollView.showsHorizontalScrollIndicator = NO;
        _imageScrollView.showsVerticalScrollIndicator = NO;
        _imageScrollView.decelerationRate = UIScrollViewDecelerationRateFast;
        _imageScrollView.maximumZoomScale = 3;
        _imageScrollView.minimumZoomScale = 1;
        _imageScrollView.alwaysBounceHorizontal = NO;
        _imageScrollView.alwaysBounceVertical = NO;
        _imageScrollView.layer.masksToBounds = NO;
        _imageScrollView.multipleTouchEnabled = YES;
        if (@available(iOS 11.0, *)) {
            _imageScrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
        _imageScrollView.delegate = self;
    }
    return _imageScrollView;
}

@end
