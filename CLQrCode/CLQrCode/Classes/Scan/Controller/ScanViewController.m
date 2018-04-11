//
//  ScanViewController.m
//  CLQrCode
//
//  Created by Mac on 2018/1/22.
//  Copyright © 2018年 z. All rights reserved.
//

#import "ScanViewController.h"
#import "CLScanHelper.h"
#import "NoDocumentViewController.h"
#import "MerchantViewController.h"

@interface ScanViewController ()

@property (nonatomic, assign) BOOL isOpenLight;

@end

@implementation ScanViewController
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [[CLScanHelper sharedInstance] startRunning];
    [self initWithScanView];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.isOpenLight = NO;
    self.navigationController.navigationBar.hidden = YES;
//    [self initWithScanView];
    [self initWithCustomView];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [[CLScanHelper sharedInstance] destructTimer];
    [[CLScanHelper sharedInstance] destructScanLine];
}

- (void)initWithScanView {
    CGSize scanSize = CGSizeMake(302.f , 302.f);
    CGRect scanRect = CGRectMake((KMainW - scanSize.width)/2, 150, scanSize.width, scanSize.height);
    weakSelf(self)
    [[CLScanHelper sharedInstance] showLayer:self.view];
    [[CLScanHelper sharedInstance] initScanningRect:scanRect];
    [[CLScanHelper sharedInstance] setScanBlock:^(NSString *resultString, ScanType scanType) {
        strongSelf(self)
        NSLog(@"scanResult -- %@", resultString);
        ScanType type = scanType;
        [[CLScanHelper sharedInstance] stopRunning];
        
        self.scanResultBlock(resultString);
        if (type == ScanType_QRCode) {
            MerchantViewController *merchantVC = [[MerchantViewController alloc] init];
            merchantVC.scanResultString = resultString;
            [self.navigationController pushViewController:merchantVC animated:YES];
        } else if (type == ScanType_BarCode) {
            NoDocumentViewController *noDocumentVC = [[NoDocumentViewController alloc] init];
            noDocumentVC.scanResultString = resultString;
            [self.navigationController pushViewController:noDocumentVC animated:YES];
        }
    }];
}

- (void)initWithCustomView {
    UIView *topView = [[UIView alloc] init];
    topView.backgroundColor = [UIColor clearColor];
    topView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:topView];
    [topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(KMainW, 64));
        make.top.mas_equalTo(self.view.mas_top);
    }];
    
    UIImage *backImage = [UIImage imageNamed:@"scan_btn_back"];
    UIImage *lightImage = [UIImage imageNamed:@"scan_btn_flashlight"];
    CGFloat backTitleWidth = kgetContentMaxWidth(@"返回", 15);
    CGFloat lightTitleWidth = kgetContentMaxWidth(@"打开", 15);

    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    backButton.backgroundColor = [UIColor clearColor];
    [backButton addTarget:self action:@selector(backButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    backButton.translatesAutoresizingMaskIntoConstraints = NO;
    [topView addSubview:backButton];
    [backButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(28 + backImage.size.width + backTitleWidth, 40));
        make.bottom.mas_equalTo(topView.mas_bottom);
        make.left.mas_equalTo(topView.mas_left);
    }];
    
    UIButton *openLightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    openLightButton.backgroundColor = [UIColor clearColor];
    [openLightButton addTarget:self action:@selector(openLightButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    openLightButton.translatesAutoresizingMaskIntoConstraints = NO;
    [topView addSubview:openLightButton];
    [openLightButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(28 + lightImage.size.width + lightTitleWidth, 40));
        make.bottom.mas_equalTo(topView.mas_bottom);
        make.right.mas_equalTo(topView.mas_right);
    }];
    
    [self initWithButton:backButton leftImage:backImage rightTitle:@"返回"];
    [self initWithButton:openLightButton leftImage:lightImage rightTitle:@"打开"];

}

- (void)initWithButton:(UIButton *)button leftImage:(UIImage *)leftImage rightTitle:(NSString *)rightTitle {
    UIImageView *leftImageView = [[UIImageView alloc] initWithImage:leftImage];
    leftImageView.backgroundColor = [UIColor clearColor];
    leftImageView.translatesAutoresizingMaskIntoConstraints = NO;
    [button addSubview:leftImageView];
    [leftImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(leftImage.size.width, leftImage.size.height));
        make.left.mas_equalTo(button.mas_left).with.mas_offset(12);
        make.centerY.mas_equalTo(button.mas_centerY);
    }];
    
    UILabel *rightLabel = [[UILabel alloc] init];
    rightLabel.backgroundColor = [UIColor clearColor];
    rightLabel.text = rightTitle;
    rightLabel.textColor = kColor_1;
    rightLabel.textAlignment = NSTextAlignmentLeft;
    rightLabel.font = [UIFont systemFontOfSize:15.f];
    rightLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [button addSubview:rightLabel];
    [rightLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kgetContentMaxWidth(rightTitle, 15) + 1, 30));
        make.left.mas_equalTo(leftImageView.mas_right).with.mas_offset(4);
        make.centerY.mas_equalTo(button.mas_centerY);
    }];
}

- (void)backButtonClick:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

/**
 *  用到了  NSClassFromString(NSString *aClassName) 解释一下：
 *  FOUNDATION_EXPORT Class __nullable NSClassFromString(NSString *aClassName); 这是Xcode上的源码
    如果你要获取的类不存在，则会返回一个nil对象，程序不会崩溃，适用于进行你不确定类的初始化。
 *  NSClassFromString的好处是：
    1.弱化链接，不会把没有的框架也链接到程序中。
    2.不需要使用import,因为类是动态加载的，只要存在就可以加载。因此如果你的类中没有某个头文件定义，而你确信这个类是可以用的，那么可以用这个方法。
 **/
- (void)openLightButtonClick:(id)sender {
    Class captureDeviceClass = NSClassFromString(@"AVCaptureDevice");
    if (captureDeviceClass != nil) {
        AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
        // 判断是否有闪光灯
        if ([device hasTorch]) {
            // 请求独占访问硬件设备
            [device lockForConfiguration:nil];
            if (self.isOpenLight) {
                self.isOpenLight = NO;
                [device setTorchMode:AVCaptureTorchModeOff];
            } else {
                self.isOpenLight = YES;
                [device setTorchMode:AVCaptureTorchModeOn];
            }
            // 请求解除独占访问硬件设备
            [device unlockForConfiguration];
        }
    }
}
@end
