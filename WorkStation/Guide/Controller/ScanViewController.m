//
//  ScanViewController.m
//  WorkStation
//
//  Created by 薛焱 on 16/5/6.
//  Copyright © 2016年 薛焱. All rights reserved.
//

#import "ScanViewController.h"
#import "PlateRecognize.h"

@interface ScanViewController ()

@property (weak, nonatomic) IBOutlet UIView *scanView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *scanLineTopMargin;
@property (weak, nonatomic) IBOutlet UIButton *scanBtn;
@property (strong, nonatomic) AVCaptureSession *captureSession;
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
    
    
}

- (IBAction)captureImageBtnAction:(UIButton *)sender {
    [self captureImage:^(BOOL finished, UIImage *captureImage) {
        if (finished) {
            
            UIImage *coimage = [self fixOrientation:captureImage];
            UIImageView *image1 = [[UIImageView alloc]initWithImage:coimage];
            image1.frame = CGRectMake(10, 300, 200, 50);
            [self.view addSubview:image1];
            NSMutableArray *images = [NSMutableArray array];
            NSArray *resultArray = [[PlateRecognize sharedPlateRecognize] recognizeFromImage:coimage outImages:images];
            
            if (resultArray.count > 0) {
                UIImageView *image = [[UIImageView alloc]initWithImage:images[0]];
                image.frame = CGRectMake(10, 10, 200, 50);
                [self.view addSubview:image];
                UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"车牌号是：" preferredStyle:(UIAlertControllerStyleAlert)];
                UIAlertAction *action = [UIAlertAction actionWithTitle:@"取消" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
                    [_captureSession startRunning];
                    [self dismissViewControllerAnimated:YES completion:nil];
                }];
                [alert addAction:action];
                UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action1) {
                    [self dismissViewControllerAnimated:YES completion:nil];
                }];
                [alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
                    textField.text = resultArray[0];
                    textField.borderStyle = UITextBorderStyleNone;
                }];
                [alert addAction:action1];
                [self presentViewController:alert animated:YES completion:nil];
            }else{
                
            }
        }
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
    AVCaptureVideoPreviewLayer *previewLayer = [AVCaptureVideoPreviewLayer layerWithSession:_captureSession];
    previewLayer.frame = self.view.bounds;
    previewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
    
    [self.view.layer insertSublayer:previewLayer atIndex:0];
    
    if (_captureSession.inputs.count != 0) {
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
    AVCaptureDeviceInput  * captureDeviceInput = [[AVCaptureDeviceInput alloc]initWithDevice:device error:nil];
    
    if (captureDeviceInput) {
        [_captureSession addInput:captureDeviceInput];
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
    AVCaptureStillImageOutput *captureOutput = [[AVCaptureStillImageOutput alloc] init];
    captureOutput.outputSettings = [NSDictionary dictionaryWithObjectsAndKeys: AVVideoCodecJPEG, AVVideoCodecKey, nil];
    [_captureSession addOutput:captureOutput];
}


- (void)captureImage:(void (^)(BOOL finished, UIImage *captureImage))cameraFinished
{
    //获取连接
    __block AVCaptureConnection * videoConnection = nil;
    [[_captureSession.outputs.lastObject connections] enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
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
        [_captureSession.outputs.lastObject captureStillImageAsynchronouslyFromConnection:videoConnection completionHandler:^(CMSampleBufferRef imageDataSampleBuffer, NSError *error) {
            
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

- (UIImage *)fixOrientation:(UIImage *)aImage {
    // No-op if the orientation is already correct
    if (aImage.imageOrientation == UIImageOrientationUp)
        return aImage;
    
    // We need to calculate the proper transformation to make the image upright.
    // We do it in 2 steps: Rotate if Left/Right/Down, and then flip if Mirrored.
    CGAffineTransform transform = CGAffineTransformIdentity;
    
    switch (aImage.imageOrientation) {
        case UIImageOrientationDown:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.width, aImage.size.height);
            transform = CGAffineTransformRotate(transform, M_PI);
            break;
            
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.width, 0);
            transform = CGAffineTransformRotate(transform, M_PI_2);
            break;
            
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, 0, aImage.size.height);
            transform = CGAffineTransformRotate(transform, -M_PI_2);
            break;
        default:
            break;
    }
    
    switch (aImage.imageOrientation) {
        case UIImageOrientationUpMirrored:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.width, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
            
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.height, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
        default:
            break;
    }
    
    // Now we draw the underlying CGImage into a new context, applying the transform
    // calculated above.
    CGContextRef ctx = CGBitmapContextCreate(NULL, aImage.size.width, aImage.size.height,
                                             CGImageGetBitsPerComponent(aImage.CGImage), 0,
                                             CGImageGetColorSpace(aImage.CGImage),
                                             CGImageGetBitmapInfo(aImage.CGImage));
    CGContextConcatCTM(ctx, transform);
    switch (aImage.imageOrientation) {
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            // Grr...
            CGContextDrawImage(ctx, CGRectMake(0,0,aImage.size.height,aImage.size.width), aImage.CGImage);
            break;
            
        default:
            CGContextDrawImage(ctx, CGRectMake(0,0,aImage.size.width,aImage.size.height), aImage.CGImage);
            break;
    }
    
    // And now we just create a new UIImage from the drawing context
    float a = 720 / CGRectGetWidth([UIScreen mainScreen].bounds);
    float b = 1280 / CGRectGetHeight([UIScreen mainScreen].bounds);
    CGImageRef cgimg = CGBitmapContextCreateImage(ctx);
    CGImageRef imagePartRef=CGImageCreateWithImageInRect(cgimg,CGRectMake((kScreenWidth - 250) / 2 * a,((kScreenHeight - 100 - 64)/2 - 100)*b, (250)*a, (100)*b));
    UIImage*cropImage=[UIImage imageWithCGImage:imagePartRef];
    CGImageRelease(imagePartRef);
    CGContextRelease(ctx);
    CGImageRelease(cgimg);
    return cropImage;
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
