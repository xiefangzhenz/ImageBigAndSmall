//
//  CNImageCollectionView.m
//  CNImageCollectionView
//
//  Created by wang xinkai on 15/7/27.
//  Copyright (c) 2015年 wxk. All rights reserved.
//

#import "CNImageCollectionView.h"
#import "CNImageCollectionVC.h"

#define kImageViewOff 10

@implementation CNImageCollectionView


-(id)initWithFrame:(CGRect)frame{

    if (self = [super initWithFrame:frame]) {
        
        itemArray = [[NSMutableArray alloc] init];
        _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, 100)];

        
    }
    
    return self;
}

// step.2
-(void)setDataList:(NSArray *)dataList{

    if (_dataList == dataList) {
        return;
    }
    
    _dataList = dataList;

    [self createUIKit];
    
    
    [self setFrame:CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width,[CNImageCollectionView heightWithWidth:self.frame.size.width dataCount:(int)_dataList.count])];

    
}

+(CGFloat)heightWithWidth:(CGFloat) width dataCount:(int)count{

    //    step.5 高度自适应
    
     CGFloat widths = (width - 4*kImageViewOff)/3.0f;
    CGFloat height = widths;
    
    //    计算行数
    unsigned long rowNumber  = count/3 + ((count%3==0)?0:1);
    
    //    计算出高
    CGFloat height_s = (rowNumber+1)*kImageViewOff + rowNumber*height;
    
    
    return height_s;

}

-(void)createUIKit{
    
    
//    为了重用
    for (UIView *imageV in self.subviews) {
        [imageV removeFromSuperview];
    }
    [itemArray removeAllObjects];

    
//    step.3
    
    
    for (int i = 0; i < _dataList.count; i++) {
        
        CNImageCollectionItem *imageV = [[CNImageCollectionItem alloc] initWithFrame:[self frameAtIndex:i]];
        
        imageV.index = i;
        
//        [imageV setImageWithURL:[NSURL URLWithString:_dataList[i]]];
        imageV.image = _dataList[i];
        
        [_scrollView addSubview:imageV];
        
        [self addSubview:_scrollView];
        
        
        [imageV setBlock:^(int index){
        
            
            NSLog(@"%d",index);
        
            
            CNImageCollectionVC *vc = [[CNImageCollectionVC alloc] init];
            
            vc.collectionView = self;
            
            vc.currentIndex = index;
            
            vc.dataList = self.dataList;
            
            
//            [self.viewController presentViewController:vc animated:NO completion:nil];
            
            [[self viewController] presentViewController:vc animated:NO completion:^{
                
            }];
            
            
            [self bringCellToFront];

            
            
        }];
        
        
        [itemArray addObject:imageV];
        
    }
    _scrollView.contentSize = CGSizeMake(((self.frame.size.width - 4*kImageViewOff)/5.0f+kImageViewOff)*_dataList.count, 0);
    
}
- (UIViewController *)viewController {
    for (UIView* next = [self superview]; next; next = next.superview) {
        UIResponder *nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)nextResponder;
        }
    }
    return nil;
}


-(void)bringCellToFront{

    
    UIResponder *next = self.nextResponder;
    
    while (next) {

        NSLog(@"%@",next);
        
        if ([next isKindOfClass:[UITableViewCell class]]) {
            
            [[(UITableViewCell*)next superview] bringSubviewToFront:next];
            
        }
        
        next = next.nextResponder;
        
    }
    
    
}
/*九宫格样式
//    step.4

-(CGRect) frameAtIndex:(int)index{

//计算宽高
    CGFloat width = (self.frame.size.width - 4*kImageViewOff)/3.0f;
    CGFloat height = width;

//    计算index对应所在的行和列
    int index_x = index%3;
    int index_y = index/3;
    
    
//   计算出x和y
    CGFloat x = index_x*width+(index_x+1)*kImageViewOff;
    CGFloat y = index_y*height+(index_y+1)*kImageViewOff;

    
    return CGRectMake(x, y, width, height);

    
    
    
}
*/

//    step.4  scrolleView样式

-(CGRect) frameAtIndex:(int)index{
    
    //计算宽高
    CGFloat width = (self.frame.size.width - 4*kImageViewOff)/5.0f;
    CGFloat height = width;
    
    
    return CGRectMake(index*(width+kImageViewOff), 0, width, height);
    
    
    
}

-(CNImageCollectionItem *)itemAtIndex:(int)index{

    if (index>=0 && index < itemArray.count) {
    
        return [itemArray objectAtIndex:index];
    }
    
    return nil;
    
}


@end






@implementation CNImageCollectionItem




-(id)initWithFrame:(CGRect)frame{

    if (self = [super initWithFrame:frame]) {
        
        self.userInteractionEnabled = YES;
        
        self.contentMode = UIViewContentModeScaleAspectFit;
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAct:)];
        
        tap.numberOfTapsRequired = 1;
        
        [self addGestureRecognizer:tap];
        
        
    }
    
    return self;
}


-(void)tapAct:(UITapGestureRecognizer *)tap{

    
    if (_block) {
        _block(_index);
    }



}




@end


