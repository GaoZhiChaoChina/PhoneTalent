//
//  GZCUtility.m
//  PhoneTalent
//
//  Created by cloud on 15/12/5.
//  Copyright (c) 2015年 cloud. All rights reserved.
//

#import "GZCUtility.h"
#import <Accelerate/Accelerate.h>
#import <sys/socket.h> // Per msqr
#import <sys/sysctl.h>
#import <net/if.h>
#import <net/if_dl.h>
#import <CommonCrypto/CommonDigest.h>
#define VersionLaunchedKey [VERSION stringByAppendingString:@"_launched_"]

@implementation GZCUtility

IMPLEMENT_SINGLETON(GZCUtility)

+ (void)storyBoradAutoLay:(UIView *)allView
{
    for (UIView *temp in allView.subviews) {
        temp.frame = CGRectMake1(temp.frame.origin.x, temp.frame.origin.y, temp.frame.size.width, temp.frame.size.height);
        for (UIView *temp1 in temp.subviews) {
            temp1.frame = CGRectMake1(temp1.frame.origin.x, temp1.frame.origin.y, temp1.frame.size.width, temp1.frame.size.height);
        }
    }
}
//修改CGRectMake
CG_INLINE CGRect
CGRectMake1(CGFloat x, CGFloat y, CGFloat width, CGFloat height)
{
//    AppDelegate *myDelegate = (AppDelegate*)[[UIApplication sharedApplication]delegate ];
    CGRect rect;
    rect.origin.x = x * ScreenHeight > 480 ? ScreenWidth/320 : 1.0f; rect.origin.y = y * ScreenHeight > 480 ? ScreenWidth/568 : 1.0f;
    rect.size.width = width * ScreenHeight > 480 ? ScreenWidth/320 : 1.0f; rect.size.height = height * ScreenHeight > 480 ? ScreenWidth/568 : 1.0f;
    return rect;
}


+ (BOOL)isKeywordValid:(NSString*)keyword
{
    NSMutableCharacterSet* characterSet = [NSMutableCharacterSet decimalDigitCharacterSet];
    [characterSet formUnionWithCharacterSet:[NSCharacterSet lowercaseLetterCharacterSet]];
    [characterSet formUnionWithCharacterSet:[NSCharacterSet uppercaseLetterCharacterSet]];
    
    for (NSUInteger i = 0; i < keyword.length; ++i) {
        unichar c = [keyword characterAtIndex:i];
        if (c > 0x4e00 && c < 0x9fff) {
            return YES;
        }
        if ([characterSet characterIsMember:c]) {
            return YES;
        }
    }
    
    return NO;
}

+ (UIColor*)blendedColor:(float)percent1 color1:(UIColor*)color1 color2:(UIColor*)color2
{
    CGFloat r1,g1,b1,a1,r2,g2,b2,a2;
    [color1 getRed:&r1 green:&g1 blue:&b1 alpha:&a1];
    [color2 getRed:&r2 green:&g2 blue:&b2 alpha:&a2];
    UIColor* blendedColor = [UIColor colorWithRed:r2*(1-percent1)+r1*percent1 green:g2*(1-percent1)+g1*percent1 blue:b2*(1-percent1)+b1*percent1 alpha:1.0];
    return blendedColor;
}

+ (UIImage*)blendedImage:(float)percent1 image1:(UIImage*)image1 image2:(UIImage*)image2
{
    CGSize size = CGSizeMake( MAX(image1.size.width, image2.size.width), MAX(image1.size.height, image2.size.height) );
    UIGraphicsBeginImageContextWithOptions(size, NO, 0);
    //    [selectedImage drawInRect:CGRectMake(0, 0, size.width, size.height)];
    //    [image1 drawInRect:CGRectMake(0, 0, size.width, size.height)];
    //    NSLog(@"%f", percent1);
    
    //    [[UIColor whiteColor] setFill];
    CGRect bounds = CGRectMake(0, 0, size.width, size.height);
    //    UIRectFill(bounds);
    [image1 drawInRect:bounds blendMode:kCGBlendModeNormal alpha:percent1];
    [image2 drawInRect:bounds blendMode:kCGBlendModeNormal alpha:1-percent1];
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;
}

+ (void)setVersionLaunchedWithKey:(NSString*)key
{
    NSString* fullKey = [VersionLaunchedKey stringByAppendingString:key];
    if ([GZCUtility versionFirstTimeLaunchWithKey:fullKey]) {
        [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:fullKey];
    }
}

+ (BOOL)versionFirstTimeLaunchWithKey:(NSString*)key
{
    return [[NSUserDefaults standardUserDefaults] objectForKey:[VersionLaunchedKey stringByAppendingString:key]] == nil;
}

