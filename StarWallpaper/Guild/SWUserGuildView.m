//
//  SWUserGuildView.m
//  StarWallpaper
//
//  Created by Fnoz on 16/5/25.
//  Copyright © 2016年 Fnoz. All rights reserved.
//

#import "SWUserGuildView.h"

@implementation SWUserGuildView

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:[UIScreen mainScreen].bounds];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
    }
    
    return self;
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
