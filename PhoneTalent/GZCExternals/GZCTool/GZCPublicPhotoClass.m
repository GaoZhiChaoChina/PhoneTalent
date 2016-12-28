//
//  GZCPublicPhotoClass.m
//  PhoneTalent
//
//  Created by cloud on 15/12/5.
//  Copyright (c) 2015年 cloud. All rights reserved.
//

#import "GZCPublicPhotoClass.h"

static const CGFloat kImageShorterEdgeUppderBound = 720;

@interface GZCPublicPhotoClass(){
    __weak  UIViewController * addViewController;
}

@end

@implementation GZCPublicPhotoClass
IMPLEMENT_SINGLETON(GZCPublicPhotoClass);

//照相
- (void)takeButtonDidClick:(UIViewController*) addViewControllerRef{
    
    addViewController=addViewControllerRef;
    
    if ([UIImagePickerController
         isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        
        UIImagePickerController *pickVC = [[UIImagePickerController alloc] init];
        pickVC.sourceType = UIImagePickerControllerSourceTypeCamera;
        pickVC.delegate = self;
        
        
        [addViewControllerRef presentViewController:pickVC animated:YES completion:NULL];
    }
}


//相册
- (IBAction)albumButtonDidClick:(UIViewController*) addViewControllerRef{
    
    addViewController=addViewControllerRef;
    
    UIImagePickerController  * imagePicker= [[UIImagePickerController alloc] init];
    　　 imagePicker.delegate = self;
    imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    　　imagePicker.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    　　imagePicker.allowsEditing = false;
    [addViewControllerRef presentViewController:imagePicker animated:YES completion:NULL];
    
    
}



-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [self processOriginalImages:@[info]];
}


//图片处理
- (void)processOriginalImages:(NSArray*)originalImages
{
    
    [addViewController dismissViewControllerAnimated:YES completion:nil];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        __block BOOL illegalImageSelected = NO;
        
        [originalImages enumerateObjectsWithOptions:NSEnumerationConcurrent usingBlock:^(NSDictionary* dic, NSUInteger idx, BOOL *stop) {
            
            UIImage* image = dic[UIImagePickerControllerOriginalImage];
            NSLog(@"image=%@",image);
            NSLog(@"maximage=%f",MAX(image.size.width, image.size.height));
            NSLog(@"minimage=%f",MIN(image.size.width, image.size.height));
            
            //宽，高比列小于5
            if (MAX(image.size.width, image.size.height) / MIN(image.size.width, image.size.height) <= 5) {
                
                CGSize size = image.size;
                //图片宽高分辨率必须大于720
                if (MIN(image.size.width, image.size.height) > kImageShorterEdgeUppderBound) {
                    
                    if (image.size.width < image.size.height) {
                        
                        size = CGSizeMake(kImageShorterEdgeUppderBound, (kImageShorterEdgeUppderBound / image.size.width) * image.size.height);
                        
                    } else {
                        
                        size = CGSizeMake((kImageShorterEdgeUppderBound / image.size.height) * image.size.width, kImageShorterEdgeUppderBound);
                        
                    }
                }
                
                //得到不同方向的图片
                image = [image fixOrientationWithSize:size];
                NSData* data = UIImageJPEGRepresentation(image, 0.8);
                
                if ([_delegate respondsToSelector:@selector(selectImageFinish:)]&&_delegate) {
                    
                    [_delegate   selectImageFinish:data];
                }
                
                
                
            } else {
                
                illegalImageSelected = YES;
            }
        }];
        
        
        dispatch_sync(dispatch_get_main_queue(), ^{
            
            if (illegalImageSelected) {
                
                UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"为保证图片浏览体验，请上传高：宽小于等于5的图片" message:nil delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
                [alertView show];
            }
            
            
        });
    });
}

@end
