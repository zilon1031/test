//
//  PlatformTableItem.m
//  CLQrCode
//
//  Created by Mac on 2018/2/1.
//  Copyright © 2018年 z. All rights reserved.
//

#import "PlatformTableItem.h"

@implementation PlatformTableItem

+(PlatformTableItem *)platformTableItemWithProductId:(NSString *)productId image:(NSString *)imageUrl cuisineArray:(NSArray *)cuisineArray nameString:(NSString *)nameString inventory:(NSString *)inventory hotCount:(NSString *)hotCount{
    PlatformTableItem *item = [[PlatformTableItem alloc] init];
    item.productId = productId;
    item.imageUrl = imageUrl;
    item.cuisineArray = cuisineArray;
    item.nameString = nameString;
    item.inventory = inventory;
    item.hotCount = hotCount;
    return item;
}

@end
