//
//  SWPhotoBrowser.m
//  StarWallpaper
//
//  Created by Fnoz on 16/4/11.
//  Copyright © 2016年 Fnoz. All rights reserved.
//

#import "SWPhotoBrowser.h"

@interface SWPhotoBrowser ()

@end

@implementation SWPhotoBrowser

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIButton *homeBtn = [[UIButton alloc] initWithFrame:CGRectMake((self.view.frame.size.width-50)*0.5, self.view.frame.size.height - 50, 50, 50)];
    homeBtn.alpha = 0.6;
    [homeBtn setImage:[UIImage imageNamed:@"backDown"] forState:UIControlStateNormal];
    [homeBtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:homeBtn];
    
    UIButton *likeBtn = [[UIButton alloc] initWithFrame:CGRectMake(10, self.view.frame.size.height - 50, 50, 50)];
    [likeBtn setImage:[UIImage imageNamed:@"like"] forState:UIControlStateNormal];
    likeBtn.alpha = 0.6;
    [likeBtn addTarget:self action:@selector(like) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:likeBtn];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)like {
}

- (void)back {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
