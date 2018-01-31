//
//  CLScanHelper.m
//  CLQrCode
//
//  Created by Mac on 2018/1/22.
//  Copyright © 2018年 z. All rights reserved.
//

#import "CLScanHelper.h"
#import <AVFoundation/AVFoundation.h>

@interface CLScanHelper() <AVCaptureMetadataOutputObjectsDelegate>

@property (nonatomic, strong) AVCaptureSession *session;            //输入输出的中间桥梁
@property (nonatomic, strong) AVCaptureVideoPreviewLayer *layer;    //捕捉视频预览层
@property (nonatomic, strong) AVCaptureMetadataOutput *output;      //捕获元数据输出
@property (nonatomic, strong) AVCaptureDeviceInput *input;          //采集设备输入
@property (nonatomic, strong) UIView *superView;                    //图层父类

@property (nonatomic, assign) BOOL isUpOrDown;                     //扫描线向上或向下
@property (nonatomic, assign) NSInteger num;                       //
@property (nonatomic, assign) NSTimer *timer;
@property (nonatomic, assign) CGRect scanRect;                       //扫描区域
@property (nonatomic, strong) UIImageView *lineImageView;           //扫描线

@end

@implementation CLScanHelper

+ (instancetype)sharedInstance {
    static id sharedInstance = nil;
    static dispatch_once_t onceToken; dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

//初始化-单例，只调用一次
- (id)init {
    self = [super init];
    if (self) {
        //初始化链接对象
        self.session = [[AVCaptureSession alloc] init];
        //高质量采集率
        [self.session setSessionPreset:AVCaptureSessionPresetHigh];
        
        //FIXME：避免模拟器运行崩溃
        if (!TARGET_IPHONE_SIMULATOR) {
            //获取摄像设备
            AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
            //创建输入流
            self.input = [AVCaptureDeviceInput deviceInputWithDevice:device error:nil];
            [self.session addInput:self.input];
            
            //创建输出流
            self.output = [[AVCaptureMetadataOutput alloc] init];
            //设置代理，在主线程中刷新
            [self.output setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
            [self.session addOutput:self.output];
            
            //设置扫码支持编码格式（如下设置条形码和二维码兼容）
            self.output.metadataObjectTypes = @[AVMetadataObjectTypeQRCode,
                                                AVMetadataObjectTypeEAN13Code,
                                                AVMetadataObjectTypeEAN8Code,
                                                AVMetadataObjectTypeCode128Code];
            //要在addOutput之后，否则iOS 10会崩溃
            self.layer = [AVCaptureVideoPreviewLayer layerWithSession:self.session];
            self.layer.videoGravity = AVLayerVideoGravityResizeAspectFill;
        }
    }

    return self;
}


#pragma mark - Methods
#pragma mark Start Capture
- (void)startRunning {
    if (!TARGET_IPHONE_SIMULATOR) {
        [self.session startRunning];
    }
}

#pragma mark Stop Capture
- (void)stopRunning {
    if (!TARGET_IPHONE_SIMULATOR) {
        [self.session stopRunning];
    }
}

#pragma mark - AVCaptureMetadataOutputObjects Delegate
- (void)captureOutput:(AVCaptureOutput *)output didOutputMetadataObjects:(NSArray<__kindof AVMetadataObject *> *)metadataObjects fromConnection:(AVCaptureConnection *)connection {
    if (metadataObjects.count > 0) {
        AVMetadataMachineReadableCodeObject *metadataObject = [metadataObjects objectAtIndex:0];
        if (self.scanBlock) {
            if ([metadataObject.type containsString:@"QRCode"]) {
                self.type = ScanType_QRCode;
            } else {
                self.type = ScanType_BarCode;
            }
            self.scanBlock(metadataObject.stringValue, self.type);
        }
        //输出扫描字符串
        NSLog(@"%@", metadataObject.stringValue);
        NSLog(@"type = %@", metadataObject.type);
    }
}

/**
 * @brief 设置扫描范围区域 CGRectMake(y的起点/屏幕的高，x的起点/屏幕的宽，扫描的区域的高/屏幕的高，扫描的区域的宽/屏幕的宽)
 *
 * @param scanRect 扫描范围.
 *
 */
- (void)initScanningRect:(CGRect)scanRect {
    CGFloat x = scanRect.origin.y / self.layer.frame.size.height;
    CGFloat y = scanRect.origin.x / self.layer.frame.size.width;
    CGFloat weight = scanRect.size.height / self.layer.frame.size.height;
    CGFloat height = scanRect.size.width / self.layer.frame.size.width;
    
    self.output.rectOfInterest = CGRectMake(x, y, weight, height);
    [self initWithScanView:scanRect];
}

/**
 * @brief 显示图层
 *
 * @param superView 需要在哪个view显示
 *
 */
- (void)showLayer:(UIView *)superView {
    self.superView = superView;
    self.layer.frame = self.superView.frame;
    [self.superView.layer insertSublayer:self.layer atIndex:0];
}

- (void)initWithScanView:(CGRect)scanRect{
    UILabel *upTipLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, KMainH - 233, KMainW - 20, 20)];
    upTipLabel.backgroundColor = [UIColor clearColor];
    upTipLabel.text = @"将商品条形码、用户的二维码";
    upTipLabel.textColor = kColor_9;
    upTipLabel.textAlignment = NSTextAlignmentCenter;
    upTipLabel.font = [UIFont systemFontOfSize:15.f];
    [self.superView addSubview:upTipLabel];
    
    UILabel *downTipLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, upTipLabel.frame.origin.y + upTipLabel.frame.size.height, KMainW - 20, 20)];
    downTipLabel.backgroundColor = [UIColor clearColor];
    downTipLabel.text = @"放入框内，即可自动扫描";
    downTipLabel.textColor = kColor_9;
    downTipLabel.textAlignment = NSTextAlignmentCenter;
    downTipLabel.font = [UIFont systemFontOfSize:15.f];
    [self.superView addSubview:downTipLabel];
    
    UIImage *scanBoxImage = [UIImage imageNamed:@"scan_img_frame"];
    UIImageView *scanBoxImageView = [[UIImageView alloc] init];
    scanBoxImageView.image = scanBoxImage;
    scanBoxImageView.backgroundColor = [UIColor clearColor];
    
    self.scanRect = scanRect;

    self.isUpOrDown = NO;
    self.num = 0;
    UIImage *lineImage = [UIImage imageNamed:@"scan_img_line"];
    self.lineImageView = [[UIImageView alloc] initWithFrame:scanRect];
    self.lineImageView.image = lineImage;
    [self.superView addSubview:self.lineImageView];
    
    self.timer = [NSTimer scheduledTimerWithTimeInterval:.02 target:self selector:@selector(animation) userInfo:nil repeats:YES];
    
    self.scanView = scanBoxImageView;
    if (self.scanView) {
        self.scanView.frame = scanRect;
        if (self.superView) {
            [self.superView addSubview:self.scanView];
        }
    }
    
}

-(void)animation{
    NSInteger maxHeight = self.scanRect.size.height;
    if (self.isUpOrDown == NO) {
        self.num ++;
        self.lineImageView.frame = CGRectMake(self.scanRect.origin.x, self.scanRect.origin.y+2*self.num, self.scanRect.size.width, 2);
        if (2*self.num >= maxHeight) {
            self.isUpOrDown = YES;
        }
    } else {
        self.num --;
        self.lineImageView.frame = CGRectMake(self.scanRect.origin.x, self.scanRect.origin.y+2*self.num, self.scanRect.size.width, 2);
        if (self.num == 0) {
            self.isUpOrDown = NO;
        }
    }
}

// 销毁扫描线条移动计时器
- (void)destructTimer {
    [self.timer invalidate];
    self.timer = nil;
}
@end
