//
//  NoDocumentBarcodeView.m
//  CLQrCode
//
//  Created by Mac on 2018/2/1.
//  Copyright © 2018年 z. All rights reserved.
//

#import "NoDocumentBarcodeView.h"

@implementation NoDocumentBarcodeView

- (instancetype)initWithFrame:(CGRect)frame scanResult:(NSString *)scanResult{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.scanResultString = scanResult;
        [self initWithNoDocView];
    }
    return self;
}

- (void)initWithNoDocView {
    UIView *bgView = [[UIView alloc] init];
    [self formattingBgView:bgView cornerRadius:5 borderColor:kColor_7];
    [self addSubview:bgView];
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake((KMainW - 24), 202));
        make.left.mas_equalTo(self.mas_left).with.mas_offset(12);
        make.top.mas_equalTo(self.mas_top).with.mas_offset(30);
    }];

    UIView *resultBgView = [[UIView alloc] init];
    [self formattingBgView:resultBgView cornerRadius:5 borderColor:kColor_6];
    [bgView addSubview:resultBgView];
    [resultBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake((KMainW - 54), 50));
        make.left.mas_equalTo(bgView.mas_left).with.mas_offset(15);
        make.top.mas_equalTo(bgView.mas_top).with.mas_offset(30);
    }];
    
    CGFloat titleWidth = kgetContentMaxWidth(@"商品条形码", 14) + 1;
    UILabel *titleLabel = [[UILabel alloc] init];
    [self formattingLabel:titleLabel titleString:@"商品条形码" textColor:kColor_5 alignment:NSTextAlignmentLeft fontSize:14.f];
    [resultBgView addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(titleWidth, 15));
        make.left.mas_equalTo(resultBgView.mas_left).with.mas_offset(15);
        make.centerY.mas_equalTo(resultBgView.mas_centerY);
    }];
    
    CGFloat resultWidth = KMainW - 104 - titleWidth;
    UILabel *resultLabel = [[UILabel alloc] init];
    [self formattingLabel:resultLabel titleString:self.scanResultString textColor:kColor_2 alignment:NSTextAlignmentLeft fontSize:12.f];
    [resultBgView addSubview:resultLabel];
    [resultLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(resultWidth, 13));
        make.left.mas_equalTo(titleLabel.mas_right).with.mas_offset(20);
        make.centerY.mas_equalTo(resultBgView.mas_centerY);
    }];
    
    UILabel *tipLabel = [[UILabel alloc] init];
    [self formattingLabel:tipLabel titleString:@"小主，未找到该商品条码匹配的产品，平台上暂无商家出售" textColor:kColor_15 alignment:NSTextAlignmentLeft fontSize:15.f];
    tipLabel.numberOfLines = 0;
    [bgView addSubview:tipLabel];
    [tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(KMainW - 60, 50));
        make.left.mas_equalTo(bgView.mas_left).with.mas_offset(15);
        make.top.mas_equalTo(resultBgView.mas_bottom).with.mas_offset(20);
    }];
}

- (void)formattingBgView:(UIView *)bgView cornerRadius:(CGFloat)cornerRadius borderColor:(UIColor *)borderColor {
    bgView.backgroundColor = kColor_1;
    bgView.layer.masksToBounds = YES;
    bgView.layer.cornerRadius = cornerRadius;
    bgView.layer.borderWidth = 1;
    bgView.layer.borderColor = borderColor.CGColor;
}

- (void)formattingLabel:(UILabel *)label titleString:(NSString *)titleString textColor:(UIColor *)textColor alignment:(NSTextAlignment)alignment fontSize:(CGFloat)fontSize {
    label.backgroundColor = [UIColor clearColor];
    label.text = titleString;
    label.textColor = textColor;
    label.textAlignment = alignment;
    label.font = [UIFont systemFontOfSize:fontSize];
}
@end
