//
//  PlatformCell.m
//  CLQrCode
//
//  Created by Mac on 2018/2/1.
//  Copyright © 2018年 z. All rights reserved.
//

#import "PlatformCell.h"
#import "UIImageView+WebCache.h"

@implementation PlatformCell

+(CGFloat)heightWithItem:(RETableViewItem *)item tableViewManager:(RETableViewManager *)tableViewManager{
    return 125.f;
}

- (void)cellDidLoad {
    self.productImageView = [[UIImageView alloc] initWithFrame:CGRectMake(12, 12, 100, 100)];
//    self.productImageView = [[UIImageView alloc] init];
    self.productImageView.backgroundColor = [UIColor clearColor];
    [self addSubview:self.productImageView];
//    [self.productImageView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.size.mas_equalTo(CGSizeMake(100, 100));
//        make.left.mas_equalTo(self.mas_left).with.offset(12);
//        make.top.mas_equalTo(self.mas_top).with.offset(12);
//    }];
    
    self.productNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(124, 12, KMainW - 136, 15)];
//    self.productNameLabel = [[UILabel alloc] init];
    self.productNameLabel.backgroundColor = [UIColor clearColor];
    self.productNameLabel.textColor = kColor_3;
    self.productNameLabel.textAlignment = NSTextAlignmentLeft;
    self.productNameLabel.font = [UIFont systemFontOfSize:13.f];
    self.productNameLabel.numberOfLines = 0;
    [self addSubview:self.productNameLabel];
//    [self.productImageView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.size.mas_equalTo(CGSizeMake(KMainW - 136, 15));
//        make.left.mas_equalTo(self.productImageView.mas_right).with.offset(12);
//        make.top.mas_equalTo(self.mas_top).with.offset(12);
//    }];
    
    self.inventoryButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.inventoryButton.frame = CGRectMake(124, self.productNameLabel.frame.origin.y + self.productNameLabel.frame.size.height + 10, 80, 20);
    [self.inventoryButton setBackgroundColor:kColor_11];
    [self.inventoryButton setTitleColor:kColor_1 forState:UIControlStateNormal];
    self.inventoryButton.titleLabel.font = [UIFont systemFontOfSize:12.f];
    self.inventoryButton.layer.cornerRadius = 10;
    self.inventoryButton.layer.masksToBounds = YES;
    [self addSubview:self.inventoryButton];
//    [self.inventoryButton mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.size.mas_equalTo(CGSizeMake(80, 20));
//        make.left.mas_equalTo(self.productImageView.mas_right).with.offset(12);
//        make.top.mas_equalTo(self.productNameLabel.mas_top).with.offset(10);
//    }];
    
    self.hotLabel = [[UILabel alloc] initWithFrame:CGRectMake(124, self.inventoryButton.frame.origin.y + self.inventoryButton.frame.size.height + 20, KMainW - 198, 11)];
//    self.hotLabel = [[UILabel alloc] init];
    self.hotLabel.textColor = kColor_5;
    self.hotLabel.textAlignment = NSTextAlignmentLeft;
    self.hotLabel.font = [UIFont systemFontOfSize:10.f];
    [self addSubview:self.hotLabel];
//    [self.hotLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.size.mas_equalTo(CGSizeMake(KMainW - 198, 11));
//        make.left.mas_equalTo(self.productImageView.mas_right).with.offset(12);
//        make.top.mas_equalTo(self.inventoryButton.mas_top).with.offset(20);
//    }];
    
    self.importButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.importButton.frame = CGRectMake(KMainW - 74, 88, 50, 25);
    self.importButton.backgroundColor = kColor_15;
    [self.importButton setTitle:@"导入" forState:UIControlStateNormal];
    [self.importButton setTitleColor:kColor_1 forState:UIControlStateNormal];
    self.importButton.titleLabel.font = [UIFont systemFontOfSize:15.f];
    self.importButton.layer.masksToBounds = YES;
    self.importButton.layer.cornerRadius = 2.f;
    [self.importButton addTarget:self action:@selector(importButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.importButton];
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(12, 124, KMainW - 12, 1)];
    line.backgroundColor = kColor_7;
    [self addSubview:line];
}

