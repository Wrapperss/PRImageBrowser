//
//  PRImageBrowser.m
//  PRImageBrowser
//
//  Created by 张力明 on 2020/8/17.
//

#import "PRImageBrowser.h"
#import "PRImageCell.h"
#import "PRImageCollectionLayout.h"

@interface PRImageBrowser() <UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionView *collectionView;

@property (nonatomic, copy) NSArray *imageDatas;

@end

@implementation PRImageBrowser

- (instancetype)init {
    self = [super init];
    if (self) {
        [self setUpUI];
    }
    return self;
}

#pragma mark - Public Function

- (void)showImages:(NSArray *)images {
    [self showImages:images currentIndex:0 toView:[UIApplication sharedApplication].keyWindow];
}

- (void)showImages:(NSArray *)images currentIndex:(NSInteger)currentIndex {
    [self showImages:images currentIndex:currentIndex toView:[UIApplication sharedApplication].keyWindow];
}

- (void)showImages:(NSArray *)images toView:(UIView *)view {
    [self showImages:images currentIndex:0 toView:view];
}

- (void)showImages:(NSArray *)images currentIndex:(NSInteger)currentIndex toView:(UIView *)view {
    self.imageDatas = images;
    [view addSubview:self];
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    CGFloat scrrenHeight = [UIScreen mainScreen].bounds.size.height;
    self.frame = CGRectMake(0, scrrenHeight, screenWidth, scrrenHeight);
    self.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [self.collectionView reloadData];
    [UIView animateWithDuration:0.3 animations:^{
        self.frame = view.bounds;
    }];
}

- (void)dismiss {
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    CGFloat scrrenHeight = [UIScreen mainScreen].bounds.size.height;
    [UIView animateWithDuration:0.3 animations:^{
        self.frame = CGRectMake(0, scrrenHeight, screenWidth, scrrenHeight);
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

#pragma mark - Private Function

- (void)setUpUI {
    self.backgroundColor = [UIColor blackColor];
    [self addSubview:self.collectionView];
    self.collectionView.frame = self.bounds;
    self.collectionView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [self.collectionView registerClass:[PRImageCell class] forCellWithReuseIdentifier:@"PRImageCell"];
}

#pragma mark -  UICollectionViewDelegate & UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.imageDatas.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    PRImageCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"PRImageCell" forIndexPath:indexPath];
    if (!cell) {
        cell = [[PRImageCell alloc] init];
    }
    [cell config:self.imageDatas[indexPath.row]];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath {
    if ([cell isKindOfClass:[PRImageCell class]]) {
        PRImageCell *imageCell = (PRImageCell *)cell;
        [imageCell adjustFrame];
    }
}

#pragma mark - getters & setters

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[PRImageCollectionLayout alloc] init];
        _collectionView = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:layout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.pagingEnabled = YES;
    }
    return _collectionView;
}

@end
