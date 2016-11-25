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

@interface SWPhotoBrowser ()

@property (nonatomic, strong) UIButton *likeBtn;
@property (nonatomic, strong) UIButton *saveBtn;

@end

@implementation SWPhotoBrowser

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIButton *homeBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    homeBtn.frame = CGRectMake((self.view.frame.size.width - 50) * 0.5, self.view.frame.size.height - 50, 50, 50);
    homeBtn.tintColor = kSWIconWhite;
    homeBtn.imageEdgeInsets = UIEdgeInsetsMake(13, 13, 13, 13);
    [homeBtn setImage:[UIImage imageNamed:@"backDown"] forState:UIControlStateNormal];
    [homeBtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:homeBtn];
    
    _likeBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    _likeBtn.frame = CGRectMake(10, self.view.frame.size.height - 50, 50, 50);
    _likeBtn.tintColor = kSWIconWhite;
    _likeBtn.imageEdgeInsets = UIEdgeInsetsMake(13, 13, 13, 13);
    [_likeBtn setImage:[UIImage imageNamed:@"like"] forState:UIControlStateNormal];
    [_likeBtn addTarget:self action:@selector(like) forControlEvents:UIControlEventTouchUpInside];
    [self updateLikeBtn];
    [self.view addSubview:_likeBtn];
    
    _saveBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    _saveBtn.frame = CGRectMake(self.view.frame.size.width - 10 - 50, self.view.frame.size.height - 50, 50, 50);
    _saveBtn.tintColor = kSWIconWhite;
    _saveBtn.imageEdgeInsets = UIEdgeInsetsMake(13, 13, 13, 13);
    [_saveBtn setImage:[UIImage imageNamed:@"save"] forState:UIControlStateNormal];
    [_saveBtn addTarget:self action:@selector(save) forControlEvents:UIControlEventTouchUpInside];
    [self updateLikeBtn];
    [self.view addSubview:_saveBtn];
    
    UISwipeGestureRecognizer *swipeGesture = [[UISwipeGestureRecognizer alloc] init];
    swipeGesture.direction = UISwipeGestureRecognizerDirectionDown;
    [swipeGesture addTarget:self action:@selector(swipe:)];
    [self.view addGestureRecognizer:swipeGesture];
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

- (void)swipe:(UISwipeGestureRecognizer *)swipe
{
    [self back];
}

- (void)back {
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

@end
