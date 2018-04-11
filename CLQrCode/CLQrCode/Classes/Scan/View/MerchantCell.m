//
//  MerchantCell.m
//  CLQrCode
//
//  Created by Mac on 2018/2/1.
//  Copyright © 2018年 z. All rights reserved.
//

#import "MerchantCell.h"
#import "UIImageView+WebCache.h"

@implementation MerchantCell

+(CGFloat)heightWithItem:(RETableViewItem *)item tableViewManager:(RETableViewManager *)tableViewManager{
    return KMainW/2 + 132;
}

- (void)cellDidLoad {
    if (self.productImageView == nil) {
        self.productImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
    }
    self.productImageView.backgroundColor = [UIColor clearColor];
    [self addSubview:self.productImageView];
    [self.productImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(KMainW / 2 - 24, KMainW / 2 - 24));
        make.left.mas_equalTo(self.mas_left).with.mas_offset(12);
        make.top.mas_equalTo(self.mas_top).with.mas_offset(12);
    }];
     
     if (self.productNameLabel == nil) {
         self.productNameLabel = [[UILabel alloc] initWithFrame:CGRectZero];
     }
    [self formattingLabel:self.productNameLabel titleString:@"" textColor:kColor_3 alignment:NSTextAlignmentLeft fontSize:13.f];
    [self addSubview:self.productNameLabel];
    [self.productNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(KMainW / 2 - 20, 14));
        make.left.mas_equalTo(self.mas_left).with.mas_offset(10);
        make.top.mas_equalTo(self.productImageView.mas_bottom).with.mas_offset(12);
    }];
    if (self.inventoryButton == nil) {
        self.inventoryButton = [UIButton buttonWithType:UIButtonTypeCustom];
    }
    self.inventoryButton.backgroundColor = kColor_11;
    self.inventoryButton.layer.cornerRadius = 10;
    self.inventoryButton.layer.masksToBounds = YES;
    [self.inventoryButton setTitleColor:kColor_1 forState:UIControlStateNormal];
    self.inventoryButton.titleLabel.font = [UIFont systemFontOfSize:12.f];
    [self addSubview:self.inventoryButton];
    [self.inventoryButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(KMainW / 2 - 24, 20));
        make.left.mas_equalTo(self.productNameLabel.mas_left);
        make.top.mas_equalTo(self.productNameLabel.mas_bottom).with.mas_offset(15);
    }];
    if (self.priceView == nil) {
        self.priceView = [[UIView alloc] initWithFrame:CGRectZero];
    }
    self.priceView.backgroundColor = [UIColor yellowColor];
    [self addSubview:self.priceView];
    [self.priceView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(KMainW - 24, 57));
        make.top.mas_equalTo(self.inventoryButton.mas_bottom);
        make.left.mas_equalTo(self.productNameLabel.mas_left);
    }];
    if (self.merchantNameLabel == nil) {
        self.merchantNameLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    }
    [self formattingLabel:self.merchantNameLabel titleString:@"" textColor:kColor_5 alignment:NSTextAlignmentLeft fontSize:12.f];
    [self addSubview:self.merchantNameLabel];
    [self.merchantNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(KMainW - 24, 13));
        make.bottom.mas_equalTo(self.mas_bottom).with.mas_offset(-15);
        make.left.mas_equalTo(self.productNameLabel.mas_left);
    }];
    if (self.enterShopButton == nil) {
        self.enterShopButton = [UIButton buttonWithType:UIButtonTypeCustom];
    }
    self.enterShopButton.backgroundColor = [UIColor clearColor];
    [self.enterShopButton addTarget:self action:@selector(enterShopButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectZero];
    line.backgroundColor = kColor_7;
    [self addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(KMainW, 1));
        make.left.mas_equalTo(self.mas_left);
        make.bottom.mas_equalTo(self.mas_bottom);
    }];
    
    UIView *separatedLine = [[UIView alloc] initWithFrame:CGRectZero];
    separatedLine.backgroundColor = kColor_7;
    [self addSubview:separatedLine];
    [separatedLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(1, KMainW/2 + 132));
        make.left.mas_equalTo(self.mas_left).with.offset(KMainW/2);
        make.top.mas_equalTo(self.mas_top);
    }];
}

- (void)cellWillAppear {
    [super cellWillAppear];
    
    [self.productImageView sd_setImageWithURL:[NSURL URLWithString:self.item.imageUrl] placeholderImage:[UIImage imageNamed:@"personal_ic_head_def"]];
    
    
    self.productNameLabel.text = self.item.nameString;
    
    
    CGFloat inventoryWidth = kgetContentMaxWidth(self.item.inventory, 12) + 20;
    [self.inventoryButton setTitle:self.item.inventory forState:UIControlStateNormal];
    [self.inventoryButton mas_updateConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(inventoryWidth, 20));
    }];
    
    self.merchantNameLabel.text = self.item.merchantName;
    
}

- (void)enterShopButtonClick:(id)sender {
    UIButton *button = (UIButton *)sender;
//    button.tag ;
    
}

- (void)formattingLabel:(UILabel *)label titleString:(NSString *)titleString textColor:(UIColor *)textColor alignment:(NSTextAlignment)alignment fontSize:(CGFloat)fontSize {
    label.backgroundColor = [UIColor clearColor];
    label.text = titleString;
    label.textColor = textColor;
    label.textAlignment = alignment;
    label.font = [UIFont systemFontOfSize:fontSize];
}
@end
