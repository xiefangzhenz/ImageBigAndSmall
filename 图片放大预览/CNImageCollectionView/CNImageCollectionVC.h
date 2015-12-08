//
//  CNImageCollectionVC.h
//  CNImageCollectionView
//
//  Created by wang xinkai on 15/7/27.
//  Copyright (c) 2015年 wxk. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CNImageCollectionView.h"
@interface CNImageCollectionVC : UIViewController<UIScrollViewDelegate>
{
//    控件
    UIScrollView *_scrollView;
}

@property (nonatomic,assign) CNImageCollectionView *collectionView;

//数据
@property (nonatomic,copy) NSArray *dataList;

//当前显示的位置
@property (assign) int currentIndex;



@end
