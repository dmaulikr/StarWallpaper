//
//  UIImageView+SWPlaceHolder.m
//  StarWallpaper
//
//  Created by Fnoz on 16/1/25.
//
//

#import "UIImageView+SWPlaceHolder.h"
#import "UIImageView+WebCache.h"
#import <objc/runtime.h>

@implementation UIImageView (SWPlaceHolder)

@dynamic muskView;
@dynamic kdPlaceHolder;

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
    
    [self.muskView removeFromSuperview];
    self.muskView = nil;
    self.muskView = [[UIView alloc] initWithFrame:self.frame];
    self.muskView.backgroundColor = kSWBackGroundGray;
    [self addSubview:self.muskView];
    
    [self.kdPlaceHolder removeFromSuperview];
    self.kdPlaceHolder = nil;
    self.kdPlaceHolder = [[UIImageView alloc] initWithFrame:frame];
    self.kdPlaceHolder.image = [UIImage imageNamed:@"imageLoading"];
    self.kdPlaceHolder.center = CGPointMake(self.frame.size.width * 0.5, self.frame.size.height * 0.5);
    [self addSubview:self.kdPlaceHolder];
    
    CABasicAnimation *rotationAnimation;
    rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotationAnimation.toValue = [NSNumber numberWithFloat:M_PI * 2.0];
    rotationAnimation.duration = 0.7;
    rotationAnimation.cumulative = YES;
    rotationAnimation.removedOnCompletion = NO;
    rotationAnimation.repeatCount = 1024;
    [self.kdPlaceHolder.layer addAnimation:rotationAnimation forKey:@"rotationAnimation"];
    
    [self sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:nil options:SDWebImageRetryFailed progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        if (progressBlock && receivedSize>0 && expectedSize>0) {
            progressBlock(receivedSize * 100 / expectedSize);
        }
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        [self.kdPlaceHolder removeFromSuperview];
        [UIView animateWithDuration:0.3 animations:^{
            self.muskView.alpha = 0;
        } completion:^(BOOL finished) {
            if ([self.muskView superview]) {
                [self.muskView removeFromSuperview];
            }
        }];
        if (completedBlock) {
            completedBlock(image, error);
        }
    }];
}

-(void)setMuskView:(UIView *)muskView {
    objc_setAssociatedObject(self, @selector(muskView), muskView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(UIView *)muskView {
    return objc_getAssociatedObject(self, @selector(muskView));
}

-(void)setKdPlaceHolder:(UIImageView *)kdPlaceHolder {
    objc_setAssociatedObject(self, @selector(kdPlaceHolder), kdPlaceHolder, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(UIImageView *)kdPlaceHolder {
    return objc_getAssociatedObject(self, @selector(kdPlaceHolder));
}

@end
