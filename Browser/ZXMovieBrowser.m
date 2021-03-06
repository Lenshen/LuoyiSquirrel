//
//  ZXMovieBrowser.m
//  ZXMovieBrowser
//
//  Created by Shawn on 16/6/21.
//  Copyright © 2016年 Shawn. All rights reserved.
//

#import "ZXMovieBrowser.h"
#import "UIImageView+WebCache.h"

#define kBaseTag 100
#define kScreenWidth  [UIScreen mainScreen].bounds.size.width
#define kItemSpacing 25.0
#define kItemWidth  200.0
#define kItemHeight 105.0
#define kItemSelectedWidth  200.0
#define kItemSelectedHeight 108.0
#define kScrollViewContentOffset (kScreenWidth / 2.0 - (kItemWidth / 2.0 + kItemSpacing))

@interface ZXMovieBrowser () <UIScrollViewDelegate>

@property (nonatomic, assign, readwrite) NSInteger      currentIndex;
@property (nonatomic, strong, readwrite) NSMutableArray *movies;
@property (nonatomic, strong, readwrite) NSMutableArray *items;
@property (nonatomic, assign, readwrite) CGPoint        scrollViewContentOffset;
@property (nonatomic, strong, readwrite) UIScrollView   *scrollView;
@property (nonatomic, strong, readwrite) UIImageView    *backgroundView;

@end

@implementation ZXMovieBrowser

- (instancetype)initWithFrame:(CGRect)frame movies:(NSArray *)movies
{
    self = [super initWithFrame:frame];
    if (self) {
        self.movies = [movies mutableCopy];
        [self commonInit];
    }
    
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame movies:(NSArray *)movies currentIndex:(NSInteger)index
{
    self = [super initWithFrame:frame];
    if (self) {
        self.movies = [movies mutableCopy];
        [self commonInit];
        [self setCurrentMovieIndex:index];
    }
    
    return self;
}

- (void)setCurrentMovieIndex:(NSInteger)index
{
    if (index >= 0 && index < self.movies.count) {
        self.currentIndex = index;
        CGPoint point = CGPointMake((kItemSpacing + kItemWidth) * index - kScrollViewContentOffset, 0);
        [self.scrollView setContentOffset:point animated:NO];
        
        [self backgroundViewFadeTransition];
    }
}

#pragma mark - Setup

- (void)commonInit
{
    _backgroundView = [[UIImageView alloc] initWithFrame:self.bounds];
    _backgroundView.contentMode = UIViewContentModeScaleToFill;
    _backgroundView.backgroundColor = [UIColor grayColor];
    [self addSubview:_backgroundView];
    if (self.movies.count > 0) {
        [_backgroundView sd_setImageWithURL:[NSURL URLWithString:((ZXMovie *)self.movies[0]).coverUrl]];
    }
    
    UIVisualEffectView *blurView = [[UIVisualEffectView alloc] initWithEffect:[UIBlurEffect effectWithStyle:UIBlurEffectStyleLight]];
    blurView.frame = self.bounds;
    [self addSubview:blurView];
    
    [self setupScrollView];
}

- (void)setupScrollView
{
    _scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
    [self addSubview:_scrollView];
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.decelerationRate = UIScrollViewDecelerationRateFast;
    _scrollView.alwaysBounceHorizontal = YES;
    _scrollView.delegate = self;
    _scrollView.contentInset = UIEdgeInsetsMake(0, kScrollViewContentOffset, 0, kScrollViewContentOffset);
    _scrollView.contentSize = CGSizeMake((kItemWidth + kItemSpacing) * self.movies.count + kItemSpacing, kMovieBrowserHeight);
    
    NSInteger i = 0;
    _items = [NSMutableArray array];
    for (ZXMovie *movie in self.movies) {
        UIView *itemView = [[UIView alloc] initWithFrame:CGRectMake((kItemSpacing + kItemWidth) * i + kItemSpacing, (kMovieBrowserHeight - kItemHeight)/2, kItemWidth, kItemHeight)];
        [_scrollView addSubview:itemView];
        
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kItemWidth, kItemHeight)];
        imageView.layer.cornerRadius = 5;
        imageView.layer.masksToBounds = YES;

        [imageView sd_setImageWithURL:[NSURL URLWithString:movie.coverUrl]];
        imageView.userInteractionEnabled = YES;
        imageView.tag = i + kBaseTag;
        [itemView addSubview:imageView];
        [self.items addObject:imageView];
        
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapDetected:)];
        [imageView addGestureRecognizer:tapGesture];
        
        i++;
    }
}

