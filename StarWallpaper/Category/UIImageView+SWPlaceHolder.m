//
//  UIImageView+SWPlaceHolder.m
//  StarWallpaper
//
//  Created by Fnoz on 16/1/25.
//
//

#import "UIImageView+SWPlaceHolder.h"
#import "UIImageView+WebCache.h"

@implementation UIImageView (SWPlaceHolder)

- (void)sw_setImageUrl:(NSString *)url
              progress:(SWImageCenterDownloadProgressBlock)progressBlock
             completed:(SWImageCenterDownloadCompletedBlock)completedBlock
{
    CGRect frame = CGRectMake(0, 0, 45.0, 45.0);
    if (self.frame.size.width < 45.0 || self.frame.size.height < 45.0) {
        if (self.frame.size.width / 45 > self.frame.size.height / 45.0) {
            frame.size.width = self.frame.size.height / 45.0 * 45.0;
            frame.size.height = self.frame.size.height;
        }
        else {
            frame.size.height = self.frame.size.width / 45.0 * 45.0;
            frame.size.width = self.frame.size.width;
        }
    }
    
    UIView *newView = [[UIView alloc] initWithFrame:self.frame];
    newView.backgroundColor = kSWBackGroundGray;
    [self addSubview:newView];
    
    UIImageView *kdPlaceHolder = [[UIImageView alloc] initWithFrame:frame];
    kdPlaceHolder.image = [UIImage imageNamed:@"imageLoading"];
    kdPlaceHolder.center = CGPointMake(self.frame.size.width * 0.5, self.frame.size.height * 0.5);
    [self addSubview:kdPlaceHolder];
    
    CABasicAnimation *rotationAnimation;
    rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotationAnimation.toValue = [NSNumber numberWithFloat:M_PI * 2.0];
    rotationAnimation.duration = 0.7;
    rotationAnimation.cumulative = YES;
    rotationAnimation.repeatCount = 1024;
    [kdPlaceHolder.layer addAnimation:rotationAnimation forKey:@"rotationAnimation"];
    
    [self sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:nil options:SDWebImageRetryFailed progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        if (progressBlock && receivedSize>0 && expectedSize>0) {
            progressBlock(receivedSize * 100 / expectedSize);
        }
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        [kdPlaceHolder removeFromSuperview];
        [UIView animateWithDuration:0.3 animations:^{
            newView.alpha = 0;
        } completion:^(BOOL finished) {
            if ([newView superview]) {
                [newView removeFromSuperview];
            }
        }];
        if (completedBlock) {
            completedBlock(image, error);
        }
    }];
}

@end
