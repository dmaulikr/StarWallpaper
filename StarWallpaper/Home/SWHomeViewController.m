//
//  SWHomeViewController.m
//  StarWallpaper
//
//  Created by Fnoz on 16/4/1.
//  Copyright © 2016年 Fnoz. All rights reserved.
//

#import "SWHomeViewController.h"
#import "SWConstDef.h"
#import "RZSquaresLoading.h"
#import "AFHTTPSessionManager.h"
#import "SWImageListDO.h"
#import "NSObject+YYModel.h"
#import "EXTScope.h"
#import "SWImageItemDO.h"
#import "SWSearchViewController.h"
#import "SWCommonUtil.h"
#import "SWHomeImageCellCollectionViewCell.h"
#import "SWPhotoBrowser.h"
#import "SWLikeViewController.h"
#import "SWSettingViewController.h"

@interface SWHomeViewController () <UICollectionViewDelegate, UICollectionViewDataSource, MWPhotoBrowserDelegate>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) UIButton *keywordBtn;
@property (nonatomic, copy) NSString *currentKeyword;
@property (nonatomic, strong) NSArray *itemArray;
@property (nonatomic, strong) RZSquaresLoading *loading;
@property (nonatomic, strong) UIButton *retryBtn;
@property (nonatomic, strong) UIView *launchView;
@property (nonatomic, strong) UIButton *backToTopBtn;
@property (nonatomic, strong) UIButton *emptyBtn;

@end

@implementation SWHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UICollectionViewFlowLayout *flowLayout=[[UICollectionViewFlowLayout alloc] init];
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-50) collectionViewLayout:flowLayout];
    [self.collectionView setBackgroundColor:kSWBackGroundGray];
    self.collectionView.dataSource=self;
    self.collectionView.delegate=self;
    self.collectionView.alwaysBounceVertical = YES;
    self.collectionView.showsVerticalScrollIndicator = NO;
    self.collectionView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
    [self.collectionView registerClass:[SWHomeImageCellCollectionViewCell class] forCellWithReuseIdentifier:kSWHomeImageCellCollectionViewCell];
    [self.view addSubview:self.collectionView];
    
    _backToTopBtn = [[UIButton alloc] initWithFrame:CGRectMake(self.view.frame.size.width-50, _collectionView.frame.size.height-80, 50, 50)];
    [_backToTopBtn setImage:[UIImage imageNamed:@"backUp"] forState:UIControlStateNormal];
    [_backToTopBtn addTarget:self action:@selector(backToTop) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_backToTopBtn];
    
    UIView *bottomBar = [[UIView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height-50, self.view.frame.size.width, 50)];
    bottomBar.backgroundColor = [UIColor blackColor];
    [self.view addSubview:bottomBar];
    
    UIButton *leftBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
    [leftBtn setImage:[UIImage imageNamed:@"homeLike"] forState:UIControlStateNormal];
    leftBtn.alpha = 0.6;
    [leftBtn addTarget:self action:@selector(likeBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    [bottomBar addSubview:leftBtn];
    
    _keywordBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 160, 30)];
    [_keywordBtn setTitleColor:kSWFontGreen forState:UIControlStateNormal];
    _keywordBtn.center = CGPointMake(bottomBar.frame.size.width*0.5, bottomBar.frame.size.height*0.5);
    _keywordBtn.titleLabel.font = SWFontOfSize(22);
    [_keywordBtn addTarget:self action:@selector(keywordClicked) forControlEvents:UIControlEventTouchUpInside];
    [bottomBar addSubview:_keywordBtn];
    if (![[[NSUserDefaults standardUserDefaults] objectForKey:kHasDoneTwinkleWord] boolValue]) {
        [_keywordBtn.layer addAnimation:[self opacityForever_Animation:0.7] forKey:nil];
    }
    
    UIButton *rightBtn = [[UIButton alloc] initWithFrame:CGRectMake(bottomBar.frame.size.width - 50, 0, 50, 50)];
    [rightBtn setImage:[UIImage imageNamed:@"homeSetting"] forState:UIControlStateNormal];
    rightBtn.alpha = 0.6;
    [rightBtn addTarget:self action:@selector(settingClicked) forControlEvents:UIControlEventTouchUpInside];
    [bottomBar addSubview:rightBtn];
 
    [self getResultForKeyword:[[NSUserDefaults standardUserDefaults] objectForKey:kKeyword]];
    
    [self addLaunchView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)addLaunchView {
    _launchView = [[UIView alloc] initWithFrame:self.view.frame];
    _launchView.backgroundColor = kSWBackGroundGray;
    UIImageView *logoView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 120, 120)];
    logoView.image = [UIImage imageNamed:@"Launch"];
    logoView.center = CGPointMake(_launchView.frame.size.width * 0.5, _launchView.frame.size.height * 0.5);
    [_launchView addSubview:logoView];
    [self.view addSubview:_launchView];
    [UIView animateWithDuration:0.7 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        _launchView.layer.opacity = 0;
    } completion:^(BOOL finished) {
        [_launchView removeFromSuperview];
    }];
}