- (void)cellWillAppear {
    [super cellWillAppear];
    [self.productImageView sd_setImageWithURL:[NSURL URLWithString:self.item.imageUrl] placeholderImage:[UIImage imageNamed:@"personal_ic_head_def"]];
    CGFloat nameHeight = kgetContentHeight(self.item.nameString, (KMainW - 136), 13);
    if (nameHeight > 15) {
        self.productNameLabel.frame = CGRectMake(124, 12, KMainW - 136, nameHeight);
//        [self.productNameLabel mas_updateConstraints:^(MASConstraintMaker *make) {
//            make.size.mas_equalTo(CGSizeMake(KMainW - 136, nameHeight));
//        }];
    }
    self.productNameLabel.text = self.item.nameString;
    CGFloat inventoryWidth = kgetContentMaxWidth(self.item.inventory, 12) + 20;
    [self.inventoryButton setTitle:self.item.inventory forState:UIControlStateNormal];
    self.inventoryButton.frame = CGRectMake(124, self.productNameLabel.frame.origin.y + self.productNameLabel.frame.size.height + 10, inventoryWidth, 20);

//    [self.inventoryButton mas_updateConstraints:^(MASConstraintMaker *make) {
//        make.size.mas_equalTo(CGSizeMake(inventoryWidth, 20));
//    }];
    self.hotLabel.text = [NSString stringWithFormat:@"热度%@",self.item.hotCount];
    self.hotLabel.frame = CGRectMake(124, self.inventoryButton.frame.origin.y + self.inventoryButton.frame.size.height + 20, KMainW - 198, 11);
    
    self.importButton.tag = [self.item.productId integerValue];
    
    if ([self.item.cuisineArray count] > 0) {
        [self initWithCuisineView];
    }
}

- (void)initWithCuisineView {
    NSMutableArray *showCuisineArray = [NSMutableArray array];
    CGFloat tempWidth = 0.f;
    CGFloat currentWidth = 0.f;
    for (NSDictionary *dict in self.item.cuisineArray) {
        NSString *name = [dict objectForKey:@"name"];
        tempWidth += kgetContentMaxWidth(name, 10) + 10;
        
        if (tempWidth > 100) {
            tempWidth -= kgetContentMaxWidth(name, 10) - 10;
            return;
        } else {
            [showCuisineArray addObject:dict];
        }
    }
    
    for (NSInteger i = [showCuisineArray count]; i > 0; i--) {
        NSDictionary *dict = [showCuisineArray objectAtIndex:(i - 1)];
        NSString *name = [dict objectForKey:@"name"];
        NSString *type = [dict objectForKey:@"type"];
        currentWidth = kgetContentMaxWidth(name, 10) + 10;
        UIImageView *typeView = [[UIImageView alloc] init];
        if ([type integerValue] == 0) {
            typeView.image = [UIImage imageNamed:@"scan_bg_label_blue"];
        } else if ([type integerValue] == 1) {
            typeView.image = [UIImage imageNamed:@"scan_bg_label_red"];
        } else if ([type integerValue] == 2) {
            typeView.image = [UIImage imageNamed:@"scan_bg_label_orange"];
        }
        [self.productImageView addSubview:typeView];
        [typeView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(tempWidth, 15));
            make.left.mas_equalTo(self.productImageView.mas_left);
            make.bottom.mas_equalTo(self.productImageView.mas_bottom);
        }];
        
        UILabel *nameLabel = [[UILabel alloc] init];
        nameLabel.text = name;
        nameLabel.textColor = kColor_1;
        nameLabel.textAlignment = NSTextAlignmentCenter;
        nameLabel.font = [UIFont systemFontOfSize:10.f];
        [typeView addSubview:nameLabel];
        [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(currentWidth, 11));
            make.right.mas_equalTo(typeView.mas_right);
            make.centerY.mas_equalTo(typeView.mas_centerY);
        }];
        
    }
}

- (void)importButtonClick:(id)sender {
    UIButton *button = (UIButton *)sender;
    self.importProductBlock(button.tag);
}

@end