+ (void)shakeAnimationForView:(UIView *) view
{
    // 获取到当前的View
    CALayer *viewLayer = view.layer;
    // 获取当前View的位置
    CGPoint position = viewLayer.position;
    // 移动的两个终点位置
    CGPoint x = CGPointMake(position.x, position.y+2);
    CGPoint y = CGPointMake(position.x, position.y-2);
    // 设置动画
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"position"];
    // 设置运动形式
    [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionDefault]];
    // 设置开始位置
    [animation setFromValue:[NSValue valueWithCGPoint:x]];
    // 设置结束位置
    [animation setToValue:[NSValue valueWithCGPoint:y]];
    // 设置自动反转
    [animation setAutoreverses:YES];
    // 设置时间
    [animation setDuration:.4];
    [animation setRemovedOnCompletion:NO];
    // 设置次数
    [animation setRepeatCount:INT_MAX];
    // 添加上动画
    [viewLayer addAnimation:animation forKey:nil];
    animation.delegate=self;
}

/**获取UUID*/
+(NSString *)getUniqueStrByUUID {
    CFUUIDRef uuidRef = CFUUIDCreate(NULL);
    CFStringRef uuidStrRef= CFUUIDCreateString(NULL, uuidRef);
    CFRelease(uuidRef);
    NSString *retStr = [NSString stringWithString:(__bridge NSString *)uuidStrRef];
    CFRelease(uuidStrRef);
    return retStr;
}
/**划虚线*/
+(void)makeLineInImageView:(UIImageView*)imageView{
    UIGraphicsBeginImageContext(imageView.frame.size);   //开始画线
    [imageView.image drawInRect:CGRectMake(0, 0, imageView.frame.size.width, imageView.frame.size.height)];
    CGContextSetLineCap(UIGraphicsGetCurrentContext(), kCGLineCapRound);  //设置线条终点形状
    CGFloat lengths[] = {2,2}; //第一个参数设置每个虚线的宽度，第二个参数设置两个虚线的间隔
    CGContextRef line = UIGraphicsGetCurrentContext();
    CGContextSetStrokeColorWithColor(line, [UIColor grayColor].CGColor);
    CGContextSetLineDash(line, 0, lengths, 2);  //画虚线
    CGContextMoveToPoint(line, 0.0, 0.0);    //开始画线
    CGContextAddLineToPoint(line, imageView.frame.size.width, 0.0);
    CGContextStrokePath(line);
    imageView.image = UIGraphicsGetImageFromCurrentImageContext();
}
+ (NSString*)splicedString:(NSArray*)objects separator:(NSString*)separator
{
    NSMutableString* splicedString = [NSMutableString string];
    [objects enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        [splicedString appendFormat:@"%@", obj];
        if (idx < objects.count - 1) {
            [splicedString appendString:separator];
        }
    }];
    return splicedString;
}

+ (NSString*)filePath:(NSSearchPathDirectory)directory fileName:(NSString*)fileName
{
    NSString* path = [NSSearchPathForDirectoriesInDomains(directory, NSUserDomainMask, YES) objectAtIndex:0];
    path = [path stringByAppendingPathComponent:fileName];
    NSString* dir = [path stringByDeletingLastPathComponent];
    [[NSFileManager defaultManager] createDirectoryAtPath:dir withIntermediateDirectories:YES attributes:nil error:NULL];
    return path;
}

+ (NSString*)userFilePath:(int)uid fileName:(NSString*)fileName
{
    NSParameterAssert(uid);
    NSString* name = [[@(uid) stringValue] stringByAppendingPathComponent:fileName];
    NSString* path = [GZCUtility filePath:NSDocumentDirectory fileName:name];
    return path;
}

+ (NSMutableDictionary *)parseUrlParamters:(NSString *)urlParamters {
    
    NSMutableDictionary *dictionary=[NSMutableDictionary dictionary];
    NSArray *params=[urlParamters componentsSeparatedByString:@"&"];
    for (int i=0; i<params.count; i++) {
        NSArray *kv=[params[i] componentsSeparatedByString:@"="];
        if (kv.count>1) {
            NSString *val=kv[1];
            [dictionary setObject:val forKey:kv[0]];
        }
        
    }
    return dictionary;
}

