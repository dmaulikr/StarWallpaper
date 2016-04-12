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

@interface SWPhotoBrowser ()

@property (nonatomic, strong) UIButton *likeBtn;

@end

@implementation SWPhotoBrowser

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIButton *homeBtn = [[UIButton alloc] initWithFrame:CGRectMake((self.view.frame.size.width-50)*0.5, self.view.frame.size.height - 50, 50, 50)];
    homeBtn.alpha = 0.6;
    [homeBtn setImage:[UIImage imageNamed:@"backDown"] forState:UIControlStateNormal];
    [homeBtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:homeBtn];
    
    _likeBtn = [[UIButton alloc] initWithFrame:CGRectMake(10, self.view.frame.size.height - 50, 50, 50)];
    [_likeBtn setImage:[UIImage imageNamed:@"like"] forState:UIControlStateNormal];
    _likeBtn.alpha = 0.6;
    [_likeBtn addTarget:self action:@selector(like) forControlEvents:UIControlEventTouchUpInside];
    [self updateLikeBtn];
    [self.view addSubview:_likeBtn];
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
                _likeBtn.alpha = 0.6;
            }];
        }];
    }
    else {
        [[SWDatabaseManager sharedFMDBSqlite] deleteImageUrlString:item.bigImageUrl];
        [UIView animateWithDuration:0.4 animations:^{
            _likeBtn.alpha = 0.2;
        } completion:^(BOOL finished) {
            [_likeBtn setImage:[UIImage imageNamed:@"unLike"] forState:UIControlStateNormal];
            [UIView animateWithDuration:0.4 animations:^{
                _likeBtn.alpha = 0.6;
            }];
        }];
    }
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
