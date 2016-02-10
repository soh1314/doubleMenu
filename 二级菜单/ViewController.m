//
//  ViewController.m
//  二级菜单
//
//  Created by 刘仰清 on 16/2/10.
//  Copyright © 2016年 刘仰清. All rights reserved.
//

#import "ViewController.h"
#import "LeftMenuCell.h"
#import "RightMemuTableCell.h"
#import "collectionStyleCell.h"
typedef NS_ENUM(NSInteger,MenuStyle)
{
    fourcellStyle = 0,
    onecellStyle,
};
@interface ViewController ()
@property (nonatomic,strong)LeftMenuCell * selectCell;
@property (nonatomic,strong)NSMutableArray * currentMenuArray;
@property (nonatomic,assign)NSInteger selectIndex;
@property (nonatomic,assign)MenuStyle rightTableStyle;
@property (nonatomic,strong)UIButton * styleSettingBtn;
@end

@implementation ViewController
- (id)init
{
    if (self = [super init]) {
        _selectIndex = 0;
        [self setDefaultTableStyle];
    }
    return self;
}
- (void)setDefaultTableStyle
{
    self.rightTableStyle = onecellStyle;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadfirstLvTitleArray];
    self.rightTableStyle = fourcellStyle;
    [self downloadSecondDataArray];
    [self.view addSubview:self.rightTable];
    [self.view addSubview:self.leftCollectionView];
    [self.leftCollectionView reloadData];
    
    _styleSettingBtn = [[UIButton alloc]initWithFrame:CGRectMake(150, 300, 80, 80)];
    [self.view addSubview:_styleSettingBtn];
    _styleSettingBtn.backgroundColor = [UIColor greenColor];
    [_styleSettingBtn addTarget:self action:@selector(styleSetting:) forControlEvents:UIControlEventTouchUpInside];
}
- (void)styleSetting:(id)sender
{
    UIButton * btn = sender;
    btn.selected ^= 1;
    if (btn.selected) {
         self.rightTableStyle = onecellStyle;
    }
    else
    {
        self.rightTableStyle = fourcellStyle;
    }
    
    [self.rightTable reloadData];
   
}
- (void)loadfirstLvTitleArray
{
    NSArray * titleArray = @[@"水果蔬菜",@"办公用品",@"家用电器",@"出门旅行",@"理财咨询",@"热门音乐",@"我的收藏"];
    _FirstLvTitleArray = [NSMutableArray array];
    [self.FirstLvTitleArray addObjectsFromArray:titleArray];
}
- (void)downloadSecondDataArray
{
    
    _SecondLvDataArray = [NSMutableArray array];
    for (int i = 0; i < self.FirstLvTitleArray.count; i++) {
        NSMutableArray * strArray = [NSMutableArray array];
        for (int j = 0; j < 6 ; j++) {
            NSString * str = [NSString stringWithFormat:@"%d%d",i,j];
            [strArray addObject:str];
        }
        [self.SecondLvDataArray addObject:strArray];
    }
}
- (UITableView *)rightTable
{
    if (!_rightTable) {
        _rightTable = [[UITableView alloc]initWithFrame:CGRectMake(self.view.frame.size.width/5.0, 20, self.view.frame.size.width/5.0*4, self.view.frame.size.height) style:UITableViewStylePlain];
        _rightTable.backgroundColor = [UIColor whiteColor];
        _rightTable.delegate = self;
        _rightTable.dataSource = self;
        [_rightTable registerClass:[UITableViewCell class] forCellReuseIdentifier:@"rightTableId"];
        [_rightTable registerClass:[collectionStyleCell class] forCellReuseIdentifier:@"collStyleCellId"];
    }
    return _rightTable;
}
- (UICollectionView *)leftCollectionView
{
    if (!_leftCollectionView) {
        UICollectionViewFlowLayout * flowLayout = [[UICollectionViewFlowLayout alloc]init];
        _leftCollectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0,20, self.view.frame.size.width/5.0, self.view.frame.size.height) collectionViewLayout:flowLayout];
        _leftCollectionView.delegate = self;
        _leftCollectionView.dataSource = self;
        _leftCollectionView.bounces = NO;
        _leftCollectionView.showsHorizontalScrollIndicator = NO;
        _leftCollectionView.showsVerticalScrollIndicator = NO;
        [_leftCollectionView registerNib:[UINib nibWithNibName:@"LeftMenuCell" bundle:nil] forCellWithReuseIdentifier:@"leftMenuCellId"];
    }
    return _leftCollectionView;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    LeftMenuCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"leftMenuCellId" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor whiteColor];
    if (indexPath.item == 0) {
        cell.backgroundColor = [UIColor redColor];
        self.selectCell = cell;
    }
    cell.MenuTitle.text = self.FirstLvTitleArray[indexPath.item];
    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [self cancelSelectStateAndSelectItemAtIndexPath:indexPath];
    [self reloadMenu];
}
- (void)cancelSelectStateAndSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    self.selectCell.backgroundColor = [UIColor whiteColor];
    LeftMenuCell * cell = (LeftMenuCell *)[self.leftCollectionView cellForItemAtIndexPath:indexPath];
    self.selectCell = cell;
    self.selectIndex = indexPath.row;
    cell.backgroundColor = [UIColor redColor];
}
- (void)reloadMenu
{
    [self.rightTable reloadData];
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.FirstLvTitleArray.count?self.FirstLvTitleArray.count:0;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(self.view.frame.size.width/5.0, 100);
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0, 0, 0, 0);
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 0;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.rightTableStyle == onecellStyle) {
         return [self.SecondLvDataArray[self.selectIndex] count];
    }
    else
    {
        return 1;
    }
   
    
}
- (UITableViewCell * )tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.rightTableStyle == onecellStyle) {
        UITableViewCell * cell =  [tableView dequeueReusableCellWithIdentifier:@"rightTableId" forIndexPath:indexPath];
        cell.textLabel.text = self.SecondLvDataArray[self.selectIndex][indexPath.row];
        return cell;
    }
    else
    {
        collectionStyleCell * cell = [tableView dequeueReusableCellWithIdentifier:@"collStyleCellId" forIndexPath:indexPath];
        cell.backgroundColor = [UIColor whiteColor];
        cell.menuTitleArray = self.SecondLvDataArray[self.selectIndex];
        return cell;
    }

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.rightTableStyle == fourcellStyle) {
        return 160;
    }
    else
    {
        return 50;
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