+ (NSMutableDictionary *)parseUrlQuoteParamters:(NSString *)urlParamters {
    NSMutableDictionary *dictionary=[NSMutableDictionary dictionary];
    NSArray *params=[urlParamters componentsSeparatedByString:@"&"];
    for (int i=0; i<params.count; i++) {
        NSArray *kv=[params[i] componentsSeparatedByString:@"="];
        NSString *val=kv[1];
        val=[val substringWithRange:NSMakeRange(1, val.length-2)];
        [dictionary setObject:val forKey:kv[0]];
    }
    return dictionary;
}

+ (int)stringLength:(NSString*)string
{
    int strlength = 0;
    char* p = (char*)[string cStringUsingEncoding:NSUnicodeStringEncoding];
    for (int i=0 ; i<[string lengthOfBytesUsingEncoding:NSUnicodeStringEncoding] ;i++) {
        if (*p) {
            p++;
            strlength++;
        }
        else {
            p++;
        }
    }
    return (strlength+1)/2;
}

+ (NSString *)currentVersion {
    return VERSION;//[[[NSBundle mainBundle] infoDictionary] objectForKey:(NSString *)kCFBundleVersionKey];
}



#pragma mark MAC
// Return the local MAC addy
// Courtesy of FreeBSD hackers email list
// Accidentally munged during previous update. Fixed thanks to mlamb.
+ (NSString *) macaddress
{
    int                    mib[6];
    size_t                len;
    char                *buf;
    unsigned char        *ptr;
    struct if_msghdr    *ifm;
    struct sockaddr_dl    *sdl;
    
    mib[0] = CTL_NET;
    mib[1] = AF_ROUTE;
    mib[2] = 0;
    mib[3] = AF_LINK;
    mib[4] = NET_RT_IFLIST;
    
    if ((mib[5] = if_nametoindex("en0")) == 0) {
        printf("Error: if_nametoindex error/n");
        return NULL;
    }
    
    if (sysctl(mib, 6, NULL, &len, NULL, 0) < 0) {
        printf("Error: sysctl, take 1/n");
        return NULL;
    }
    
    if ((buf = malloc(len)) == NULL) {
        printf("Could not allocate memory. error!/n");
        return NULL;
    }
    
    if (sysctl(mib, 6, buf, &len, NULL, 0) < 0) {
        printf("Error: sysctl, take 2");
        return NULL;
    }
    
    ifm = (struct if_msghdr *)buf;
    sdl = (struct sockaddr_dl *)(ifm + 1);
    ptr = (unsigned char *)LLADDR(sdl);
    // NSString *outstring = [NSString stringWithFormat:@"%02x:%02x:%02x:%02x:%02x:%02x", *ptr, *(ptr+1), *(ptr+2), *(ptr+3), *(ptr+4), *(ptr+5)];
    NSString *outstring = [NSString stringWithFormat:@"%02x:%02x:%02x:%02x:%02x:%02x", *ptr, *(ptr+1), *(ptr+2), *(ptr+3), *(ptr+4), *(ptr+5)];
    free(buf);
    return [outstring uppercaseString];
    
}

+ (NSArray *)rangesOfString:(NSString *)searchString inString:(NSString *)str options:(NSStringCompareOptions)mask
{
    NSMutableArray *results = [NSMutableArray array];
    NSRange searchRange = NSMakeRange(0, [str length]);
    NSRange range;
    while ((range = [str rangeOfString:searchString options:mask range:searchRange]).location != NSNotFound) {
        [results addObject:[NSValue valueWithRange:range]];
        searchRange = NSMakeRange(NSMaxRange(range), [str length] - NSMaxRange(range));
    }
    return results;
}


