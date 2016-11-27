//
//  SWPhotoPresentAnimator.m
//  StarWallpaper
//
//  Created by Fnoz on 2016/11/27.
//  Copyright © 2016年 Fnoz. All rights reserved.
//

#import "SWPhotoPresentAnimator.h"

@implementation SWPhotoPresentAnimator

- (NSTimeInterval)transitionDuration:(id <UIViewControllerContextTransitioning>)transitionContext
{
    return 0.3f;
}

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext
{
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    CGRect finalFrame = [transitionContext finalFrameForViewController:toVC];
    toVC.view.frame = CGRectOffset(finalFrame, 0, 0);
    
    UIView *containerView = [transitionContext containerView];
    [containerView addSubview:toVC.view];
    
    toVC.view.transform = CGAffineTransformMakeScale(1 / 3.0, 1 / 3.0);
    toVC.view.center = self.oriCenter;
    NSTimeInterval duration = [self transitionDuration:transitionContext];
    [UIView animateWithDuration:duration
                          delay:0
                        options:UIViewAnimationOptionCurveEaseIn
                     animations:^{
                         toVC.view.center = CGPointMake(finalFrame.size.width * 0.5, finalFrame.size.height * 0.5);
                         toVC.view.transform = CGAffineTransformMakeScale(1, 1);
                     }
                     completion:^(BOOL finished) {
                         [transitionContext completeTransition:YES];
                     }];
}

@end