#pragma mark - Layout

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    if (self.movies.count != 0) {
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            if ([self.delegate respondsToSelector:@selector(movieBrowser:didChangeItemAtIndex:)]) {
                [self.delegate movieBrowser:self didChangeItemAtIndex:self.currentIndex];
            }
            if ([self.delegate respondsToSelector:@selector(movieBrowser:didEndScrollingAtIndex:)]) {
                [self.delegate movieBrowser:self didEndScrollingAtIndex:self.currentIndex];
            }
        });
//        [self adjustSubviews:self.scrollView];
    }
}



#pragma mark - Tap Detection

- (void)tapDetected:(UITapGestureRecognizer *)tapGesture
{
    if (tapGesture.view.tag == self.currentIndex + kBaseTag) {
        if ([self.delegate respondsToSelector:@selector(movieBrowser:didSelectItemAtIndex:)]) {
            [self.delegate movieBrowser:self didSelectItemAtIndex:self.currentIndex];
            return;
        }
    }
    
    CGPoint point = [tapGesture.view.superview convertPoint:tapGesture.view.center toView:self.scrollView];
    point = CGPointMake(point.x - kScrollViewContentOffset - ((kItemWidth / 2 + kItemSpacing)), 0);
    self.scrollViewContentOffset = point;
    
    [self.scrollView setContentOffset:point animated:YES];
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    NSInteger index = (scrollView.contentOffset.x + kScrollViewContentOffset + (kItemWidth / 2 + kItemSpacing / 2)) / (kItemWidth + kItemSpacing);
    index = MIN(self.movies.count - 1, MAX(0, index));
    
    if (self.currentIndex != index) {
        self.currentIndex = index;
    }
    
//    [self adjustSubviews:scrollView];
}

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset
{
    NSInteger index = (targetContentOffset->x + kScrollViewContentOffset + (kItemWidth / 2 + kItemSpacing / 2)) / (kItemWidth + kItemSpacing);
    targetContentOffset->x = (kItemSpacing + kItemWidth) * index - kScrollViewContentOffset;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if ([self.delegate respondsToSelector:@selector(movieBrowser:didEndScrollingAtIndex:)]) {
        [self.delegate movieBrowser:self didEndScrollingAtIndex: self.currentIndex];
    }
    
    if (self.currentIndex < self.movies.count) {
        [self backgroundViewFadeTransition];
    }
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    if (!CGPointEqualToPoint(self.scrollViewContentOffset, self.scrollView.contentOffset)) {
        [self.scrollView setContentOffset:self.scrollViewContentOffset animated:YES];
    } else {
        if ([self.delegate respondsToSelector:@selector(movieBrowser:didEndScrollingAtIndex:)]) {
            [self.delegate movieBrowser:self didEndScrollingAtIndex:self.currentIndex];
        }
        
        [self backgroundViewFadeTransition];
    }
}

#pragma mark - backgroundView

- (void)backgroundViewFadeTransition
{
    [self.backgroundView sd_setImageWithURL:[NSURL URLWithString:((ZXMovie *)self.movies[self.currentIndex]).coverUrl]];
    
    CATransition *transition = [CATransition animation];
    transition.duration = 0.6f;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    transition.type = kCATransitionFade;
    [self.backgroundView.layer addAnimation:transition forKey:nil];
}

#pragma mark - setters

- (void)setCurrentIndex:(NSInteger)currentIndex
{
    _currentIndex = currentIndex;
    
    if ([self.delegate respondsToSelector:@selector(movieBrowser:didChangeItemAtIndex:)]) {
        [self.delegate movieBrowser:self didChangeItemAtIndex:_currentIndex];
    }
}

@end
