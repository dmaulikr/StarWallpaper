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
    _containerView.layer.cornerRadius = 50;
    [self addSubview:_containerView];
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
