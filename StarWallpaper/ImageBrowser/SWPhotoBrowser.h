//
//  SWPhotoBrowser.h
//  StarWallpaper
//
//  Created by Fnoz on 16/4/11.
//  Copyright © 2016年 Fnoz. All rights reserved.
//

#import <MWPhotoBrowser/MWPhotoBrowser.h>

@interface SWPhotoBrowser : MWPhotoBrowser <UIViewControllerTransitioningDelegate>

@property (nonatomic, strong) NSArray *itemArray;
@property (nonatomic, assign) CGPoint oriCenter;
@property (nonatomic, assign) NSInteger oriIndex;

@end
