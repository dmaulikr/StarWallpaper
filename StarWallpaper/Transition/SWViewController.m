//
//  SWViewController.m
//  StarWallpaper
//
//  Created by Fnoz on 2016/11/27.
//  Copyright © 2016年 Fnoz. All rights reserved.
//

#import "SWViewController.h"
#import "SWPhotoPresentAnimator.h"
#import "SWPhotoDismissAnimator.h"

@interface SWViewController ()

@end

@implementation SWViewController

- (instancetype)init {
    self = [super init];
    if (self) {
        self.transitioningDelegate = self;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//- (id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source
//{
//    return [[SWPhotoPresentAnimator alloc] init];
//}
//
//- (id <UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed;
//{
//    return [[SWPhotoDismissAnimator alloc] init];
//}

@end
