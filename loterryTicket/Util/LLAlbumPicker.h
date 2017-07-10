//
//  LLAlbumPicker.h
//  loterryTicket
//
//  Created by gleeeli on 2017/7/9.
//  Copyright © 2017年 luoluo. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  获取照片、相册完成的block
 *
 *  @param picker    UIImagePickerController对象
 *  @param mediaInfo 图片信息
 *  @param image     原图， 经过方向旋转
 *  @param imageData 通过image转化而来
 */
typedef void (^ LLImagePickerCompletion)(UIImagePickerController *picker,
NSDictionary *mediaInfo,
UIImage *image,
NSData *imageData);

@interface LLAlbumPicker : NSObject

+ (instancetype)shareImagePicker;

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
                                   allowsEditing:(BOOL)allowsEditing;

- (void)showActionSheetWithPresentViewController:(UIViewController *)presentViewController
                         didFinishWithCompletion:(LLImagePickerCompletion)completion
                              compressionQuality:(CGFloat)compressionQuality;

- (void)showActionSheetWithPresentViewController:(UIViewController *)presentViewController
                         didFinishWithCompletion:(LLImagePickerCompletion)completion
                                   allowsEditing:(BOOL)allowsEditing;

- (void)showActionSheetWithPresentViewController:(UIViewController *)presentViewController
                         didFinishWithCompletion:(LLImagePickerCompletion)completion;

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
                              allowsEditing:(BOOL)allowsEditing;

/**
 *  开启相册
 *
 *  @param presentViewController 传入要显示相册的页面
 *  @param completion            获取相片完成执行的block对象
 *  @param compressionQuality    The quality of the resulting JPEG image, expressed as a value from 0.0 to 1.0. The value 0.0 represents the maximum compression (or lowest quality) while the value 1.0 represents the least compression (or best quality).
 */
- (void)openPhotoLibraryWithPresentViewController:(UIViewController *)presentViewController
                          didFinishWithCompletion:(LLImagePickerCompletion)completion
                               compressionQuality:(CGFloat)compressionQuality
                                    allowsEditing:(BOOL)allowsEditing;


@end
