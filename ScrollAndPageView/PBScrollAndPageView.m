//
//  PBScrollAndPageView.m
//  ScrollAndPageView
//
//  Created by ten-step on 16/1/12.
//  Copyright © 2016年 ten-step. All rights reserved.
//

#import "PBScrollAndPageView.h"
@interface PBScrollAndPageView()
{
    UIView *_firstView;
    UIView *_secendView;
    UIView *_lastView;
    
    float _viewWidth;
    float _viewHight;
    NSTimer * _autoTimer;
    UITapGestureRecognizer * _tap;
}
@end
@implementation PBScrollAndPageView
- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        _viewWidth = self.bounds.size.width;
        _viewHight =self.bounds.size.height;
        
        //设置scrollview
        _scrollview = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, _viewWidth, _viewHight)];
        _scrollview.delegate =self;
        _scrollview.contentSize = CGSizeMake(_viewWidth*3, _viewHight);
        _scrollview.showsHorizontalScrollIndicator = NO;
        _scrollview.pagingEnabled = YES;
        _scrollview.backgroundColor = [UIColor blackColor];
        [self addSubview:_scrollview];
        
        //设置pageview
        _pageControl = [[UIPageControl alloc]initWithFrame:CGRectMake(0, _viewHight-30, _viewWidth, 30)];
        _pageControl.userInteractionEnabled = NO;
        _pageControl.currentPageIndicatorTintColor = [UIColor redColor];
        _pageControl.pageIndicatorTintColor = [UIColor whiteColor];
        [self addSubview:_pageControl];
        
        //设置手势
        _tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(handTap:)];
        _tap.numberOfTapsRequired = 1;
        _tap.numberOfTouchesRequired = 1;
        [_scrollview addGestureRecognizer:_tap];
    }
    return self;
}
#pragma -mark 手势方法
- (void)handTap:(UITapGestureRecognizer *)sender{
    if ([_delegate respondsToSelector:@selector(didClickPage:atIndex:)]) {
        [_delegate didClickPage:self atIndex:_currenPage+1];
    }
}
#pragma -mark 设置imageArray
- (void)setImageArray:(NSMutableArray *)imageArray{
    if (imageArray) {
        _imageArray = imageArray;
        _currenPage = 0;//默认从0开始
        _pageControl.numberOfPages = _imageArray.count;
    }
    [self reloadData];
}
#pragma -mark 刷新view
- (void)reloadData{
    [_firstView removeFromSuperview];
    [_secendView removeFromSuperview];
    [_lastView removeFromSuperview];
    if (_currenPage ==0) {
        _firstView = [_imageArray lastObject];
        _secendView = [_imageArray objectAtIndex:_currenPage];
        _lastView = [_imageArray objectAtIndex:_currenPage+1];
    }else if (_currenPage == _imageArray.count-1){
        _firstView = [_imageArray objectAtIndex:_currenPage-1];
        _secendView = [_imageArray objectAtIndex:_currenPage];
        _lastView = [_imageArray firstObject];
    }else{
        _firstView = [_imageArray objectAtIndex:_currenPage-1];
        _secendView = [_imageArray objectAtIndex:_currenPage];
        _lastView = [_imageArray objectAtIndex:_currenPage+1];
    }
    //设置三个view的frame，加到scrollview上
    _firstView.frame = CGRectMake(0, 0, _viewWidth, _viewHight);
    _secendView.frame = CGRectMake(_viewWidth, 0, _viewWidth, _viewHight);
    _lastView.frame = CGRectMake(_viewWidth*2, 0, _viewWidth, _viewHight);
    [_scrollview addSubview:_firstView];
    [_scrollview addSubview:_secendView];
    [_scrollview addSubview:_lastView];
    
    _pageControl.currentPage = _currenPage;
    
    //显示中间页
    _scrollview.contentOffset = CGPointMake(_viewWidth, 0);
}
#pragma -mark 停止滑动
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    [_autoTimer invalidate];
    _autoTimer = nil;
    _autoTimer = [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(showNextImage) userInfo:nil repeats:YES];
    float x = _scrollview.contentOffset.x;
    if (x<=0) {
        if (_currenPage-1<0) {
            _currenPage = _imageArray.count-1;
        }else{
            _currenPage--;
        }
    }
    if (x>=_viewWidth*2) {
        if (_currenPage == _imageArray.count-1) {
            _currenPage = 0;
        }else{
            _currenPage ++;
        }
    }
    [self reloadData];
}
#pragma - mark 自动滑动
- (void)shouldAutoShow:(BOOL)shouldStart{
    if (shouldStart) {
        if (!_autoTimer) {
            _autoTimer = [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(showNextImage) userInfo:nil repeats:YES];
        }
    }else{
        if (_autoTimer.isValid) {
            [_autoTimer invalidate];
            _autoTimer = nil;
        }
    }
}
#pragma - mark 下一页
- (void)showNextImage{
    if (_currenPage == _imageArray.count-1) {
        _currenPage = 0;
    }else{
        _currenPage++;
    }
    [self reloadData];
}

@end
