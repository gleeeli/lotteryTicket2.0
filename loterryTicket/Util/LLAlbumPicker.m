//
//  LLAlbumPicker.m
//  loterryTicket
//
//  Created by gleeeli on 2017/7/9.
//  Copyright © 2017年 luoluo. All rights reserved.
//

#import "LLAlbumPicker.h"
#import <AVFoundation/AVFoundation.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import <MobileCoreServices/MobileCoreServices.h>
#import "LLHelp.h"

@interface LLAlbumPicker()<UINavigationControllerDelegate,
UIImagePickerControllerDelegate,
UIActionSheetDelegate,
UIAlertViewDelegate>
@property (nonatomic, strong)UIViewController *presentViewController;
@property (nonatomic, strong)LLImagePickerCompletion completion;
@property (nonatomic, assign)CGFloat compressionQuality;
@property (nonatomic, assign) BOOL allowsEditing;
@end
@implementation LLAlbumPicker

+ (instancetype)shareImagePicker{
    static LLAlbumPicker *shareImagePicker;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shareImagePicker = [[LLAlbumPicker alloc] init];
    });
    return shareImagePicker;
}

/**
 *  显示ActionSheet， “拍照”、“从相册中选取”
 *
 *  @param presentViewController 传入要显示相机的页面
 *  @param completion            获取相片完成执行的block对象
 *  @param compressionQuality    The quality of the resulting JPEG image, expressed as a value from 0.0 to 1.0. The value 0.0 represents the maximum compression (or lowest quality) while the value 1.0 represents the least compression (or best quality).
 */
- (void)showActionSheetWithPresentViewController:(UIViewController *)presentViewController
                         didFinishWithCompletion:(LLImagePickerCompletion)completion
                              compressionQuality:(CGFloat)compressionQuality
                                   allowsEditing:(BOOL)allowsEditing{
    self.completion = completion;
    self.compressionQuality = compressionQuality;
    self.presentViewController = presentViewController;
    self.allowsEditing = allowsEditing;
    
    //修改照片
    UIActionSheet *choiceSheet = [[UIActionSheet alloc] initWithTitle:nil
                                                             delegate:self
                                                    cancelButtonTitle:@"取消"
                                               destructiveButtonTitle:nil
                                                    otherButtonTitles:@"拍照", @"从相册中选取", nil];
    choiceSheet.tag = 3333;
    [choiceSheet showInView:presentViewController.view];
}

- (void)showActionSheetWithPresentViewController:(UIViewController *)presentViewController
                         didFinishWithCompletion:(LLImagePickerCompletion)completion
                              compressionQuality:(CGFloat)compressionQuality{
    [self showActionSheetWithPresentViewController:presentViewController
                           didFinishWithCompletion:completion
                                compressionQuality:compressionQuality
                                     allowsEditing:YES];
}

- (void)showActionSheetWithPresentViewController:(UIViewController *)presentViewController
                         didFinishWithCompletion:(LLImagePickerCompletion)completion
                                   allowsEditing:(BOOL)allowsEditing{
    [self showActionSheetWithPresentViewController:presentViewController
                           didFinishWithCompletion:completion
                                compressionQuality:0
                                     allowsEditing:allowsEditing];
}

- (void)showActionSheetWithPresentViewController:(UIViewController *)presentViewController
                         didFinishWithCompletion:(LLImagePickerCompletion)completion{
    [self showActionSheetWithPresentViewController:presentViewController
                           didFinishWithCompletion:completion
                                compressionQuality:0
                                     allowsEditing:YES];
}

#pragma mark
#pragma mark - UIActionSheetDelegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 0) {
        [self openCameraWithPresentViewController:self.presentViewController
                          didFinishWithCompletion:self.completion
                               compressionQuality:self.compressionQuality
                                    allowsEditing:self.allowsEditing];
    }
    else if (buttonIndex == 1) {
        [self openPhotoLibraryWithPresentViewController:self.presentViewController
                                didFinishWithCompletion:self.completion
                                     compressionQuality:self.compressionQuality
                                          allowsEditing:self.allowsEditing];
    }
}

/**
 *  开启相机
 *
 *  @param presentViewController 传入要显示相机的页面
 *  @param completion            获取相片完成执行的block对象
 *  @param compressionQuality    The quality of the resulting JPEG image, expressed as a value from 0.0 to 1.0. The value 0.0 represents the maximum compression (or lowest quality) while the value 1.0 represents the least compression (or best quality).
 */
- (void)openCameraWithPresentViewController:(UIViewController *)presentViewController
                    didFinishWithCompletion:(LLImagePickerCompletion)completion
                         compressionQuality:(CGFloat)compressionQuality
                              allowsEditing:(BOOL)allowsEditing{
    
    self.completion = completion;
    self.compressionQuality = compressionQuality;
    self.presentViewController = presentViewController;
    self.allowsEditing = allowsEditing;
    
    // 拍照
    if ([self isCameraAvailable] && [self doesCameraSupportTakingPhotos]) {
        //检查权限
        NSString *mediaType = AVMediaTypeVideo;
        AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:mediaType];
        if(authStatus == ALAuthorizationStatusRestricted || authStatus == ALAuthorizationStatusDenied){
            UIAlertView *cameraAlertView = [[UIAlertView alloc] initWithTitle:@"" message:@"支持相机请前往\n系统设置-隐私-相机\n进行修改权限" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"去设置", nil];
            cameraAlertView.tag = 22;
            [cameraAlertView show];
            return;
        }
        else
        {
            GCDMain(^{
                UIImagePickerController *controller = [[UIImagePickerController alloc] init];
                controller.sourceType = UIImagePickerControllerSourceTypeCamera;
                if ([self isFrontCameraAvailable]) {
                    controller.cameraDevice = UIImagePickerControllerCameraDeviceFront;
                }
                NSMutableArray *mediaTypes = [[NSMutableArray alloc] init];
                [mediaTypes addObject:(__bridge NSString *)kUTTypeImage];
                controller.mediaTypes = mediaTypes;
                controller.delegate = self;
                controller.allowsEditing = self.allowsEditing;
                
                //跳转到相机
                [presentViewController presentViewController:controller animated:YES completion:nil];
            });
        }
        
        
    }
    
}

