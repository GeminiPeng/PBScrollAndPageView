//
//  PBScrollAndPageView.h
//  ScrollAndPageView
//
//  Created by ten-step on 16/1/12.
//  Copyright © 2016年 ten-step. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol PBScrollViewDelegate;
@interface PBScrollAndPageView : UIView<UIScrollViewDelegate>
{
    __unsafe_unretained id <PBScrollViewDelegate> _delegate;
}
@property (nonatomic,assign)id<PBScrollViewDelegate>delegate;
@property (nonatomic,assign)NSInteger currenPage;
@property (nonatomic,strong)NSMutableArray *imageArray;
@property (nonatomic,readonly)UIScrollView *scrollview;
@property (nonatomic,readonly)UIPageControl *pageControl;
-(void)shouldAutoShow:(BOOL)shouldStart;
@end
@protocol PBScrollViewDelegate <NSObject>

@optional
- (void)didClickPage:(PBScrollAndPageView *)view atIndex:(NSInteger )index;

@end