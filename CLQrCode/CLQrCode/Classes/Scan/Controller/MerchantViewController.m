//
//  MerchantViewController.m
//  CLQrCode
//
//  Created by Mac on 2018/1/31.
//  Copyright © 2018年 z. All rights reserved.
//

#import "MerchantViewController.h"

@interface MerchantViewController ()

@end

@implementation MerchantViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = kColor_1;
    
    [self initWithCustomView];
}

- (void)initWithCustomView {
    UILabel * codeLabel = [[UILabel alloc] init];
    codeLabel.backgroundColor = [UIColor clearColor];
    codeLabel.text = self.scanResultString;
    codeLabel.textColor = kColor_2;
    codeLabel.textAlignment = NSTextAlignmentCenter;
    codeLabel.font = [UIFont systemFontOfSize:18.f];
    [self.view addSubview:codeLabel];
    [codeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(KMainW - 24, 30));
        make.center.mas_equalTo(self.view.center);
    }];
}

@end