+ (NSString*)base64forData:(NSData*)data
{
    //Point to start of the data and set buffer sizes
    int inLength = (int)[data length];
    int outLength = ((((inLength * 4)/3)/4)*4) + (((inLength * 4)/3)%4 ? 4 : 0);
    const char *inputBuffer = [data bytes];
    char *outputBuffer = malloc(outLength+1);
    outputBuffer[outLength] = 0;
    
    //64 digit code
    static char Encode[] = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/";
    
    //Start the count
    int cycle = 0;
    int inpos = 0;
    int outpos = 0;
    char temp;
    
    //Pad the last to bytes, the outbuffer must always be a multiple of 4.
    outputBuffer[outLength-1] = '=';
    outputBuffer[outLength-2] = '=';
    
    /* http://en.wikipedia.org/wiki/Base64
     
     Text content     M         a         n
     ASCII            77        97        110
     8 Bit pattern    01001101  01100001  01101110
     
     6 Bit pattern    010011    010110    000101    101110
     Index            19        22        5         46
     Base64-encoded   T         W         F         u
     */
    
    while (inpos < inLength){
        switch (cycle) {
                
            case 0:
                outputBuffer[outpos++] = Encode[(inputBuffer[inpos] & 0xFC) >> 2];
                cycle = 1;
                break;
                
            case 1:
                temp = (inputBuffer[inpos++] & 0x03) << 4;
                outputBuffer[outpos] = Encode[temp];
                cycle = 2;
                break;
                
            case 2:
                outputBuffer[outpos++] = Encode[temp|(inputBuffer[inpos]&0xF0) >> 4];
                temp = (inputBuffer[inpos++] & 0x0F) << 2;
                outputBuffer[outpos] = Encode[temp];
                cycle = 3;
                break;
                
            case 3:
                outputBuffer[outpos++] = Encode[temp|(inputBuffer[inpos]&0xC0) >> 6];
                cycle = 4;
                break;
                
            case 4:
                outputBuffer[outpos++] = Encode[inputBuffer[inpos++] & 0x3f];
                cycle = 0;
                break;
                
            default:
                cycle = 0;
                break;
        }
    }
    NSString *pictemp = [NSString stringWithUTF8String:outputBuffer];
    free(outputBuffer);
    return pictemp;
    
    //    const uint8_t* input = (const uint8_t*)[theData bytes];
    //    NSInteger length = [theData length];
    //
    //    static char table[] = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/=";
    //
    //    NSMutableData* data = [NSMutableData dataWithLength:((length + 2) / 3) * 4];
    //    uint8_t* output = (uint8_t*)data.mutableBytes;
    //
    //    NSInteger i;
    //    for (i=0; i < length; i += 3) {
    //        NSInteger value = 0;
    //        NSInteger j;
    //        for (j = i; j < (i + 3); j++) {
    //            value <<= 8;
    //
    //            if (j < length) {
    //                value |= (0xFF & input[j]);
    //            }
    //        }
    //
    //        NSInteger theIndex = (i / 3) * 4;
    //        output[theIndex + 0] =                    table[(value >> 18) & 0x3F];
    //        output[theIndex + 1] =                    table[(value >> 12) & 0x3F];
    //        output[theIndex + 2] = (i + 1) < length ? table[(value >> 6)  & 0x3F] : '=';
    //        output[theIndex + 3] = (i + 2) < length ? table[(value >> 0)  & 0x3F] : '=';
    //    }
    //
    //    return [[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding];
}

+ (NSString *)wapUrl:(NSString *)url {
    NSRange range = [url rangeOfString:@"?"];
    NSString *modeParam = @"mode=1";
    if (range.location==NSNotFound) {
        modeParam = [NSString stringWithFormat:@"?%@", modeParam];
    } else {
        modeParam = [NSString stringWithFormat:@"&%@", modeParam];
    }
    return [NSString stringWithFormat:@"%@%@", url, modeParam];
}

+ (void)calculateDirectorySize:(NSString*)directory completion:(void (^)(NSUInteger fileCount, NSUInteger totalSize))completion
{
    NSURL *diskCacheURL = [NSURL fileURLWithPath:directory isDirectory:YES];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSUInteger fileCount = 0;
        NSUInteger totalSize = 0;
        
        NSFileManager *fileManager = [NSFileManager defaultManager];
        NSDirectoryEnumerator *fileEnumerator = [fileManager enumeratorAtURL:diskCacheURL includingPropertiesForKeys:@[NSFileSize] options:NSDirectoryEnumerationSkipsHiddenFiles errorHandler:NULL];
        
        for (NSURL *fileURL in fileEnumerator) {
            NSNumber *fileSize;
            [fileURL getResourceValue:&fileSize forKey:NSURLFileSizeKey error:NULL];
            totalSize += [fileSize unsignedIntegerValue];
            fileCount += 1;
        }
        
        if (completion) {
            dispatch_async(dispatch_get_main_queue(), ^{
                completion(fileCount, totalSize);
            });
        }
    });
}

