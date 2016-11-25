//
//  SWCommonUtil.m
//  StarWallpaper
//
//  Created by Fnoz on 16/4/6.
//  Copyright © 2016年 Fnoz. All rights reserved.
//

#import "SWCommonUtil.h"
#import "CRToast.h"
#import "SWConstDef.h"

@implementation SWCommonUtil

+ (BOOL)is5OrEarlier
{
    return (kScreenHeight <= 568);
}

+ (BOOL)is6Or6s
{
    return (kScreenHeight == 667);
}

+ (BOOL)is6pOr6sp
{
    return (kScreenHeight == 736);
}

+ (UIViewController *)getCurrentVC
{
    UIViewController *result = nil;
    
    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
    if (window.windowLevel != UIWindowLevelNormal)
    {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(UIWindow * tmpWin in windows)
        {
            if (tmpWin.windowLevel == UIWindowLevelNormal)
            {
                window = tmpWin;
                break;
            }
        }
    }
    
    UIView *frontView = [[window subviews] objectAtIndex:0];
    id nextResponder = [frontView nextResponder];
    
    if ([nextResponder isKindOfClass:[UIViewController class]])
        result = nextResponder;
    else
        result = window.rootViewController;
    
    return result;
}

+ (NSString *)replaceUnicode:(NSString *)unicodeStr
{
    
    NSString *tempStr1 = [unicodeStr stringByReplacingOccurrencesOfString:@"\\u"withString:@"\\U"];
    NSString *tempStr2 = [tempStr1 stringByReplacingOccurrencesOfString:@"\""withString:@"\\\""];
    NSString *tempStr3 = [[@"\""stringByAppendingString:tempStr2] stringByAppendingString:@"\""];
    NSData *tempData = [tempStr3 dataUsingEncoding:NSUTF8StringEncoding];
    NSString* returnStr = [NSPropertyListSerialization propertyListFromData:tempData
                                                           mutabilityOption:NSPropertyListImmutable
                                                                     format:NULL
                                                           errorDescription:NULL];
    return [returnStr stringByReplacingOccurrencesOfString:@"\\r\\n"withString:@"\n"];
}

+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString {
    if (jsonString == nil) {
        return nil;
    }
    
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                        options:NSJSONReadingMutableContainers
                                                          error:&err];
    if(err) {
        NSLog(@"json解析失败：%@",err);
        return nil;
    }
    return dic;
}

+ (NSString *)getBigImageUrl:(NSString *)imageUrl
{
    if ([imageUrl rangeOfString:@","].location != NSNotFound) {
        imageUrl = [imageUrl substringToIndex:[imageUrl rangeOfString:@","].location];
        NSInteger width = (NSInteger)(kScreenWidth* [UIScreen mainScreen].scale);
        imageUrl = [imageUrl stringByAppendingString:[NSString stringWithFormat:@"%ld,%f.webp", (long)width, width*kScreenHeight/kScreenWidth]];
    }
    return imageUrl;
}

+ (NSString *)getSmallImageUrl:(NSString *)imageUrl
{
    
    if ([imageUrl rangeOfString:@","].location != NSNotFound) {
        imageUrl = [imageUrl substringToIndex:[imageUrl rangeOfString:@","].location];
        NSInteger width = (NSInteger)(kScreenWidth * [UIScreen mainScreen].scale /3);
        imageUrl = [imageUrl stringByAppendingString:[NSString stringWithFormat:@",%ld,%ld.webp", (long)width, (long)(width*kScreenHeight/kScreenWidth)]];
    }
    return imageUrl;
}

+ (void)saveImageToAlbum:(UIImage *)image
{
    UIImageWriteToSavedPhotosAlbum(image, self, @selector(imageSavedToPhotosAlbum:didFinishSavingWithError:contextInfo:), nil);
}

+ (void)imageSavedToPhotosAlbum:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
    NSString *notificationString = @"Hello";
    UIColor *color;
    if (!error) {
        notificationString = @"成功保存到相册";
        color = [UIColor blackColor];
    }else
    {
        notificationString = @"保存到相册失败";
        color = [UIColor redColor];
    }
    NSDictionary *options = @{
                              kCRToastTextKey : notificationString,
                              kCRToastTextAlignmentKey : @(NSTextAlignmentCenter),
                              kCRToastBackgroundColorKey : color,
                              kCRToastAnimationInTypeKey : @(CRToastAnimationTypeLinear),
                              kCRToastAnimationOutTypeKey : @(CRToastAnimationTypeLinear),
                              kCRToastAnimationInDirectionKey : @(CRToastAnimationDirectionTop),
                              kCRToastAnimationOutDirectionKey : @(CRToastAnimationDirectionTop),
                              kCRToastNotificationTypeKey: [UIApplication sharedApplication].isStatusBarHidden?@(CRToastTypeNavigationBar):@(CRToastTypeStatusBar)
                              };
    [CRToastManager showNotificationWithOptions:options
                                completionBlock:nil];
}

@end
