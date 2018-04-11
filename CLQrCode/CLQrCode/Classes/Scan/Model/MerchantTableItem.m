//
//  MerchantTableItem.m
//  CLQrCode
//
//  Created by Mac on 2018/2/2.
//  Copyright © 2018年 z. All rights reserved.
//

#import "MerchantTableItem.h"

@implementation MerchantTableItem

+(MerchantTableItem *)merchantTableItemWithMerchantId:(NSString *)merchantId MerchantName:(NSString *)merchantName ImageUrl:(NSString *)imageUrl Name:(NSString *)nameString Inventory:(NSString *)inventory RetailAllPrice:(NSString *)retailAllPrice RetailSinglePrice:(NSString *)retailSinglePrice {
    MerchantTableItem *merchantItem = [[MerchantTableItem alloc] init];
    merchantItem.merchantId = merchantId;
    merchantItem.merchantName = merchantName;
    merchantItem.imageUrl = imageUrl;
    merchantItem.nameString = nameString;
    merchantItem.inventory = inventory;
    merchantItem.retailAllPrice = retailAllPrice;
    merchantItem.retailSinglePrice = retailSinglePrice;
    return merchantItem;
}
@end
