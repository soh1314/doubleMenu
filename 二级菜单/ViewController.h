//
//  ViewController.h
//  二级菜单
//
//  Created by 刘仰清 on 16/2/10.
//  Copyright © 2016年 刘仰清. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>

@property (nonatomic,strong)NSMutableArray * FirstLvTitleArray;

@property (nonatomic,strong)NSMutableArray * SecondLvDataArray;

@property (nonatomic,strong)UICollectionView * leftCollectionView;

@property (nonatomic,strong)UITableView * rightTable;



@end

