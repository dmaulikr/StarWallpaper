//
//  SWHomeImageCellNode.m
//  StarWallpaper
//
//  Created by Fnoz on 16/4/1.
//  Copyright © 2016年 Fnoz. All rights reserved.
//

#import "SWHomeImageCellNode.h"
#import "SDWebImageManager.h"

@implementation SWHomeImageCellNode {
  ASImageNode *_imageNode;
}

- (id)initWithImageUrl:(NSURL *)url
{
  self = [super init];
  if (self != nil) {
      _imageNode = [[ASImageNode alloc] init];
      [self addSubnode:_imageNode];
      //fnoztodo 用SD下载图片
      [[SDWebImageManager sharedManager] downloadImageWithURL:[NSURL URLWithString:@"http://s.qdcdn.com/cl/11990432,125,222.jpg"] options:SDWebImageRetryFailed progress:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
          if (image) {
              _imageNode.image = image;
          }
      }];
  }
  return self;
}

- (CGSize)calculateSizeThatFits:(CGSize)constrainedSize
{
  [_imageNode measure:constrainedSize];
  return constrainedSize;
}

- (void)layout
{
  [super layout];
  
  _imageNode.frame = CGRectMake(0, 0, _imageNode.calculatedSize.width, _imageNode.calculatedSize.height);
}

@end
