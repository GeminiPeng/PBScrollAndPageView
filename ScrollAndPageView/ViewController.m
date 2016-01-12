//
//  ViewController.m
//  ScrollAndPageView
//
//  Created by ten-step on 16/1/12.
//  Copyright © 2016年 ten-step. All rights reserved.
//

#import "ViewController.h"
#import "PBScrollAndPageView.h"
@interface ViewController ()<PBScrollViewDelegate>
{
    PBScrollAndPageView * scroll;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    scroll = [[PBScrollAndPageView alloc]initWithFrame:CGRectMake(0, 44, 320, 400)];
    NSMutableArray * tempAry = [NSMutableArray array];
    for (int i =1; i<10; i++) {
        UIImageView * imageView = [[UIImageView alloc]init];
        imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%d.jpg",i]];
        [tempAry addObject:imageView];
    }
    
    [scroll setImageArray:tempAry];

    [self.view addSubview:scroll];

    [scroll shouldAutoShow:YES];

    scroll.delegate = self;
}
- (void)didClickPage:(PBScrollAndPageView *)view atIndex:(NSInteger)index{
    NSLog(@"%ld",index);
}
- (void)viewDidDisappear:(BOOL)animated{
    [scroll shouldAutoShow:NO];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
