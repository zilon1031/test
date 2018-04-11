//
//  NoMerchantView.m
//  CLQrCode
//
//  Created by Mac on 2018/2/2.
//  Copyright © 2018年 z. All rights reserved.
//

#import "NoMerchantView.h"

@implementation NoMerchantView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        [self initWithNoMerchantView];
    }
    return self;
}

- (void)initWithNoMerchantView {
    UIImage *noMerchantImage = [UIImage imageNamed:@"scan_ic_content_blank"];
    
    UIImageView *noMerchantImageView = [[UIImageView alloc] init];
    noMerchantImageView.backgroundColor = [UIColor clearColor];
    noMerchantImageView.image = noMerchantImage;
    [self addSubview:noMerchantImageView];
    [noMerchantImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(noMerchantImage.size.width, noMerchantImage.size.height));
        make.top.mas_equalTo(self.mas_top).with.mas_offset(25);
        make.centerX.mas_equalTo(self.mas_centerX);
    }];
    
    
    UILabel *sorryLabel = [[UILabel alloc] init];
    sorryLabel.text = @"非常抱歉";
    sorryLabel.textAlignment = NSTextAlignmentCenter;
    sorryLabel.textColor = kColor_2;
    sorryLabel.font = [UIFont systemFontOfSize:15.f];
    [self addSubview:sorryLabel];
    [sorryLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(KMainW - 24, 16));
        make.left.mas_equalTo(self.mas_left).with.mas_offset(12);
        make.top.mas_equalTo(noMerchantImageView.mas_bottom).with.mas_offset(15);
    }];
    
    UILabel *tipLabel = [[UILabel alloc] init];
    tipLabel.text = @"您附近没有商家出售该产品";
    tipLabel.textAlignment = NSTextAlignmentCenter;
    tipLabel.textColor = kColor_2;
    tipLabel.font = [UIFont systemFontOfSize:15.f];
    [self addSubview:tipLabel];
    [tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(KMainW - 24, 16));
        make.left.mas_equalTo(self.mas_left).with.mas_offset(12);
        make.top.mas_equalTo(sorryLabel.mas_bottom).with.mas_offset(10);
    }];
}
@end
