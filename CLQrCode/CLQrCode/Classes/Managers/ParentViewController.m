//
//  ParentViewController.m
//  CLQrCode
//
//  Created by Mac on 2018/1/31.
//  Copyright © 2018年 z. All rights reserved.
//

#import "ParentViewController.h"
#define kTitleWidth 220


@interface ParentViewController ()

@end

@implementation ParentViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self){
        self.tvHeight = KMainH - (AboveIOS7 ? 0:20);
        self.IOS7AddY = 0;
        if (AboveIOS7){
            self.IOS7AddY = 20;
        }
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];
    UIView *navbgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KMainW, 44 + self.IOS7AddY)];
    [self.view addSubview:navbgView];
    
    self.navigationView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, KMainW, 44 + self.IOS7AddY)];
    self.navigationView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.navigationView];
    
    
    UIImageView *navigationBgView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, KMainW, self.navigationView.frame.size.height)];
    navigationBgView.backgroundColor = kColor_9;
    [self.navigationView addSubview:navigationBgView];
    
    self.naviBackBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.naviBackBtn.backgroundColor = [UIColor clearColor];
    UIImage * image = [UIImage imageNamed:@"nav_btn_back_def"];
    CGSize imageSize = image.size;
    self.naviBackBtn.frame = CGRectMake(0, self.navigationView.frame.size.height - 44, imageSize.width + 12 * 2, 44);
    [self.naviBackBtn setImage:image forState:UIControlStateNormal];
    [self.naviBackBtn setImage:image forState:UIControlStateHighlighted];
    [self.naviBackBtn addTarget:self action:@selector(backClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.navigationView addSubview:self.naviBackBtn];
    
    self.naviTopLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.navigationView.frame.size.width / 2 - kTitleWidth / 2, _navigationView.frame.size.height - 34, kTitleWidth, 24)];
    self.naviTopLabel.textColor = kColor_1;
    self.naviTopLabel.backgroundColor = [UIColor clearColor];
    self.naviTopLabel.font = [UIFont systemFontOfSize:18];
    self.naviTopLabel.textAlignment = NSTextAlignmentCenter;
    [self.navigationView addSubview:self.naviTopLabel];
    
    self.lineLabel = [[UIView alloc] initWithFrame:CGRectMake(0, self.IOS7AddY + 44 - 0.5, KMainW, 0.5)];
    self.lineLabel.hidden = YES;
    self.lineLabel.backgroundColor = kColor_9;
    [self.navigationView addSubview:self.lineLabel];
}

#pragma mark- 添加自定义按钮
-(void)backClick:(id)sender{
    [self.navigationController popViewControllerAnimated:YES];
}

// 添加左侧文字按钮
-(void)addLeftNaviButton:(NSString *)title action:(SEL)action{
    self.naviBackBtn.hidden = YES;
    UIFont *font = [UIFont systemFontOfSize:15.f];
    CGSize textSize = [title sizeWithAttributes:@{ NSFontAttributeName:font }];
    
    self.naviLeftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.naviLeftButton.frame=CGRectMake(0, self.navigationView.frame.size.height - 44, textSize.width + 12*2, 44);
    [self.naviLeftButton setBackgroundColor:[UIColor clearColor]];
    [self.naviLeftButton setTitle:title forState:UIControlStateNormal];
    [self.naviLeftButton setTitleColor:kColor_1 forState:UIControlStateNormal];
    [self.naviLeftButton setTitleColor:kColor_1 forState:UIControlStateHighlighted];
    self.naviLeftButton.titleLabel.font = font;
    self.naviLeftButton.titleLabel.textAlignment = NSTextAlignmentCenter;
    [self.naviLeftButton addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];
    [self.navigationView addSubview:self.naviLeftButton];
}

// 添加右侧文字按钮
-(UIButton *)addRightNaviButton:(NSString *)title action:(SEL)action{
    UIFont *font = [UIFont systemFontOfSize:16.0f];
    CGSize textSize = [title sizeWithAttributes:@{ NSFontAttributeName:font }];
    UIButton *button=[UIButton buttonWithType:UIButtonTypeCustom];
    button.frame=CGRectMake(KMainW - textSize.width - 12 * 2, self.navigationView.frame.size.height - 44, textSize.width + 12 * 2, 44);
    [button setBackgroundColor:[UIColor clearColor]];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:kColor_1 forState:UIControlStateNormal];
    [button setTitleColor:kColor_1 forState:UIControlStateHighlighted];
    button.titleLabel.font = font;
    button.titleLabel.textAlignment = NSTextAlignmentCenter;
    [button addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];
    [self.navigationView addSubview:button];
    return button;
}

