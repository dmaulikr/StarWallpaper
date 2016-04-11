//
//  SearchViewController.m
//  StarWallpaper
//
//  Created by Fnoz on 16/4/4.
//  Copyright © 2016年 Fnoz. All rights reserved.
//

#import "SearchViewController.h"
#import "SWConstDef.h"
#import "SWCommonUtil.h"

#define kSearchFieldHeight 52.0f

@interface SearchViewController () <UITextFieldDelegate>

@property (nonatomic, strong) UITextField *textField;
@property (nonatomic, strong) SWSelectedKeywordBlock block;

@end

@implementation SearchViewController

+ (void)presentWithKeyword:(NSString *)keyword selectedKeywordBlock:(SWSelectedKeywordBlock)block {
    SearchViewController *vc = [[SearchViewController alloc] init];
    vc.keyword = keyword;
    vc.block = block;
    [SWCurrentVC presentViewController:vc animated:YES completion:nil];
}

-(void)viewDidLoad {
    [super viewDidLoad];
    
    UIView *inputAngBtnBgView = [[UIView alloc] initWithFrame:CGRectMake(10+(kSearchFieldHeight-16), 8, self.view.frame.size.width-20 - (kSearchFieldHeight-16)*2, kSearchFieldHeight-16)];
    inputAngBtnBgView.backgroundColor = [UIColor clearColor];
    inputAngBtnBgView.layer.cornerRadius = 5.0f;
    [self.view addSubview:inputAngBtnBgView];
    
    UIImageView *logoView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 8, inputAngBtnBgView.frame.size.height, inputAngBtnBgView.frame.size.height)];
    logoView.image = [UIImage imageNamed:@"Launch"];
    [self.view addSubview:logoView];
    
    self.textField = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, inputAngBtnBgView.frame.size.width, inputAngBtnBgView.frame.size.height)];
    self.textField.backgroundColor = [UIColor whiteColor];
    self.textField.placeholder = @"你的明星壁纸，偶像在身边";
    self.textField.font = SWFontOfSize(20);
    _textField.textColor = kSWFontGreen;
    self.textField.delegate = self;
    _textField.text = _keyword;
    _textField.layer.cornerRadius = 10;
    self.textField.leftViewMode = UITextFieldViewModeAlways;
    self.textField.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 12, self.textField.frame.size.height)];
    self.textField.returnKeyType = UIReturnKeySearch;
    [inputAngBtnBgView addSubview:self.textField];
    
    UIButton *searchBtn = [[UIButton alloc] initWithFrame:CGRectMake(self.view.frame.size.width-(10+(kSearchFieldHeight-16)), 8, (kSearchFieldHeight-16), inputAngBtnBgView.frame.size.height)];
    [searchBtn setImage:[UIImage imageNamed:@"goToSearch"] forState:UIControlStateNormal];
    searchBtn.imageEdgeInsets = UIEdgeInsetsMake(7, 7, 7, 7);
    searchBtn.backgroundColor = [UIColor clearColor];
    [searchBtn addTarget:self action:@selector(search) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:searchBtn];
    
    UIButton *homeBtn = [[UIButton alloc] initWithFrame:CGRectMake((self.view.frame.size.width-50)*0.5, self.view.frame.size.height - 50, 50, 50)];
    homeBtn.alpha = 0.6;
    [homeBtn setImage:[UIImage imageNamed:@"backDown"] forState:UIControlStateNormal];
    [homeBtn addTarget:self action:@selector(search) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:homeBtn];
    
    self.view.backgroundColor = kSWBackGroundGray;
}

- (void)search {
    SWSelectedKeywordBlock block = _block;
    block(_textField.text);
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark UITextFieldDelegate
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (![self.textField.text isEqualToString:@""])
    {
        [self search];
    }
    else
    {
        [self.textField endEditing:YES];
    }
    return YES;
}

@end
