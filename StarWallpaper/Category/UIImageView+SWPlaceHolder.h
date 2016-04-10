//
//  UIImageView+SWPlaceHolder.h
//  StarWallpaper
//
//  Created by Fnoz on 16/1/25.
//
//

#import <Foundation/Foundation.h>

@interface UIImageView (SWPlaceHolder)

typedef void(^SWImageCenterDownloadProgressBlock)(CGFloat percentage);

typedef void(^SWImageCenterDownloadCompletedBlock)(UIImage *image, NSError *error);

- (void)sw_setImageUrl:(NSString *)url
              progress:(SWImageCenterDownloadProgressBlock)progressBlock
             completed:(SWImageCenterDownloadCompletedBlock)completedBlock;

@end
