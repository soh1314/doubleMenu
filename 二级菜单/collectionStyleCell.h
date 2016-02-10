//
//  collectionStyleCell.h
//  二级菜单
//
//  Created by 刘仰清 on 16/2/10.
//  Copyright © 2016年 刘仰清. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FourCellCol.h"
@interface collectionStyleCell : UITableViewCell<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>
@property (nonatomic,strong)UICollectionView * titleCol;
@property (nonatomic,strong)NSMutableArray * menuTitleArray;
@end
