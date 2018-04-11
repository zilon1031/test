//
//  MerchantTableItem.h
//  CLQrCode
//
//  Created by Mac on 2018/2/2.
//  Copyright © 2018年 z. All rights reserved.
//

#import <RETableViewManager/RETableViewManager.h>

@interface MerchantTableItem : RETableViewItem

@property (nonatomic, strong) NSString *merchantId;
@property (nonatomic, strong) NSString *merchantName;
@property (nonatomic, strong) NSString *imageUrl;
@property (nonatomic, strong) NSString *nameString;
@property (nonatomic, strong) NSString *inventory;
@property (nonatomic, strong) NSString *retailAllPrice;
@property (nonatomic, strong) NSString *retailSinglePrice;


+(MerchantTableItem *)merchantTableItemWithMerchantId:(NSString *)merchantId MerchantName:(NSString *)merchantName ImageUrl:(NSString *)imageUrl Name:(NSString *)nameString Inventory:(NSString *)inventory RetailAllPrice:(NSString *)retailAllPrice RetailSinglePrice:(NSString *)retailSinglePrice;
@end