- (void)openPhotoLibraryWithPresentViewController:(UIViewController *)presentViewController
                          didFinishWithCompletion:(LLImagePickerCompletion)completion
                               compressionQuality:(CGFloat)compressionQuality
                                    allowsEditing:(BOOL)allowsEditing{
    self.completion = completion;
    self.compressionQuality = compressionQuality;
    self.presentViewController = presentViewController;
    self.allowsEditing = allowsEditing;
    
    // 从相册中选取
    if ([self isPhotoLibraryAvailable]) {
        
        //检查权限  AVAuthorizationStatus authStatus = [ALAssetsLibrary authorizationStatus];
        AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
        if(authStatus == ALAuthorizationStatusRestricted || authStatus == ALAuthorizationStatusDenied){
            UIAlertView *photoAlbumAlertView = [[UIAlertView alloc] initWithTitle:@"" message:@"支持相机请前往\n系统设置-隐私-相册\n进行修改权限" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"去设置", nil];
            photoAlbumAlertView.tag = 33;
            [photoAlbumAlertView show];
            return;
        }
        else
        {
            GCDMain(^{
                
                UIImagePickerController *pickerController = [[UIImagePickerController alloc] init];
                pickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
                NSMutableArray *mediaTypesArray = [[NSMutableArray alloc] init];
                [mediaTypesArray addObject:(__bridge NSString *)kUTTypeImage];
                pickerController.mediaTypes = mediaTypesArray;
                pickerController.delegate = self;
                pickerController.allowsEditing = self.allowsEditing;
                
                //跳转到相册
                [presentViewController presentViewController:pickerController animated:YES completion:nil];
            });
        }
        
    }
}


#pragma mark
#pragma mark - UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 0) {
        return;
    }
    if (alertView.tag == 22 || alertView.tag == 33) {
        NSURL *url;
        if (iOS(8.0)) {
            url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
        }
        else{
            url = [NSURL URLWithString:@"prefs:"];
        }
        [[UIApplication sharedApplication] openURL:url];
    }
}
#pragma mark - UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    [picker dismissViewControllerAnimated:YES completion:^() {
        UIImage *image;
        if (self.allowsEditing) {
            image = [info objectForKey:UIImagePickerControllerEditedImage];
        }
        else{
            image = [info objectForKey:UIImagePickerControllerOriginalImage];
        }
        image = [LLHelp fixOrientation:image];
        
        NSData * imageData;
        if (self.compressionQuality == 0) {
            imageData = [LLHelp resetSizeOfImageData:image maxSize:100];
        }else{
            imageData = UIImageJPEGRepresentation(image, self.compressionQuality);
        }
        self.completion(picker, info, image, imageData);
    }];
}


#pragma mark camera utility
- (BOOL) isCameraAvailable{//相机
    return [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera];
}

- (BOOL) isRearCameraAvailable{
    return [UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceRear];
}

- (BOOL) isFrontCameraAvailable {
    return [UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceFront];
}

- (BOOL) doesCameraSupportTakingPhotos {
    return [self cameraSupportsMedia:(__bridge NSString *)kUTTypeImage sourceType:UIImagePickerControllerSourceTypeCamera];
}

- (BOOL) isPhotoLibraryAvailable{
    return [UIImagePickerController isSourceTypeAvailable:
            UIImagePickerControllerSourceTypePhotoLibrary];
}
- (BOOL) canUserPickVideosFromPhotoLibrary{
    return [self
            cameraSupportsMedia:(__bridge NSString *)kUTTypeMovie sourceType:UIImagePickerControllerSourceTypePhotoLibrary];
}
- (BOOL) canUserPickPhotosFromPhotoLibrary{
    return [self
            cameraSupportsMedia:(__bridge NSString *)kUTTypeImage sourceType:UIImagePickerControllerSourceTypePhotoLibrary];
}

- (BOOL) cameraSupportsMedia:(NSString *)paramMediaType sourceType:(UIImagePickerControllerSourceType)paramSourceType{
    __block BOOL result = NO;
    if ([paramMediaType length] == 0) {
        return NO;
    }
    NSArray *availableMediaTypes = [UIImagePickerController availableMediaTypesForSourceType:paramSourceType];
    [availableMediaTypes enumerateObjectsUsingBlock: ^(id obj, NSUInteger idx, BOOL *stop) {
        NSString *mediaType = (NSString *)obj;
        if ([mediaType isEqualToString:paramMediaType]){
            result = YES;
            *stop= YES;
        }
    }];
    return result;
}

@end
