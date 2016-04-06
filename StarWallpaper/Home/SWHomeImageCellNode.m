//
//  SWHomeImageCellNode.m
//  StarWallpaper
//
//  Created by Fnoz on 16/4/1.
//  Copyright © 2016年 Fnoz. All rights reserved.
//

#import "SWHomeImageCellNode.h"
#import "SWConstDef.h"

@interface SWHomeImageCellNode () <ASNetworkImageNodeDelegate>

@property (nonatomic, strong) NSURL *imageUrl;

@end

@implementation SWHomeImageCellNode {
  ASNetworkImageNode *_imageNode;
}

- (id)initWithImageUrl:(NSURL *)url
{
  self = [super init];
  if (self != nil) {
      _imageUrl = url;
      _imageNode = [[ASNetworkImageNode alloc] init];
      _imageNode.delegate = self;
      [self addSubnode:_imageNode];
  }
  return self;
}

- (void)layoutDidFinish
{
    [super layoutDidFinish];
    _imageNode.URL = _imageUrl;
}

- (CGSize)calculateSizeThatFits:(CGSize)constrainedSize
{
    _imageNode.frame = CGRectMake(0, 0, constrainedSize.width, constrainedSize.width * kScreenHeight / kScreenWidth);
    return constrainedSize;
}

#pragma - mark ASNetworkImageNode Delegate
- (void)imageNode:(ASNetworkImageNode *)imageNode didLoadImage:(UIImage *)image {
    NSLog(@"%@", image);
}

- (void)imageNode:(ASNetworkImageNode *)imageNode didFailWithError:(NSError *)error {
    NSLog(@"%@", error);
}

- (void)imageNodeDidFinishDecoding:(ASNetworkImageNode *)imageNode {
    NSLog(@"%@", imageNode);
}

@end
