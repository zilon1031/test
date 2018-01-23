//
//  ScanViewController.m
//  CLQrCode
//
//  Created by Mac on 2018/1/22.
//  Copyright © 2018年 z. All rights reserved.
//

#import "ScanViewController.h"
#import "CLScanHelper.h"

@interface ScanViewController ()

@property (nonatomic, assign) BOOL isOpenLight;

@end

@implementation ScanViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.isOpenLight = NO;
    
    [self initWithCustomView];
    
    [[CLScanHelper sharedInstance] startRunning];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [[CLScanHelper sharedInstance] destructTimer];
}

- (void)initWithCustomView {
    CGSize scanSize = CGSizeMake(KMainW *4/5, KMainW *4/5);
    CGRect scanRect = CGRectMake((KMainW - scanSize.width)/2, 150, scanSize.width, scanSize.height);
//    UIView *scanView = [[UIView alloc] init];
//    scanView.layer.borderColor = [UIColor blueColor].CGColor;
//    scanView.layer.borderWidth = 1;
    
    weakSelf(self)
    [[CLScanHelper sharedInstance] showLayer:self.view];
    [[CLScanHelper sharedInstance] initScanningRect:scanRect];
    [[CLScanHelper sharedInstance] setScanBlock:^(NSString *resultString) {
        strongSelf(self)
        NSLog(@"scanResult -- %@", resultString);
        [[CLScanHelper sharedInstance] stopRunning];
        
        self.scanResultBlock(resultString);
        [self backButtonClick:nil];
    }];
    
    UIView *bottomView = [[UIView alloc] init];
    bottomView.backgroundColor = [UIColor whiteColor];
    bottomView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:bottomView];
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(KMainW, 40));
        make.bottom.mas_equalTo(self.view.mas_bottom);
    }];
    
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    backButton.backgroundColor = [UIColor clearColor];
    [backButton addTarget:self action:@selector(backButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    backButton.translatesAutoresizingMaskIntoConstraints = NO;
    [bottomView addSubview:backButton];
    [backButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(100, 40));
        make.top.mas_equalTo(bottomView.mas_top);
        make.left.mas_equalTo(bottomView.mas_left).with.mas_offset(10);
    }];
    
    UIButton *openLightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    openLightButton.backgroundColor = [UIColor clearColor];
    [openLightButton addTarget:self action:@selector(openLightButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    openLightButton.translatesAutoresizingMaskIntoConstraints = NO;
    [bottomView addSubview:openLightButton];
    [openLightButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(100, 40));
        make.top.mas_equalTo(bottomView.mas_top);
        make.right.mas_equalTo(bottomView.mas_right).with.mas_offset(-10);
    }];
    
    UIImage *backImage = [UIImage imageNamed:@"icon_back_green"];
    UIImage *lightImage = [UIImage imageNamed:@"icon_back_green"];
    
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
        make.left.mas_equalTo(button.mas_left);
        make.centerY.mas_equalTo(button.mas_centerY);
    }];
    
    UILabel *rightLabel = [[UILabel alloc] init];
    rightLabel.backgroundColor = [UIColor clearColor];
    rightLabel.text = rightTitle;
    rightLabel.textColor = [UIColor darkGrayColor];
    rightLabel.textAlignment = NSTextAlignmentLeft;
    rightLabel.font = [UIFont systemFontOfSize:15.f];
    rightLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [button addSubview:rightLabel];
    [rightLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(90 - leftImage.size.width, 30));
        make.left.mas_equalTo(leftImageView.mas_right).with.mas_offset(5);
        make.centerY.mas_equalTo(button.mas_centerY);
    }];
}

- (void)backButtonClick:(id)sender {
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
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
