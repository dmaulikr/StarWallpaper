//
//  SWHomeViewController.m
//  StarWallpaper
//
//  Created by Fnoz on 16/4/1.
//  Copyright © 2016年 Fnoz. All rights reserved.
//

#import "SWHomeViewController.h"
#import "ASCollectionView.h"
#import "SWHomeCollectionViewLayout.h"
#import "SWHomeImageCellNode.h"
#import "SWConstDef.h"
#import "RZSquaresLoading.h"
#import "AFHTTPSessionManager.h"
#import "SWImageListDO.h"
#import "NSObject+YYModel.h"
#import "EXTScope.h"
#import "SWImageItemDO.h"

@interface SWHomeViewController () <ASCollectionViewDataSource, SWHomeCollectionViewLayoutDelegate>

@property (nonatomic, strong) ASCollectionView *collectionView;
@property (nonatomic, strong) SWHomeCollectionViewLayoutInspector *layoutInspector;
@property (nonatomic, strong) UIButton *keywordBtn;
@property (nonatomic, copy) NSString *currentKeyword;
@property (nonatomic, strong) NSArray *itemArray;
@property (nonatomic, strong) RZSquaresLoading *loading;

@end

@implementation SWHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    SWHomeCollectionViewLayout *layout = [[SWHomeCollectionViewLayout alloc] init];
    layout.numberOfColumns = 3;
    layout.headerHeight = 0.0;
    
    _layoutInspector = [[SWHomeCollectionViewLayoutInspector alloc] init];
    
    _collectionView = [[ASCollectionView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-50) collectionViewLayout:layout];
    _collectionView.asyncDataSource = self;
    _collectionView.asyncDelegate = self;
    _collectionView.layoutInspector = _layoutInspector;
    _collectionView.backgroundColor = kSWBackGroundGray;
    [_collectionView registerSupplementaryNodeOfKind:UICollectionElementKindSectionHeader];
    [self.view addSubview:_collectionView];
    
    UIView *bottomBar = [[UIView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height-50, self.view.frame.size.width, 50)];
    bottomBar.backgroundColor = [UIColor blackColor];
    [self.view addSubview:bottomBar];
    
    UIButton *leftBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
    [leftBtn setImage:[UIImage imageNamed:@"homeLike"] forState:UIControlStateNormal];
    leftBtn.alpha = 0.6;
    [bottomBar addSubview:leftBtn];
    
    _keywordBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 160, 30)];
    [_keywordBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    _keywordBtn.center = CGPointMake(bottomBar.frame.size.width*0.5, bottomBar.frame.size.height*0.5);
    [bottomBar addSubview:_keywordBtn];
    
    UIButton *rightBtn = [[UIButton alloc] initWithFrame:CGRectMake(bottomBar.frame.size.width - 50, 0, 50, 50)];
    [rightBtn setImage:[UIImage imageNamed:@"homeSetting"] forState:UIControlStateNormal];
    rightBtn.alpha = 0.6;
    [bottomBar addSubview:rightBtn];
 
    [self getResultForKeyword:[[NSUserDefaults standardUserDefaults] objectForKey:kKeyword]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)getResultForKeyword:(NSString *)keyword {
    if ([keyword isEqualToString:_currentKeyword]) {
        return;
    }
    _currentKeyword = [[NSUserDefaults standardUserDefaults] objectForKey:kKeyword];
    _itemArray = nil;
    [_collectionView reloadData];
    [self showLoading:YES];
    [_keywordBtn setTitle:keyword forState:UIControlStateNormal];
    
    @weakify(self)
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET:@"http://api.lovebizhi.com/iphone_v3.php" parameters:@{@"a":@"search", @"kw":keyword, @"client_id":@"1002", @"model_id":@"100", @"screen_width":@kScreenWidth, @"screen_height":@kScreenHeight, @"bizhi_width":@1080, @"bizhi_height":@"1920"} progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        @strongify(self)
        SWImageListDO *imageList = [SWImageListDO yy_modelWithDictionary:responseObject];
        self.itemArray = imageList.itemArray;
        [self showLoading:NO];
        [self.collectionView reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        @strongify(self)
        [self showLoading:NO];
    }];
}

- (void)showLoading:(BOOL)isShow {
    if (isShow) {
        if (!_loading) {
            _loading = [[RZSquaresLoading alloc] initWithFrame:CGRectMake(0, 0, 44, 44)];
            _loading.center = CGPointMake(_collectionView.frame.size.width*0.5, _collectionView.frame.size.height*0.5);
        }
        _loading.color = [UIColor lightGrayColor];
        [_collectionView addSubview:_loading];
    }
    else {
        [_loading removeFromSuperview];
        _loading = nil;
    }
}

#pragma mark - Collection delegate
- (ASCellNodeBlock)collectionView:(ASCollectionView *)collectionView nodeBlockForItemAtIndexPath:(NSIndexPath *)indexPath
{
    SWImageItemDO *imageItem = _itemArray.count>indexPath.row?[_itemArray objectAtIndex:indexPath.row]:nil;
    return ^{
        return [[SWHomeImageCellNode alloc] initWithImageUrl:[NSURL URLWithString:imageItem.thumnailImageUrl]];
    };
}

- (ASCellNode *)collectionView:(ASCollectionView *)collectionView nodeForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    ASTextCellNode *textCellNode = [[ASTextCellNode alloc] init];
    return textCellNode;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _itemArray.count;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout originalItemSizeAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(100, 100);
}

@end
