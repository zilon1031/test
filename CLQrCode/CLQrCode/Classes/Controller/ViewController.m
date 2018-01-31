//
//  ViewController.m
//  CLQrCode
//
//  Created by Mac on 2018/1/22.
//  Copyright © 2018年 z. All rights reserved.
//

#import "ViewController.h"
#import "ScanViewController.h"

@interface ViewController ()

@property (nonatomic, strong) UILabel *scanLabel;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"扫一扫";
    [self initWithCustomView];
}

- (void)initWithCustomView {
    UIButton *scanButton = [UIButton buttonWithType:UIButtonTypeCustom];
    scanButton.translatesAutoresizingMaskIntoConstraints = NO;
    scanButton.backgroundColor = [UIColor whiteColor];
    scanButton.layer.masksToBounds = YES;
    scanButton.layer.cornerRadius = 3;
    scanButton.layer.borderWidth = 1;
    scanButton.layer.borderColor = [UIColor greenColor].CGColor;
    [scanButton setTitle:@" 扫 描 " forState:UIControlStateNormal];
    [scanButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    scanButton.titleLabel.font = [UIFont systemFontOfSize:17];
    [scanButton addTarget:self action:@selector(scanButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:scanButton];
    
    [scanButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(200);
        make.left.mas_equalTo(self.view.mas_left).with.mas_offset(10);
        make.size.mas_equalTo(CGSizeMake(KMainW - 20, 40));
    }];
    
    self.scanLabel = [[UILabel alloc] init];
    self.scanLabel.backgroundColor = [UIColor clearColor];
    self.scanLabel.textColor = [UIColor blackColor];
    self.scanLabel.textAlignment = NSTextAlignmentCenter;
    self.scanLabel.font = [UIFont systemFontOfSize:14.f];
    self.scanLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:self.scanLabel];
    [self.scanLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(KMainW - 20, 30));
        make.top.mas_equalTo(scanButton.mas_bottom).with.mas_offset(20);
    }];
}

- (void)scanButtonClick:(id)sender {
    ScanViewController *scanViewController = [[ScanViewController alloc] init];
    [self.navigationController pushViewController:scanViewController animated:YES];
    weakSelf(self)
    [scanViewController setScanResultBlock:^(NSString *scanResult) {
        strongSelf(self)
        if (![NSString isBlankString:scanResult]) {
            self.scanLabel.text = scanResult;
        }
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
