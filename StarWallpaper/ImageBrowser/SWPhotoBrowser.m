//
//  SWPhotoBrowser.m
//  StarWallpaper
//
//  Created by Fnoz on 16/4/11.
//  Copyright © 2016年 Fnoz. All rights reserved.
//

#import "SWPhotoBrowser.h"
#import "SWDatabaseManager.h"
#import "SWImageItemDO.h"
#import "SDImageCache.h"
#import "SWCommonUtil.h"
#import "SWPhotoPresentAnimator.h"
#import "SWPhotoDismissAnimator.h"

@interface SWPhotoBrowser ()

@property (nonatomic, strong) UIButton *likeBtn;
@property (nonatomic, strong) UIButton *saveBtn;
@property (nonatomic, strong) UIButton *homeBtn;

@end

@implementation SWPhotoBrowser

- (instancetype)init {
    self = [super init];
    if (self) {
        self.transitioningDelegate = self;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _homeBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    _homeBtn.frame = CGRectMake((self.view.frame.size.width - 50) * 0.5, self.view.frame.size.height, 50, 50);
    _homeBtn.tintColor = kSWIconWhite;
    _homeBtn.imageEdgeInsets = UIEdgeInsetsMake(13, 13, 13, 13);
    [_homeBtn setImage:[UIImage imageNamed:@"backDown"] forState:UIControlStateNormal];
    [_homeBtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_homeBtn];
    
    _likeBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    _likeBtn.frame = CGRectMake(10, self.view.frame.size.height, 50, 50);
    _likeBtn.tintColor = kSWIconWhite;
    _likeBtn.imageEdgeInsets = UIEdgeInsetsMake(13, 13, 13, 13);
    [_likeBtn setImage:[UIImage imageNamed:@"like"] forState:UIControlStateNormal];
    [_likeBtn addTarget:self action:@selector(like) forControlEvents:UIControlEventTouchUpInside];
    [self updateLikeBtn];
    [self.view addSubview:_likeBtn];
    
    _saveBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    _saveBtn.frame = CGRectMake(self.view.frame.size.width - 10 - 50, self.view.frame.size.height, 50, 50);
    _saveBtn.tintColor = kSWIconWhite;
    _saveBtn.imageEdgeInsets = UIEdgeInsetsMake(13, 13, 13, 13);
    [_saveBtn setImage:[UIImage imageNamed:@"save"] forState:UIControlStateNormal];
    [_saveBtn addTarget:self action:@selector(save) forControlEvents:UIControlEventTouchUpInside];
    [self updateLikeBtn];
    [self.view addSubview:_saveBtn];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [UIView animateWithDuration:0.7 animations:^{
            _homeBtn.frame = CGRectMake((self.view.frame.size.width - 50) * 0.5, self.view.frame.size.height - 50, 50, 50);
            _likeBtn.frame = CGRectMake(10, self.view.frame.size.height - 50, 50, 50);
            _saveBtn.frame = CGRectMake(self.view.frame.size.width - 10 - 50, self.view.frame.size.height - 50, 50, 50);
        }];
    });
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] init];
    [tap addTarget:self action:@selector(tap:)];
    tap.numberOfTapsRequired = 1;
    [self.view addGestureRecognizer:tap];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)like {
    SWImageItemDO *item = [_itemArray objectAtIndex:self.currentIndex];
    if (![[SWDatabaseManager sharedFMDBSqlite]imageUrlStringHasInDB:item.bigImageUrl]) {
        [[SWDatabaseManager sharedFMDBSqlite] insertImageUrlString:item.bigImageUrl];
        [UIView animateWithDuration:0.4 animations:^{
            _likeBtn.alpha = 0.2;
        } completion:^(BOOL finished) {
            [_likeBtn setImage:[UIImage imageNamed:@"like"] forState:UIControlStateNormal];
            [UIView animateWithDuration:0.4 animations:^{
                _likeBtn.alpha = 1;
            }];
        }];
    }
    else {
        [[SWDatabaseManager sharedFMDBSqlite] deleteImageUrlString:item.bigImageUrl];
        [UIView animateWithDuration:0.4 animations:^{
            _likeBtn.alpha = 0.2;
        } completion:^(BOOL  finished) {
            [_likeBtn setImage:[UIImage imageNamed:@"unLike"] forState:UIControlStateNormal];
            [UIView animateWithDuration:0.4 animations:^{
                _likeBtn.alpha = 1;
            }];
        }];
    }
}

- (void)save {
    SWImageItemDO *item = [_itemArray objectAtIndex:self.currentIndex];
    NSString *imageUrl = item.bigImageUrl;
    UIImage *image = [[SDImageCache sharedImageCache] imageFromMemoryCacheForKey:imageUrl];
    [SWCommonUtil saveImageToAlbum:image];
}

- (void)tap:(UITapGestureRecognizer *)tap
{
    if (UIGestureRecognizerStateEnded == tap.state) {
        [self back];
    }
}

- (void)back {
    [UIView animateWithDuration:0.3 animations:^{
        _homeBtn.frame = CGRectMake((self.view.frame.size.width - 50) * 0.5, self.view.frame.size.height, 50, 50);
        _likeBtn.frame = CGRectMake(10, self.view.frame.size.height, 50, 50);
        _saveBtn.frame = CGRectMake(self.view.frame.size.width - 10 - 50, self.view.frame.size.height, 50, 50);
    }];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)setCurrentPhotoIndex:(NSUInteger)index {
    [super setCurrentPhotoIndex:index];
    [self updateLikeBtn];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [super scrollViewDidScroll:scrollView];
    [self updateLikeBtn];
}

- (void)updateLikeBtn {
    SWImageItemDO *item = [_itemArray objectAtIndex:self.currentIndex];
    if ([[SWDatabaseManager sharedFMDBSqlite] imageUrlStringHasInDB:item.bigImageUrl]) {
        [_likeBtn setImage:[UIImage imageNamed:@"like"] forState:UIControlStateNormal];
    }
    else
    {
        [_likeBtn setImage:[UIImage imageNamed:@"unLike"] forState:UIControlStateNormal];
    }
}

- (id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source
{
    SWPhotoPresentAnimator *presentAnimator = [[SWPhotoPresentAnimator alloc] init];
    presentAnimator.oriCenter = self.oriCenter;
    return presentAnimator;
}

- (id <UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed;
{
    CGFloat horizonOffset = ((NSInteger)(self.currentIndex % 3) - (self.oriIndex % 3)) * ((kScreenWidth - 8) / 3 + 4);
    CGFloat verticalOffset = (self.currentIndex / 3 - self.oriIndex / 3) * ((kScreenWidth-8)/3 * kScreenHeight / kScreenWidth + 4);

    SWPhotoDismissAnimator *dismissAnimator = [[SWPhotoDismissAnimator alloc] init];
    dismissAnimator.oriCenter = CGPointMake(self.oriCenter.x + horizonOffset, self.oriCenter.y + verticalOffset);
    return dismissAnimator;
}

@end