+ (void)clearDirectory:(NSString*)directory completion:(void (^)())completion
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSError* error;
        [[NSFileManager defaultManager] removeItemAtPath:directory error:&error];
        if (completion) {
            dispatch_async(dispatch_get_main_queue(), ^{
                completion();
            });
        }
    });
}
+(CGSize)downloadImageSizeWithURL:(id)imageURL
{
    NSURL* URL = nil;
    if([imageURL isKindOfClass:[NSURL class]]){
        URL = imageURL;
    }
    if([imageURL isKindOfClass:[NSString class]]){
        URL = [NSURL URLWithString:imageURL];
    }
    if(URL == nil)
        return CGSizeZero;
    
    //    NSString* absoluteString = URL.absoluteString;
    
#ifdef dispatch_main_sync_safe
    if([[SDImageCache sharedImageCache] diskImageExistsWithKey:absoluteString])
    {
        UIImage* image = [[SDImageCache sharedImageCache] imageFromMemoryCacheForKey:absoluteString];
        if(!image)
        {
            NSData* data = [[SDImageCache sharedImageCache] performSelector:@selector(diskImageDataBySearchingAllPathsForKey:) withObject:URL.absoluteString];
            image = [UIImage imageWithData:data];
        }
        if(image)
        {
            return image.size;
        }
    }
#endif
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:URL];
    NSString* pathExtendsion = [URL.pathExtension lowercaseString];
    
    CGSize size = CGSizeZero;
    if([pathExtendsion isEqualToString:@"png"]){
        size =  [self downloadPNGImageSizeWithRequest:request];
    }
    else if([pathExtendsion isEqual:@"gif"])
    {
        size =  [self downloadGIFImageSizeWithRequest:request];
    }
    else{
        size = [self downloadJPGImageSizeWithRequest:request];
    }
    if(CGSizeEqualToSize(CGSizeZero, size))
    {
        NSData* data = [NSURLConnection sendSynchronousRequest:[NSURLRequest requestWithURL:URL] returningResponse:nil error:nil];
        UIImage* image = [UIImage imageWithData:data];
        if(image)
        {
#ifdef dispatch_main_sync_safe
            [[SDImageCache sharedImageCache] storeImage:image recalculateFromImage:YES imageData:data forKey:URL.absoluteString toDisk:YES];
#endif
            size = image.size;
        }
    }
    return size;
}
+(CGSize)downloadPNGImageSizeWithRequest:(NSMutableURLRequest*)request
{
    [request setValue:@"bytes=16-23" forHTTPHeaderField:@"Range"];
    NSData* data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    if(data.length == 8)
    {
        int w1 = 0, w2 = 0, w3 = 0, w4 = 0;
        [data getBytes:&w1 range:NSMakeRange(0, 1)];
        [data getBytes:&w2 range:NSMakeRange(1, 1)];
        [data getBytes:&w3 range:NSMakeRange(2, 1)];
        [data getBytes:&w4 range:NSMakeRange(3, 1)];
        int w = (w1 << 24) + (w2 << 16) + (w3 << 8) + w4;
        int h1 = 0, h2 = 0, h3 = 0, h4 = 0;
        [data getBytes:&h1 range:NSMakeRange(4, 1)];
        [data getBytes:&h2 range:NSMakeRange(5, 1)];
        [data getBytes:&h3 range:NSMakeRange(6, 1)];
        [data getBytes:&h4 range:NSMakeRange(7, 1)];
        int h = (h1 << 24) + (h2 << 16) + (h3 << 8) + h4;
        return CGSizeMake(w, h);
    }
    return CGSizeZero;
}
+(CGSize)downloadGIFImageSizeWithRequest:(NSMutableURLRequest*)request
{
    [request setValue:@"bytes=6-9" forHTTPHeaderField:@"Range"];
    NSData* data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    if(data.length == 4)
    {
        short w1 = 0, w2 = 0;
        [data getBytes:&w1 range:NSMakeRange(0, 1)];
        [data getBytes:&w2 range:NSMakeRange(1, 1)];
        short w = w1 + (w2 << 8);
        short h1 = 0, h2 = 0;
        [data getBytes:&h1 range:NSMakeRange(2, 1)];
        [data getBytes:&h2 range:NSMakeRange(3, 1)];
        short h = h1 + (h2 << 8);
        return CGSizeMake(w, h);
    }
    return CGSizeZero;
}
+(CGSize)downloadJPGImageSizeWithRequest:(NSMutableURLRequest*)request
{
    [request setValue:@"bytes=0-209" forHTTPHeaderField:@"Range"];
    NSData* data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    
    if ([data length] <= 0x58) {
        return CGSizeZero;
    }
    
    if ([data length] < 210) {// 肯定只有一个DQT字段
        short w1 = 0, w2 = 0;
        [data getBytes:&w1 range:NSMakeRange(0x60, 0x1)];
        [data getBytes:&w2 range:NSMakeRange(0x61, 0x1)];
        short w = (w1 << 8) + w2;
        short h1 = 0, h2 = 0;
        [data getBytes:&h1 range:NSMakeRange(0x5e, 0x1)];
        [data getBytes:&h2 range:NSMakeRange(0x5f, 0x1)];
        short h = (h1 << 8) + h2;
        return CGSizeMake(w, h);
    } else {
        short word = 0x0;
        [data getBytes:&word range:NSMakeRange(0x15, 0x1)];
        if (word == 0xdb) {
            [data getBytes:&word range:NSMakeRange(0x5a, 0x1)];
            if (word == 0xdb) {// 两个DQT字段
                short w1 = 0, w2 = 0;
                [data getBytes:&w1 range:NSMakeRange(0xa5, 0x1)];
                [data getBytes:&w2 range:NSMakeRange(0xa6, 0x1)];
                short w = (w1 << 8) + w2;
                short h1 = 0, h2 = 0;
                [data getBytes:&h1 range:NSMakeRange(0xa3, 0x1)];
                [data getBytes:&h2 range:NSMakeRange(0xa4, 0x1)];
                short h = (h1 << 8) + h2;
                return CGSizeMake(w, h);
            } else {// 一个DQT字段
                short w1 = 0, w2 = 0;
                [data getBytes:&w1 range:NSMakeRange(0x60, 0x1)];
                [data getBytes:&w2 range:NSMakeRange(0x61, 0x1)];
                short w = (w1 << 8) + w2;
                short h1 = 0, h2 = 0;
                [data getBytes:&h1 range:NSMakeRange(0x5e, 0x1)];
                [data getBytes:&h2 range:NSMakeRange(0x5f, 0x1)];
                short h = (h1 << 8) + h2;
                return CGSizeMake(w, h);
            }
        } else {
            return CGSizeZero;
        }
    }
}




