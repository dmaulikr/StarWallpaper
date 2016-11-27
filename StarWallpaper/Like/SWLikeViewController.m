//
//  SWLikeViewController.m
//  StarWallpaper
//
//  Created by Fnoz on 16/4/14.
//  Copyright © 2016年 Fnoz. All rights reserved.
//

#import "SWLikeViewController.h"
#import "SWHomeImageCellCollectionViewCell.h"
#import "SWPhotoBrowser.h"
#import "SWImageItemDO.h"
#import "RZSquaresLoading.h"
#import "SWDatabaseManager.h"

@interface SWLikeViewController () <UICollectionViewDelegate, UICollectionViewDataSource, MWPhotoBrowserDelegate>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSArray *itemArray;
@property (nonatomic, strong) RZSquaresLoading *loading;
@property (nonatomic, strong) UIButton *backToTopBtn;
@property (nonatomic, strong) UIButton *emptyBtn;

@end

@implementation SWLikeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = kSWBackGroundGray;
    
    UICollectionViewFlowLayout *flowLayout=[[UICollectionViewFlowLayout alloc] init];
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) collectionViewLayout:flowLayout];
    [self.collectionView setBackgroundColor:kSWBackGroundGray];
    self.collectionView.dataSource=self;
    self.collectionView.delegate=self;
    self.collectionView.alwaysBounceVertical = YES;
    self.collectionView.showsVerticalScrollIndicator = NO;
    self.collectionView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
    [self.collectionView registerClass:[SWHomeImageCellCollectionViewCell class] forCellWithReuseIdentifier:kSWHomeImageCellCollectionViewCell];
    [self.view addSubview:self.collectionView];
    
    _backToTopBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    _backToTopBtn.frame = CGRectMake(self.view.frame.size.width - 50, _collectionView.frame.size.height - 80, 50, 50);
    _backToTopBtn.tintColor = kSWIconWhite;
    _backToTopBtn.imageEdgeInsets = UIEdgeInsetsMake(15, 15, 15, 15);
    [_backToTopBtn setImage:[UIImage imageNamed:@"backUp"] forState:UIControlStateNormal];
    [_backToTopBtn addTarget:self action:@selector(backToTop) forControlEvents:UIControlEventTouchUpInside];
    _backToTopBtn.hidden = YES;
    [self.view addSubview:_backToTopBtn];
    
    UIButton *homeBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    homeBtn.frame = CGRectMake((self.view.frame.size.width - 50) * 0.5, self.view.frame.size.height - 50, 50, 50);
    homeBtn.tintColor = kSWIconWhite;
    homeBtn.imageEdgeInsets = UIEdgeInsetsMake(13, 13, 13, 13);
    [homeBtn setImage:[UIImage imageNamed:@"backDown"] forState:UIControlStateNormal];
    [homeBtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:homeBtn];
    
    [self fetchLikeList];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)backToTop {
    [_collectionView setContentOffset:CGPointZero animated:YES];
}

- (void)back {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)fetchLikeList {
    [self showLoading:YES];
    _itemArray = [[SWDatabaseManager sharedFMDBSqlite] getLikeList];
    [_collectionView reloadData];
    [self showLoading:NO];
    if(!(_itemArray.count>0)) {
        [self showEmpty];
        [_backToTopBtn removeFromSuperview];
    }
}

- (void)showEmpty {
    _emptyBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 30)];
    [_emptyBtn setTitle:@"你还没有收藏呢" forState:UIControlStateNormal];
    _emptyBtn.titleLabel.font = SWFontOfSize(20);
    [_emptyBtn setTitleColor:kSWFontGreen forState:UIControlStateNormal];
    _emptyBtn.center = self.view.center;
    [self.view addSubview:_emptyBtn];
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

#pragma mark UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    _backToTopBtn.hidden = !(scrollView.contentOffset.y > scrollView.frame.size.height);
    _backToTopBtn.alpha = (scrollView.contentOffset.y - scrollView.frame.size.height) / 20.0;
}

#pragma mark UICollectionViewDataSource
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _itemArray.count;
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    SWHomeImageCellCollectionViewCell *cell = (SWHomeImageCellCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:kSWHomeImageCellCollectionViewCell forIndexPath:indexPath];
    SWImageItemDO *item = _itemArray.count>indexPath.row?[_itemArray objectAtIndex:indexPath.row]:nil;
    [cell setImageUrl:item.smallImageUrl];
    return cell;
}

#pragma mark UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake((kScreenWidth-8)/3, (kScreenWidth-8)/3 * kScreenHeight / kScreenWidth + 4);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 0;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 0;
}

#pragma mark UICollectionViewDelegate
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    SWPhotoBrowser *browser = [[SWPhotoBrowser alloc] initWithDelegate:self];
    
    SWHomeImageCellCollectionViewCell *cell = (SWHomeImageCellCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    CGRect oriFrame = [cell convertRect:cell.bounds toView:cell.window];
    browser.oriCenter = CGPointMake(oriFrame.origin.x + oriFrame.size.width * 0.5, oriFrame.origin.y + oriFrame.size.height * 0.5 - 2);
    
    browser.itemArray = _itemArray;
    browser.zoomPhotosToFill = YES;
    browser.customImageSelectedIconName = @"ImageSelected.png";
    browser.customImageSelectedSmallIconName = @"ImageSelectedSmall.png";
    [browser setCurrentPhotoIndex:indexPath.row];
    [self presentViewController:browser animated:YES completion:nil];
}

-(BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

#pragma mark MWPhotoBrowserDelegate
- (NSUInteger)numberOfPhotosInPhotoBrowser:(MWPhotoBrowser *)photoBrowser {
    return _itemArray.count;
}

- (id <MWPhoto>)photoBrowser:(MWPhotoBrowser *)photoBrowser photoAtIndex:(NSUInteger)index {
    if (index < _itemArray.count) {
        SWImageItemDO *item = [_itemArray objectAtIndex:index];
        return [MWPhoto photoWithURL:[NSURL URLWithString:item.bigImageUrl]];
    }
    return nil;
}

@end
