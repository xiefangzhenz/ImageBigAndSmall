//
//  CNImageCollectionView.h
//  CNImageCollectionView
//
//  Created by wang xinkai on 15/7/27.
//  Copyright (c) 2015年 wxk. All rights reserved.
//



#import <UIKit/UIKit.h>

@class CNImageCollectionItem;
@interface CNImageCollectionView : UIView
{
//    存放item
    NSMutableArray *itemArray;
    
    UIScrollView* _scrollView;
}


//数据  step.1
@property (nonatomic,copy) NSArray *dataList;

//通过index 获取到对应的item
-(CNImageCollectionItem *)itemAtIndex:(int)index;

//通过index 获取对应的frame
-(CGRect) frameAtIndex:(int)index;

-(id)initWithFrame:(CGRect)frame;


//根据宽度和数量获取高
+(CGFloat)heightWithWidth:(CGFloat) width dataCount:(int)count;

@end




typedef void(^CNItemBlock)(int index);

@interface CNImageCollectionItem : UIImageView


@property (assign) int index;

@property (nonatomic,copy) CNItemBlock block;

@end
