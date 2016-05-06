//
//  ScanViewController.m
//  WorkStation
//
//  Created by 薛焱 on 16/5/6.
//  Copyright © 2016年 薛焱. All rights reserved.
//

#import "ScanViewController.h"

@interface ScanViewController ()

@property (weak, nonatomic) IBOutlet UIView *scanView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *scanLineTopMargin;
@property (strong, nonatomic) AVCaptureSession *captureSession;
@property (strong, nonatomic) AVCaptureVideoPreviewLayer *previewLayer;
@property (strong, nonatomic) AVCaptureDeviceInput  * captureDeviceInput;
@property (strong, nonatomic) AVCaptureStillImageOutput *captureOutput;
@property (assign, nonatomic) AVCaptureDevicePosition currentDevicePositon;

@end

@implementation ScanViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    //    [self.navigationController setNavigationBarHidden:YES animated:YES];
    self.tabBarController.tabBar.hidden = YES;
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self setScanLine];
    [NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(setScanLine) userInfo:nil repeats:YES];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    //    [self.navigationController setNavigationBarHidden:NO animated:YES];
    self.tabBarController.tabBar.hidden = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self showCamera];
    [self captureImage:^(BOOL finished, UIImage *captureImage) {
        
    }];
}

- (void)setScanLine{
    _scanLineTopMargin.constant = 98;
    [UIView animateWithDuration:1 animations:^{
        
        [self.scanView layoutIfNeeded];
    } completion:^(BOOL finished) {
        self.scanLineTopMargin.constant = 0;
        [UIView animateWithDuration:1 animations:^{
            [self.scanView layoutIfNeeded];
        }];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)showCamera {
    _captureSession = [[AVCaptureSession alloc] init];
    
    // 设置采集的大小
    _captureSession.sessionPreset = AVCaptureSessionPreset1280x720;
    
    //添加 input - 输入设备 -  配置 device
    [self addCaputureDeviceInput];
    
    //添加 output - 输出设备 - 配置 device
    [self addCaputureDeviceOutput];
    
    //添加 添加到视图中 --
    _previewLayer = [AVCaptureVideoPreviewLayer layerWithSession:_captureSession];
    _previewLayer.frame = self.view.bounds;
    _previewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
    
    [self.view.layer insertSublayer:_previewLayer atIndex:0];
    
    if (_captureDeviceInput) {
        [_captureSession startRunning];
    }
}

// input --
- (void)addCaputureDeviceInput {
    NSArray * devices = [AVCaptureDevice devicesWithMediaType:AVMediaTypeVideo];
    
    AVCaptureDevice *device;
    for (AVCaptureDevice *dev in devices) {
        if (dev.position == AVCaptureDevicePositionBack) {
            device = dev;
        }
    }
    _captureDeviceInput = [[AVCaptureDeviceInput alloc]initWithDevice:device error:nil];
    
    if (_captureDeviceInput) {
        [_captureSession addInput:_captureDeviceInput];
    } else {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"相机打开失败" preferredStyle:(UIAlertControllerStyleAlert)];
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
            [self dismissViewControllerAnimated:YES completion:nil];
            [self.navigationController popViewControllerAnimated:YES];
        }];
        [alert addAction:action];
        [self presentViewController:alert animated:YES completion:nil];
    }
}

// output --
- (void)addCaputureDeviceOutput {
    _captureOutput = [[AVCaptureStillImageOutput alloc] init];
    _captureOutput.outputSettings = [NSDictionary dictionaryWithObjectsAndKeys: AVVideoCodecJPEG, AVVideoCodecKey, nil];
    [_captureSession addOutput:_captureOutput];
}


- (void)captureImage:(void (^)(BOOL finished, UIImage *captureImage))cameraFinished
{
    //获取连接
    __block AVCaptureConnection * videoConnection = nil;
    
    [_captureOutput.connections enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        AVCaptureConnection * connection = (AVCaptureConnection *)obj;
        
        [[connection inputPorts] enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            AVCaptureInputPort * port = (AVCaptureInputPort *)obj;
            
            if ([[port mediaType] isEqualToString:AVMediaTypeVideo]) {
                videoConnection = connection;
                *stop = YES;
            }
            
        }];
        
        if (videoConnection) {
            *stop = YES;
        }
        
    }];
    
    __block UIImage * image = nil;
    
    if (videoConnection)
    {
        //  -- 获取图片 - 为一个异步操作 --
        [_captureOutput captureStillImageAsynchronouslyFromConnection:videoConnection completionHandler:^(CMSampleBufferRef imageDataSampleBuffer, NSError *error) {
            
            [_captureSession stopRunning];;
            
            @autoreleasepool {
                NSData * imageData = [AVCaptureStillImageOutput jpegStillImageNSDataRepresentation:imageDataSampleBuffer];
                
                image = [UIImage imageWithData:imageData];
                
                if (cameraFinished) {
                    cameraFinished(YES,image);
                }
                
            }
        }];
    }
    
}
/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
