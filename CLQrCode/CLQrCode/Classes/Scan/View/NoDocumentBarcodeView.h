//
//  NoDocumentBarcodeView.h
//  CLQrCode
//
//  Created by Mac on 2018/2/1.
//  Copyright © 2018年 z. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NoDocumentBarcodeView : UIView

@property (nonatomic, strong) NSString *scanResultString;

- (instancetype)initWithFrame:(CGRect)frame scanResult:(NSString *)scanResult;

@end
