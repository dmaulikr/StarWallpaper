//
//  SearchViewController.m
//  StarWallpaper
//
//  Created by Fnoz on 16/4/4.
//  Copyright © 2016年 Fnoz. All rights reserved.
//

#import "SearchViewController.h"
#import "SWConstDef.h"
#import "SWCommonUtil.h"

@implementation SearchViewController

+ (void)presentWithKeyword:(NSString *)keyword selectedKeywordBlock:(SWSelectedKeywordBlock)block {
    SearchViewController *vc = [[SearchViewController alloc] init];
    vc.keyword = keyword;
    [SWCurrentVC presentViewController:vc animated:YES completion:nil];
}

-(void)viewDidLoad {
    [super viewDidLoad];
    
    UIButton *homeBtn = [[UIButton alloc] initWithFrame:CGRectMake((self.view.frame.size.width-50)*0.5, self.view.frame.size.height - 50, 50, 50)];
    [homeBtn setImage:[UIImage imageNamed:@"like"] forState:UIControlStateNormal];
    [homeBtn addTarget:self action:@selector(backToHome) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:homeBtn];
    
    self.view.backgroundColor = kSWBackGroundGray;
}

- (void)backToHome {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
