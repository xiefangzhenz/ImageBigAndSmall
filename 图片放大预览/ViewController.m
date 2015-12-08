//
//  ViewController.m
//  图片放大预览
//
//  Created by 谢方振 on 15/11/3.
//  Copyright © 2015年 谢方振. All rights reserved.
//

#import "ViewController.h"
#import "CNImageCollectionView/CNImageCollectionView.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    CNImageCollectionView* view = [[CNImageCollectionView alloc]initWithFrame:self.view.bounds];
    UIImage* image = [UIImage imageNamed:@"white_logo"];
    view.dataList = @[image,image,image,image,image,image,image,image,image,image];
    [self.view addSubview:view];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