//设置按钮 上面图片，下面文字
- (void)setImageButton:(UIButton *)button aboveImage:(NSString *)aboveImage belowTitle:(NSString *)belowTitle offerY:(float)offerY font:(float)font textColor:(UIColor *)color{
    UIImage * image = [UIImage imageNamed:aboveImage];
    float titleHeight = kgetContentHeight(belowTitle, button.frame.size.width, font);
    UIImageView * imageIV = [[UIImageView alloc] initWithFrame:CGRectMake((button.frame.size.width - image.size.width) / 2 , (button.frame.size.height - image.size.height - titleHeight - offerY) / 2 , image.size.width, image.size.height)];
    imageIV.image = image;
    [button addSubview:imageIV];
    
    UILabel * titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, imageIV.frame.origin.y + imageIV.frame.size.height + offerY, button.frame.size.width, titleHeight)];
    titleLabel.text = belowTitle;
    titleLabel.textColor = color;
    titleLabel.font = [UIFont systemFontOfSize:font];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [button addSubview:titleLabel];
}

//设置按钮 左面图片，右面文字
- (void)setImageButton:(UIButton *)button leftImage:(NSString *)leftImage rightTitle:(NSString *)rightTitle offerX:(float)offerX font:(float)font textColor:(UIColor *)color{
    UIImage * image = [UIImage imageNamed:leftImage];
    float imageWidth = image.size.width;
    float imageHeight = image.size.height;
    float titleWidth = kgetContentMaxWidth(rightTitle, font);
    float titleHeight = kgetContentHeight(rightTitle, titleWidth, font);
    
    if (imageWidth > button.frame.size.width){
        imageWidth = button.frame.size.width;
    }
    if (imageWidth > button.frame.size.height){
        imageHeight = button.frame.size.height;
    }
    if (titleWidth > (button.frame.size.width - imageWidth - offerX)){
        titleWidth = button.frame.size.width - imageWidth - offerX;
    }
    if (titleHeight > button.frame.size.height){
        titleHeight = button.frame.size.height;
    }
    UIImageView * imageIV = [[UIImageView alloc] initWithFrame:CGRectMake((button.frame.size.width - image.size.width - titleWidth - offerX) / 2 , (button.frame.size.height - image.size.height) / 2, imageWidth, imageHeight)];
    imageIV.image = image;
    [button addSubview:imageIV];
    
    UILabel * titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(imageIV.frame.origin.x + imageIV.frame.size.width + offerX, (button.frame.size.height - titleHeight) / 2, titleWidth, titleHeight)];
    titleLabel.text = rightTitle;
    titleLabel.textColor = color;
    titleLabel.font = [UIFont systemFontOfSize:font];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [button addSubview:titleLabel];
}

//设置按钮 左面文字，右面图片
- (void)setImageButton:(UIButton *)button leftTitle:(NSString *)leftTitle rightImage:(NSString *)rightImage offerX:(float)offerX font:(float)font textColor:(UIColor *)color{
    UIImage * image = [UIImage imageNamed:rightImage];
    float imageWidth = image.size.width;
    float imageHeight = image.size.height;
    float titleWidth = kgetContentMaxWidth(leftTitle, font);
    float titleHeight = kgetContentHeight(leftTitle, titleWidth, font);
    
    if (imageWidth > button.frame.size.width){
        imageWidth = button.frame.size.width;
    }
    if (imageHeight > button.frame.size.height){
        imageHeight = button.frame.size.height;
    }
    if (titleWidth > (button.frame.size.width - imageWidth - offerX)){
        titleWidth = button.frame.size.width - imageWidth - offerX;
    }
    if (titleHeight > button.frame.size.height){
        titleHeight = button.frame.size.height;
    }
    
    UILabel * titleLabel = [[UILabel alloc] initWithFrame:CGRectMake((button.frame.size.width - image.size.width - titleWidth - offerX) / 2, (button.frame.size.height - titleHeight) / 2, titleWidth, titleHeight)];
    titleLabel.text = leftTitle;
    titleLabel.textColor = color;
    titleLabel.font = [UIFont systemFontOfSize:font];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [button addSubview:titleLabel];
    
    UIImageView * imageIV = [[UIImageView alloc] initWithFrame:CGRectMake(titleLabel.frame.origin.x + titleLabel.frame.size.width + offerX , (button.frame.size.height - image.size.height) / 2, imageWidth, imageHeight)];
    imageIV.image = image;
    [button addSubview:imageIV];
}

@end
