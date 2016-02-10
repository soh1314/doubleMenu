//
//  collectionStyleCell.m
//  二级菜单
//
//  Created by 刘仰清 on 16/2/10.
//  Copyright © 2016年 刘仰清. All rights reserved.
//

#import "collectionStyleCell.h"

@implementation collectionStyleCell

- (void)awakeFromNib {
    // Initialization code
}
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self initView];
    }
    return self;
}
- (void)initView
{
    UICollectionViewFlowLayout * flowLayout = [[UICollectionViewFlowLayout alloc]init];
    _titleCol = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:flowLayout];
    [self addSubview:_titleCol];
    _titleCol.delegate = self;
    _titleCol.dataSource = self;
    [_titleCol registerNib:[UINib nibWithNibName:@"FourCellCol" bundle:nil] forCellWithReuseIdentifier:@"FourCellColId"];
}
- (void)setMenuTitleArray:(NSMutableArray *)menuTitleArray
{
    _menuTitleArray = menuTitleArray;
    _titleCol.frame = CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height);
    _titleCol.backgroundColor = [UIColor whiteColor];
    [self.titleCol reloadData];
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.menuTitleArray.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    FourCellCol * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"FourCellColId" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor redColor];
    cell.menuTitle.text = self.menuTitleArray[indexPath.row];
    return cell;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(self.bounds.size.width/4.0, 80);
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(2, 0, 2, 0);
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 0;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 0;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
