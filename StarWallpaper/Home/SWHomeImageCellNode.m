//
//  SWHomeImageCellNode.m
//  StarWallpaper
//
//  Created by Fnoz on 16/4/1.
//  Copyright © 2016年 Fnoz. All rights reserved.
//

#import "SWHomeImageCellNode.h"

@implementation SWHomeImageCellNode {
  ASImageNode *_imageNode;
}

- (id)initWithImage:(UIImage *)image
{
  self = [super init];
  if (self != nil) {
    _imageNode = [[ASImageNode alloc] init];
    _imageNode.image = image;
    [self addSubnode:_imageNode];
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
