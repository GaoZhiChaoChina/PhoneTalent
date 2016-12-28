//
//  FunnyLimitInput.h
//  funny
//
//  Created by gaozhichao on 15/11/19.
//  Copyright © 2015年 xiexin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>


#define PROPERTY_NAME @"limit"

#define DECLARE_PROPERTY(className) \
@interface className (Limit) @end

DECLARE_PROPERTY(UITextField)
DECLARE_PROPERTY(UITextView)
@interface FunnyLimitInput : NSObject
@property(nonatomic, assign) BOOL enableLimitCount;

+(FunnyLimitInput *) sharedInstance;


@end
