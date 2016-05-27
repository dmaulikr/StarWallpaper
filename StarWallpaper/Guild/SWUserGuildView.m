//
//  SWUserGuildView.m
//  StarWallpaper
//
//  Created by Fnoz on 16/5/25.
//  Copyright © 2016年 Fnoz. All rights reserved.
//

#import "SWUserGuildView.h"

@interface SWUserGuildView ()

@property (nonatomic, strong) UIScrollView *containerView;

@end

@implementation SWUserGuildView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:[UIScreen mainScreen].bounds];
    if (self) {
        [self initView];
    }
    return self;
}

- (void)initView {
    self.backgroundColor = [UIColor clearColor];
    _containerView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth - 100, kScreenHeight - 200)];
    _containerView.center = CGPointMake(kScreenWidth/2, kScreenHeight/2);
    _containerView.backgroundColor = [UIColor whiteColor];
    _containerView.layer.cornerRadius = 20;
    _containerView.contentSize = CGSizeMake(_containerView.frame.size.width * 3, _containerView.frame.size.height);
    _containerView.pagingEnabled = YES;
    [self addSubview:_containerView];
    
    for (int i = 0; i < 3; i++) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(_containerView.frame.size.width * i + 15, 15, _containerView.frame.size.width - 30, (_containerView.frame.size.width - 30) * 1.78)];
        imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"guild_%d", i]];
        [_containerView addSubview:imageView];
    }
}

- (void)show {
    UIWindow *window = [UIApplication sharedApplication].delegate.window;
    self.frame = [[UIScreen mainScreen] bounds];
    self.alpha = 0;
    [UIView animateWithDuration:0.7 animations:^{
        self.alpha = 1;
    }];
    [window addSubview:self];
}

- (void)remove {
    [self removeFromSuperview];
}

@end
