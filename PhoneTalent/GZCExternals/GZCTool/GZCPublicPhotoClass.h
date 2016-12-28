//
//  GZCPublicPhotoClass.h
//  PhoneTalent
//
//  Created by cloud on 15/12/5.
//  Copyright (c) 2015年 cloud. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol GZCPublicPhotoClassDelegate <NSObject>
- (void) selectImageFinish :(NSData*) imageData;

@optional
- (void) selectImageError :(NSString*) error;
@end


@interface GZCPublicPhotoClass : NSObject
DECLARE_SINGLETON(GZCPublicPhotoClass);

/**
 *  照相
 *
 *  @param addViewControllerRef 要被添加那个ViewController
 */
- (void)takeButtonDidClick:(UIViewController*) addViewControllerRef;


/**
 *  相册
 *
 *  @param addViewControllerRef 要被添加那个ViewController
 */
- (IBAction)albumButtonDidClick:(UIViewController*) addViewControllerRef;
@property(nonatomic, weak)  id<GZCPublicPhotoClassDelegate>  delegate;

@end