+(float) getCenterX:(float) fatherWidth
   currentViewWidth:(float)currentViewWidth{
    
    return   fatherWidth/2-currentViewWidth/2;
}

+(float) getCenterY:(float) fatherHeight
  currentViewHeight:(float)currentViewHeight{
    
    return  fatherHeight/2-currentViewHeight/2;
}


//获得文字宽高
+(CGSize)getLabelSize:(NSString*)lbtext
             withFont:(UIFont*)font
         withRowWidth:(float)width{
    
    NSDictionary *attribute = @{NSFontAttributeName:font};
    CGSize labelsize ;//= [lbtext sizeWithFont:font constrainedToSize:CGSizeMake(width, constrainedHeight) lineBreakMode:UILineBreakModeWordWrap];
    
    if (IOS7_OR_LATER) {
        
        labelsize= [lbtext boundingRectWithSize:CGSizeMake(width, MAXFLOAT)
                                        options: NSStringDrawingTruncatesLastVisibleLine|NSStringDrawingUsesLineFragmentOrigin |NSStringDrawingUsesFontLeading attributes:attribute context:nil].size;
    }else{
        labelsize = [lbtext sizeWithFont:font constrainedToSize:CGSizeMake(width, MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping];
        
    }
    return labelsize;
    
    
}

//添加线
//+(UILabel*) addLine:(CGRect) rect
//           addControl:(UIView*)addControl
//             colorRef:(NSString*)colorRef{
//    
//    UILabel *lineLable = [UILabel alloc] initWithFrame:re
//    UILabel *lineLable=[[UILabel alloc] initWithFrame:rect string:@""  fontSize:12 colorRef:nil  ];
//    [lineLable setBackgroundColor:[UIColor colorWithHexString:colorRef]];
//    [addControl addSubview:lineLable];
//    
//    
//    return lineLable;
//    
//}


//判断是否为整形：

+(BOOL)isPureInt:(NSString*)string{
    
    NSScanner* scan = [NSScanner scannerWithString:string];
    int val;
    
    return[scan scanInt:&val] && [scan isAtEnd];
}

//判断是否为浮点形：

+(BOOL)isPureFloat:(NSString*)string{
    
    NSScanner* scan = [NSScanner scannerWithString:string];
    float val;
    
    return[scan scanFloat:&val] && [scan isAtEnd];
}





+ (void) indexPath:(NSIndexPath *)indexPath AndButton:(UIButton *)button AndProductNumber:(NSInteger)number
{
    
    if (indexPath.item<10) {
        
        [UIView animateWithDuration:0.3 animations:^{
            button.alpha = 0;
            
        }];
        
    } else {
        
        [UIView animateWithDuration:0.3 animations:^{
            button.alpha = 1;
            button.titleLabel.lineBreakMode=NSLineBreakByWordWrapping;
            
            [button setTitle:[NSString stringWithFormat:@"%ld\n%ld",indexPath.item+1,number] forState:UIControlStateNormal];
            
            button.titleEdgeInsets = UIEdgeInsetsMake(5, 0, 5, 0);
            
        }];
    }
    
}



//回到首页
+(void) goHomePage{
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"gotoRootNotification" object:nil];
}

