//
//  SWSearchSuggestTableViewCell.m
//  StarWallpaper
//
//  Created by Fnoz on 16/4/12.
//  Copyright © 2016年 Fnoz. All rights reserved.
//

#import "SWSearchSuggestTableViewCell.h"
#import "SWSearchSuggestDO.h"
#import "SWSearchSuggestCollectionViewCell.h"
#import "SWSearchSuggestSubDO.h"

static NSString *const kSWSearchSuggestCollectionViewCell = @"SWSearchSuggestCollectionViewCell";

@interface SWSearchSuggestTableViewCell ()<UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) SWSearchSuggestDO *item;

@end

@implementation SWSearchSuggestTableViewCell

- (void)setData:(id)data {
    _item = data;
    
    UICollectionViewFlowLayout *flowLayout=[[UICollectionViewFlowLayout alloc] init];
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kSWSearchSuggestTableViewCellSize) collectionViewLayout:flowLayout];
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    self.collectionView.showsHorizontalScrollIndicator = NO;
    _collectionView.backgroundColor = kSWBackGroundGray;
    self.collectionView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
    [_collectionView registerClass:[SWSearchSuggestCollectionViewCell class] forCellWithReuseIdentifier:kSWSearchSuggestCollectionViewCell];
    [self.contentView addSubview:self.collectionView];
}

#pragma mark UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _item.keywordItems.count;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    SWSearchSuggestCollectionViewCell *cell = (SWSearchSuggestCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:kSWSearchSuggestCollectionViewCell forIndexPath:indexPath];
    [cell setData:[_item.keywordItems objectAtIndex:indexPath.row]];
    return cell;
}

#pragma mark UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    SWSearchSuggestSubDO *subItem = [_item.keywordItems objectAtIndex:indexPath.row];
    [_delegate clickWithKeyword:subItem.keyword];
}

-(BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

#pragma mark UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(kSWSearchSuggestTableViewCellSize, kSWSearchSuggestTableViewCellSize);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 5;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 0;
}

@end
