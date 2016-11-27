//
//  SWPhotoDismissAnimator.m
//  StarWallpaper
//
//  Created by Fnoz on 2016/11/27.
//  Copyright © 2016年 Fnoz. All rights reserved.
//

#import "SWPhotoDismissAnimator.h"

@implementation SWPhotoDismissAnimator

- (NSTimeInterval)transitionDuration:(id <UIViewControllerContextTransitioning>)transitionContext
{
    return 0.3f;
}

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext
{
    UIView *containerView = [transitionContext containerView];

    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    CGRect finalFrame = [transitionContext finalFrameForViewController:toVC];
    toVC.view.frame = CGRectOffset(finalFrame, 0, 0);
    [containerView addSubview:toVC.view];

    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    fromVC.view.frame = CGRectOffset(finalFrame, 0, 0);
    [containerView addSubview:fromVC.view];
    
    
    fromVC.view.center = CGPointMake(finalFrame.size.width * 0.5, finalFrame.size.height * 0.5);
    fromVC.view.transform = CGAffineTransformMakeScale(1, 1);
    NSTimeInterval duration = [self transitionDuration:transitionContext];
    [UIView animateWithDuration:duration
                          delay:0
                        options:UIViewAnimationOptionCurveEaseIn
                     animations:^{
                         fromVC.view.transform = CGAffineTransformMakeScale(1 / 3.0, 1 / 3.0);
                         fromVC.view.center = self.oriCenter;
                     }
                     completion:^(BOOL finished) {
                         [transitionContext completeTransition:YES];
                     }];
    
    return;
}

@end
