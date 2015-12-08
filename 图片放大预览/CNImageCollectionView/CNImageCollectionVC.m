//
//  CNImageCollectionVC.m
//  CNImageCollectionView
//
//  Created by wang xinkai on 15/7/27.
//  Copyright (c) 2015年 wxk. All rights reserved.
//

#import "CNImageCollectionVC.h"

@interface CNImageCollectionVC ()

@end

@implementation CNImageCollectionVC

- (void)viewDidLoad {
    [super viewDidLoad];
//    [self loadScrollView];
    
    
    
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setFrame:CGRectMake(10, 20, 80, 40)];
    [btn setTitle:@"关闭" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(dmiss) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    
    

}

-(void)viewWillAppear:(BOOL)animated{

    [super viewWillAppear:animated];
    
    
    [self openAnimation];
    
}


-(void)openAnimation{

    CNImageCollectionItem *item = [self.collectionView itemAtIndex:_currentIndex];
    
    CGRect frame = item.frame;
    
//    [原有的坐标系的view  converPoint:坐标点 toView:目标坐标系的view];
    CGPoint p = [self.collectionView convertPoint:item.frame.origin toView:self.collectionView.window];
    
    frame.origin.x = p.x;
    frame.origin.y = p.y;
    
    
    UIImageView *imageV = [[UIImageView alloc] initWithFrame:frame];
    imageV.contentMode = UIViewContentModeScaleAspectFit;
    imageV.image = item.image;
    
    [self.view addSubview:imageV];
    
    
    
    [UIView animateWithDuration:.35 animations:^{
       
        
        imageV.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
        
    } completion:^(BOOL finished) {
        
        
        [self loadScrollView];
        
        [imageV removeFromSuperview];
        
        
        
    }];
    
    
}



-(void)dmiss{
    
    
//    动画前
    CNImageCollectionItem *item = [self.collectionView itemAtIndex:_currentIndex];
    [self.collectionView bringSubviewToFront:item];
    
    
//    获取新的frame
    
//    转换坐标系
    CGPoint point = [self.view.window convertPoint:CGPointMake(0, 0)  toView:self.collectionView];
    CGSize size = [UIScreen mainScreen].bounds.size;
    item.frame = CGRectMake(point.x, point.y,size.width, size.height);
    CGRect frame =   [self.collectionView frameAtIndex:item.index];
    

    [self dismissViewControllerAnimated:NO completion:^{
        
        
        [UIView animateWithDuration:.35f animations:^{
            
            item.frame = frame;
            
        }];
        
    }];

}


-(void)loadScrollView{
    
    
    CGFloat width = self.view.frame.size.width;
    CGFloat height = self.view.frame.size.height;

    _scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    
    _scrollView.pagingEnabled = YES;
    _scrollView.delegate = self;
    
    _scrollView.contentSize = CGSizeMake(_dataList.count*width, self.view.frame.size.height);
    
    for (int i = 0; i<_dataList.count; i++) {
        
        
//    放大第一步
        UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(i*width, 0, self.view.frame.size.width, self.view.frame.size.height)];
        
        scrollView.delegate = self;
        scrollView.maximumZoomScale = 2.f;
        scrollView.minimumZoomScale = 1.f;
        
        
        
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
        
        imageView.tag = 111;
        
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        
        
        
//        NSString *urls = _dataList[i];
//        NSString*bigurlstr    = [urls stringByReplacingOccurrencesOfString:@"thumbnail" withString:@"large"];
        
        imageView.image = _dataList[i];
//        [imageView setImageWithURL:[NSURL URLWithString:bigurlstr]];
        
        
        [scrollView addSubview:imageView];
        
        [_scrollView addSubview:scrollView];
        
        
    }
    
    
    [self.view insertSubview:_scrollView atIndex:0];
    
//    滚动到对应的位置
    [_scrollView scrollRectToVisible:CGRectMake(_currentIndex*width, 0, width, height) animated:NO];

    
}

#pragma mark -
#pragma mark - ScrollView Delegate

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    
    
    if (_scrollView != scrollView ) {
        return;
    }
    
//    更新 currentIndex
    _currentIndex = scrollView.contentOffset.x/scrollView.frame.size.width;
    
    
}


- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView{


    return [scrollView viewWithTag:111];
    
    
}


-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{


    if (scrollView != _scrollView) {
        return;
    }
    
    for (UIScrollView *v in _scrollView.subviews) {
        if ([v isKindOfClass:[UIScrollView class]]) {
            v.zoomScale = 1;
        }
    }
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
