//
//  CLScanHelper.h
//  CLQrCode
//
//  Created by Mac on 2018/1/22.
//  Copyright © 2018年 z. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, ScanType)
{
    ScanType_QRCode,
    ScanType_BarCode
};

typedef void(^CLScanSuccessBlock)(NSString *resultString, ScanType scanType);

@interface CLScanHelper : NSObject

+ (instancetype)sharedInstance;

@property (nonatomic, strong) UIView *scanView;
@property (nonatomic, copy) CLScanSuccessBlock scanBlock;
@property (nonatomic, assign) ScanType type;

- (void)startRunning;
- (void)stopRunning;
- (void)showLayer:(UIView *)superView;
- (void)initScanningRect:(CGRect)scanRect;
// 销毁扫描线条移动计时器
- (void)destructTimer;

@end
