//
//  MerchantCell.h
//  CLQrCode
//
//  Created by Mac on 2018/2/1.
//  Copyright © 2018年 z. All rights reserved.
//

#import <RETableViewManager/RETableViewManager.h>
#import "MerchantTableItem.h"

typedef void(^EnterShopBlock)(NSString *merchantId);

@interface MerchantCell : RETableViewCell

@property (nonatomic, strong) UIImageView *productImageView;
@property (nonatomic, strong) UILabel *productNameLabel;
@property (nonatomic, strong) UIButton *inventoryButton;
//@property (nonatomic, strong) UILabel *retailAllPriceLabel;
//@property (nonatomic, strong) UILabel *retailSinglePriceLabel;
@property (nonatomic, strong) UIView *priceView;
//@property (nonatomic, strong) UILabel *negotiablePriceLabel;
@property (nonatomic, strong) UILabel *merchantNameLabel;
@property (nonatomic, strong) UIButton *enterShopButton;

@property (nonatomic, strong) MerchantTableItem *item;

@property (nonatomic, copy) EnterShopBlock enterShopBlock;

@end