+(void)sendSystemSetttingView:(NSString *)str{
    
    //    About — prefs:root=General&path=About
    //    Accessibility — prefs:root=General&path=ACCESSIBILITY
    //    Airplane Mode On — prefs:root=AIRPLANE_MODE
    //    Auto-Lock — prefs:root=General&path=AUTOLOCK
    //    Brightness — prefs:root=Brightness
    //    Bluetooth — prefs:root=General&path=Bluetooth
    //    Date & Time — prefs:root=General&path=DATE_AND_TIME
    //    FaceTime — prefs:root=FACETIME
    //    General — prefs:root=General
    //    Keyboard — prefs:root=General&path=Keyboard
    //    iCloud — prefs:root=CASTLE
    //    iCloud Storage & Backup — prefs:root=CASTLE&path=STORAGE_AND_BACKUP
    //    International — prefs:root=General&path=INTERNATIONAL
    //    Location Services — prefs:root=LOCATION_SERVICES
    //    Music — prefs:root=MUSIC
    //    Music Equalizer — prefs:root=MUSIC&path=EQ
    //    Music Volume Limit — prefs:root=MUSIC&path=VolumeLimit
    //    Network — prefs:root=General&path=Network
    //    Nike + iPod — prefs:root=NIKE_PLUS_IPOD
    //    Notes — prefs:root=NOTES
    //    Notification — prefs:root=NOTIFICATIONS_ID
    //    Phone — prefs:root=Phone
    //    Photos — prefs:root=Photos
    //    Profile — prefs:root=General&path=ManagedConfigurationList
    //    Reset — prefs:root=General&path=Reset
    //    Safari — prefs:root=Safari
    //    Siri — prefs:root=General&path=Assistant
    //    Sounds — prefs:root=Sounds
    //    Software Update — prefs:root=General&path=SOFTWARE_UPDATE_LINK
    //    Store — prefs:root=STORE
    //    Twitter — prefs:root=TWITTER
    //    Usage — prefs:root=General&path=USAGE
    //    VPN — prefs:root=General&path=Network/VPN
    //    Wallpaper — prefs:root=Wallpaper
    //    Wi-Fi — prefs:root=WIFI
    
    //定位服务设置界面                     prefs:root=WIFI
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"prefs:root=%@",str]];
    if ([[UIApplication sharedApplication] canOpenURL:url])
    {
        [[UIApplication sharedApplication] openURL:url];
    }
}

+(void)getSystemConfigurationInformation:(void (^)(NSString *name, NSString *model,NSString *systemVersion,NSString *systemName))success{
    
    success([NSString stringWithFormat:@"设备名称_%@",[UIDevice currentDevice].name],
            [NSString stringWithFormat:@"设备型号_%@",[UIDevice currentDevice].model],
            [NSString stringWithFormat:@"系统版本型号_%@",[UIDevice currentDevice].systemVersion],
            [NSString stringWithFormat:@"系统名称_%@",[UIDevice currentDevice].systemName]
            );
    //
    //    //判断是否为iPhone
    //#define IS_IPHONE (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
    //
    //    //判断是否为iPad
    //#define IS_IPAD (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
    //    
    //    //判断是否为ipod
    //#define IS_IPOD ([[[UIDevice currentDevice] model] isEqualToString:@"iPod touch"])
    
}

+(void)drawBorderRound:(UIButton *)sender andBorderWidth:(CGFloat)width andCornerRadius:(CGFloat)radius andColor:(NSString *)color{
    
    sender.layer.borderColor = [[UIColor colorWithHexString:color] CGColor];
    sender.layer.borderWidth = width;
    sender.clipsToBounds = YES;
    sender.layer.cornerRadius = radius;
    
}

+(Boolean) isEmptyOrNul:(NSString *) str {
    if (!str) {
        // null object
        return NO;
    } else {
        NSString *trimedString = [str stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        if ([trimedString length] == 0) {
            // empty string
            return NO;
        } else {
            // is neither empty nor null
            return YES;
        }
    }
}

+(NSString*)   convetString:(NSInteger) value{
    
    return   [NSString stringWithFormat:@"%ld", (long)value] ;
}

+(NSString*)   convetStringForFloat:(float) value{
    
    return   [NSString stringWithFormat:@"%f", value] ;
}

+(NSString*)   convetMoney:(float) value {
    
    return   [NSString stringWithFormat:@"￥%.2f", value] ;
}

+(NSString*)   convetTwoDecimal:(float) value {
    
    return   [NSString stringWithFormat:@"%.2f", value] ;
    
}

+ (void)setClearColorTheme:(UINavigationController *)navigater
{
    navigater.navigationBar.hidden = YES;
    navigater.navigationBar.translucent = YES;
    //    [self.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    [navigater.navigationBar setBackgroundImage:[UIImage new] forBarPosition:UIBarPositionTopAttached barMetrics:UIBarMetricsDefault];
    
    [navigater.navigationBar setBarStyle:UIBarStyleDefault];
    // 设置白色
    navigater.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:[UIColor whiteColor]};
    [navigater.navigationBar setShadowImage:[UIImage new]];
}