- (void)backToTop {
    [_collectionView setContentOffset:CGPointZero animated:YES];
}

- (void)getResultForKeyword:(NSString *)keyword {
    [_emptyBtn removeFromSuperview];
    if ([keyword isEqualToString:_currentKeyword] || 0 == [keyword stringByReplacingOccurrencesOfString:@" " withString:@""].length) {
        return;
    }
    _currentKeyword = keyword;
    [[NSUserDefaults standardUserDefaults] setObject:_currentKeyword forKey:kKeyword];
    _itemArray = nil;
    [_collectionView reloadData];
    [self showLoading:YES];
    [self showRetry:NO];
    [_keywordBtn setTitle:keyword forState:UIControlStateNormal];
    
    @weakify(self)
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSString *urlStr = [NSString stringWithFormat:@"http://starwallpaper.duapp.com?keyword=%@&imgWidth=%@&imgHeight=%@", [keyword stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding], @(kScreenWidth * [UIScreen mainScreen].scale), @(kScreenHeight * [UIScreen mainScreen].scale)];
    [manager GET:urlStr parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSString *responseString = [SWCommonUtil replaceUnicode:[[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding]];
        @strongify(self)
        SWImageListDO *imageList = [SWImageListDO yy_modelWithJSON:responseString];
        self.itemArray = imageList.itemArray;
        [self showLoading:NO];
        [self.collectionView reloadData];
        if (!imageList.itemArray.count) {
            [_backToTopBtn removeFromSuperview];
            [self showEmpty];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        @strongify(self)
        [self showLoading:NO];
        [self showRetry:YES];
    }];
    manager.responseSerializer=[AFHTTPResponseSerializer serializer];
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

- (void)showEmpty {
    _emptyBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 30)];
    [_emptyBtn setTitle:@"这个明星的壁纸稀有呢" forState:UIControlStateNormal];
    _emptyBtn.titleLabel.font = SWFontOfSize(20);
    [_emptyBtn setTitleColor:kSWFontGreen forState:UIControlStateNormal];
    _emptyBtn.center = self.view.center;
    [self.view addSubview:_emptyBtn];
}

- (void)showRetry:(BOOL)isShow {
    if (isShow) {
        if (!_retryBtn) {
            _retryBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 50, 30)];
            [_retryBtn setTitle:@"重试" forState:UIControlStateNormal];
            _retryBtn.titleLabel.font = SWFontOfSize(20);
            [_retryBtn setTitleColor:kSWFontGreen forState:UIControlStateNormal];
            _retryBtn.center = self.view.center;
            [_retryBtn addTarget:self action:@selector(retry) forControlEvents:UIControlEventTouchUpInside];
            [self.view addSubview:_retryBtn];
        }
    }
    else {
        [_retryBtn removeFromSuperview];
        _retryBtn = nil;
    }
}

- (void)retry {
    [self getResultForKeyword:[[NSUserDefaults standardUserDefaults] objectForKey:kKeyword]];
}

- (void)keywordClicked {
    [[NSUserDefaults standardUserDefaults] setValue:@(YES) forKey:kHasDoneTwinkleWord];
    [_keywordBtn.layer removeAllAnimations];
    @weakify(self)
    [SWSearchViewController presentWithKeyword:_currentKeyword selectedKeywordBlock:^(NSString *keyword) {
        @strongify(self)
        [self getResultForKeyword:keyword];
    }];
}

- (void)likeBtnClicked {
    SWLikeViewController *likeListVC = [[SWLikeViewController alloc] init];
    [self presentViewController:likeListVC animated:YES completion:nil];
}

- (void)settingClicked {
    SWSettingViewController *settingVc = [[SWSettingViewController alloc] init];
    [self presentViewController:settingVc animated:YES completion:nil];
}

-(CABasicAnimation *)opacityForever_Animation:(float)time
{
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"opacity"];
    animation.fromValue = [NSNumber numberWithFloat:1.0f];
    animation.toValue = [NSNumber numberWithFloat:0.0f];
    animation.autoreverses = YES;
    animation.duration = time;
    animation.repeatCount = MAXFLOAT;
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    animation.timingFunction=[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    return animation;
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
    SWImageItemDO *imageItem = _itemArray.count>indexPath.row?[_itemArray objectAtIndex:indexPath.row]:nil;
    [cell setImageUrl:imageItem.smallImageUrl];
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
