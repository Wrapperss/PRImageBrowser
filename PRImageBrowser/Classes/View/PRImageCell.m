//
//  PRImageCell.m
//  PRImageBrowser
//
//  Created by 张力明 on 2020/8/17.
//

#import "PRImageCell.h"

@interface PRImageCell() <UIScrollViewDelegate, UIGestureRecognizerDelegate>

@property (nonatomic, strong)UIImageView *imageView;

@property (nonatomic, strong) UIScrollView *imageScrollView;

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
    
    self.imageView.backgroundColor = [UIColor orangeColor];
    [self.imageScrollView addSubview:self.imageView];
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    CGFloat height = [UIScreen mainScreen].bounds.size.height;
    self.imageView.frame = CGRectMake(self.bounds.origin.x, height / 2 - 150, width, 300);
}

#pragma mark - Gesture
- (void)addGesture {
    UITapGestureRecognizer *tapSingle = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(respondsToTapSingle:)];
    tapSingle.numberOfTapsRequired = 1;
    UITapGestureRecognizer *tapDouble = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(respondsToTapDouble:)];
    tapDouble.numberOfTapsRequired = 2;
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(respondsToPan:)];
    pan.maximumNumberOfTouches = 1;
    pan.delegate = self;
    
    [tapSingle requireGestureRecognizerToFail:tapDouble];
    [tapSingle requireGestureRecognizerToFail:pan];
    [tapDouble requireGestureRecognizerToFail:pan];
    
    [self addGestureRecognizer:tapSingle];
    [self addGestureRecognizer:tapDouble];
    [self addGestureRecognizer:pan];
}

- (void)respondsToTapSingle:(UITapGestureRecognizer *)tap {
    
}

- (void)respondsToTapDouble:(UITapGestureRecognizer *)tap {
    
}

- (void)respondsToPan:(UIPanGestureRecognizer *)pan {

}
#pragma mark - <UIGestureRecognizerDelegate>

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return YES;
}



#pragma mark - UIScrollViewDelegate

#pragma mark - getter

- (UIImageView *)imageView {
    if (!_imageView) {
        _imageView = [[UIImageView alloc] init];
        _imageView.contentMode = UIViewContentModeScaleAspectFill;
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
        _imageScrollView.maximumZoomScale = 1;
        _imageScrollView.minimumZoomScale = 1;
        _imageScrollView.alwaysBounceHorizontal = NO;
        _imageScrollView.alwaysBounceVertical = NO;
        _imageScrollView.layer.masksToBounds = NO;
        if (@available(iOS 11.0, *)) {
            _imageScrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
        _imageScrollView.delegate = self;
    }
    return _imageScrollView;
}

@end
