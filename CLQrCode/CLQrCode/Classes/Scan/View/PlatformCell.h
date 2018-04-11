//
//  PlatformCell.h
//  CLQrCode
//
//  Created by Mac on 2018/2/1.
//  Copyright © 2018年 z. All rights reserved.
//

#import <RETableViewManager/RETableViewManager.h>
#import "PlatformTableItem.h"

typedef void(^ImportProductBlock)(NSInteger productId);


@interface PlatformCell : RETableViewCell

@property (nonatomic, strong) UIImageView *productImageView;
@property (nonatomic, strong) UILabel *productNameLabel;
@property (nonatomic, strong) UIButton *inventoryButton;
@property (nonatomic, strong) UILabel *hotLabel;
@property (nonatomic, strong) UIButton *importButton;

@property (nonatomic, strong) PlatformTableItem *item;

@property (nonatomic, copy) ImportProductBlock importProductBlock;


@end
