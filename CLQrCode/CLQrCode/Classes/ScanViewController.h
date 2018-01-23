//
//  ScanViewController.h
//  CLQrCode
//
//  Created by Mac on 2018/1/22.
//  Copyright © 2018年 z. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

typedef void(^ScanResultBlock)(NSString *scanResult);


@interface ScanViewController : UIViewController<AVCaptureMetadataOutputObjectsDelegate ,UINavigationControllerDelegate,UIImagePickerControllerDelegate>

@property (nonatomic, copy) ScanResultBlock scanResultBlock;


@end
