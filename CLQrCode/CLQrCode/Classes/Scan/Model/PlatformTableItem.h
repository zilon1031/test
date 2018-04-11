//
//  PlatformTableItem.h
//  CLQrCode
//
//  Created by Mac on 2018/2/1.
//  Copyright © 2018年 z. All rights reserved.
//

#import <RETableViewManager/RETableViewManager.h>

@interface PlatformTableItem : RETableViewItem

@property (nonatomic, strong) NSString *productId;
@property (nonatomic, strong) NSString *imageUrl;
@property (nonatomic, strong) NSArray *cuisineArray;
@property (nonatomic, strong) NSString *nameString;
@property (nonatomic, strong) NSString *inventory;
@property (nonatomic, strong) NSString *hotCount;

+(PlatformTableItem *)platformTableItemWithProductId:(NSString *)productId image:(NSString *)imageUrl cuisineArray:(NSArray *)cuisineArray nameString:(NSString *)nameString inventory:(NSString *)inventory hotCount:(NSString *)hotCount;

@end