//拉伸图片
+(UIImage*) stretchableImage:(UIImage*)stretchableImage stretchableImageWithLeftCapWidth:(int)stretchableImageWithLeftCapWidth  topCapHeight:(int)topCapHeight{
    
    
    UIImage *stretchableButtonImageNormal = [stretchableImage
                                             stretchableImageWithLeftCapWidth:stretchableImageWithLeftCapWidth topCapHeight:topCapHeight];
    
    return  stretchableButtonImageNormal;
}

@end


//@implementation NSString (encrypto)
//- (NSString*) sha1
//{
//    const char *cstr = [self cStringUsingEncoding:NSUTF8StringEncoding];
//    NSData *data = [NSData dataWithBytes:cstr length:self.length];
//    
//    uint8_t digest[CC_SHA1_DIGEST_LENGTH];
//    
//    CC_SHA1(data.bytes, (unsigned int)data.length, digest);
//    
//    NSMutableString* output = [NSMutableString stringWithCapacity:CC_SHA1_DIGEST_LENGTH * 2];
//    
//    for(int i = 0; i < CC_SHA1_DIGEST_LENGTH; i++)
//        [output appendFormat:@"%02x", digest[i]];
//    
//    return output;
//}
//
//-(NSString *) md5
//{
//    const char *cStr = [self UTF8String];
//    unsigned char digest[CC_MD5_DIGEST_LENGTH];
//    CC_MD5( cStr, (unsigned int)strlen(cStr), digest );
//    
//    NSMutableString *output = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
//    
//    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
//        [output appendFormat:@"%02x", digest[i]];
//    
//    return output;
//}
//
//- (NSString *) sha1_base64
//{
//    const char *cstr = [self cStringUsingEncoding:NSUTF8StringEncoding];
//    NSData *data = [NSData dataWithBytes:cstr length:self.length];
//    
//    uint8_t digest[CC_SHA1_DIGEST_LENGTH];
//    
//    CC_SHA1(data.bytes, (unsigned int)data.length, digest);
//    
//    NSData * base64 = [[NSData alloc]initWithBytes:digest length:CC_SHA1_DIGEST_LENGTH];
//    base64 = [GTMBase64 encodeData:base64];
//    
//    NSString * output = [[NSString alloc] initWithData:base64 encoding:NSUTF8StringEncoding];
//    return output;
//}
//
//- (NSString *) md5_base64
//{
//    const char *cStr = [self UTF8String];
//    unsigned char digest[CC_MD5_DIGEST_LENGTH];
//    CC_MD5( cStr, (unsigned int)strlen(cStr), digest );
//    
//    NSData * base64 = [[NSData alloc]initWithBytes:digest length:CC_MD5_DIGEST_LENGTH];
//    base64 = [GTMBase64 encodeData:base64];
//    
//    NSString * output = [[NSString alloc] initWithData:base64 encoding:NSUTF8StringEncoding];
//    return output;
//}
//
//- (NSString *) base64
//{
//    NSData * data = [self dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
//    data = [GTMBase64 encodeData:data];
//    NSString * output = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
//    return output;
//}
//- (NSString*) dBase64 {
//    NSData*data = [self dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
//    data = [GTMBase64 decodeData:data];
//    NSString*base64String = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding] ;
//    return base64String;
//    
//}
//@end


@implementation NSString (urlencode)
- (NSString *) urlencode:(NSStringEncoding) encoding {
    
    static NSString * const kAFCharactersToBeEscaped = @":/?&=;+!@#$()~',*";
    static NSString * const kAFCharactersToLeaveUnescaped = @"[].";
    
    CFStringRef ref = CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, (CFStringRef)self, (CFStringRef)kAFCharactersToLeaveUnescaped, (CFStringRef)kAFCharactersToBeEscaped, CFStringConvertNSStringEncodingToEncoding(encoding));

    NSString * result = [NSString stringWithFormat:@"%@",(__bridge NSString *)ref];
    CFRelease(ref);
    return result;
}
@end



@implementation UIImage (GZCColor)
+ (UIImage *)imageWithColor:(UIColor *)color
{
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

@end
