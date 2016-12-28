//
//  LableView.h
//  LiveByTouch
//
//  Created by xiexin on 11-7-26.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//


#import "LableView.h"


@implementation LableView
//@synthesize parame;


//普通设置版本
- (id)initWithFrame:(CGRect)frame
             string:(NSString*)str
           fontSize:(int)fontSize
           colorRef:(NSString*) colorRef{
    
    self = [super initWithFrame:frame];
    if (self) {
        
        UIFont *font =  [UIFont systemFontOfSize:fontSize];
        [self setFont:font ];
        [self setText:str];
        self.backgroundColor=[UIColor clearColor];
        
        if (colorRef==nil) {
            
            self.textColor=[UIColor colorWithHexString:@"333333"];
        }
        else{
            
            self.textColor=[UIColor colorWithHexString:colorRef];
        }
        
    }
    
    return self;
}

//自适应宽度
- (id)initWithAdaptiveFrame:(CGRect)frame
                     string:(NSString*)str
                   fontSize:(int)fontSize
                   colorRef:(NSString*) colorRef {
    
    self = [super initWithFrame:frame];
    if (self) {
        
        
        
        
        UIFont *font = [UIFont systemFontOfSize:fontSize];
        CGSize size = CGSizeMake(MAXFLOAT, MAXFLOAT);
        CGSize lablesize = [str sizeWithFont:font
                           constrainedToSize:size
                               lineBreakMode:UILineBreakModeCharacterWrap];
        [self setFont:font];
        
        frame.size.width = lablesize.width;
        frame.size.height = lablesize.height;
        
        self.numberOfLines = 1;
        self.frame = frame;
        self.backgroundColor = [UIColor clearColor];
        self.text=str;
        
        
        if (colorRef==nil) {
            
            self.textColor=[UIColor colorWithHexString:@"333333"];
        }
        else{
            
            self.textColor=[UIColor colorWithHexString:colorRef];
        }
        
        
    }
    
    return self;
}


//根据宽度自动换行版本 (同时自适应大小版本)
- (id)initWithFrameAndWrap:(CGRect)frame
                    string:(NSString*)str
                  fontSize:(int)fontSize
                  colorRef:(NSString*) colorRef{
    
    self = [super initWithFrame:frame];
    
    if (self) {
        
        
        UIFont *font = [UIFont systemFontOfSize:fontSize];
        CGSize size = CGSizeMake(self.frame.size.width, MAXFLOAT);
        CGSize lablesize = [str sizeWithFont:font
                           constrainedToSize:size
                               lineBreakMode:UILineBreakModeCharacterWrap];
        
        
        frame.size.width = lablesize.width;
        frame.size.height = lablesize.height;
        self.frame = frame;
        
        self.numberOfLines = 0;
        self.lineBreakMode = UILineBreakModeCharacterWrap;
        self.text = str;
        self.font=font;
        self.backgroundColor = [UIColor clearColor];
        
        
        if (colorRef==nil) {
            
            self.textColor=[UIColor colorWithHexString:@"333333"];
        }
        else{
            
            self.textColor=[UIColor colorWithHexString:colorRef];
        }
        
    }
    
    return self;
}


- (void) setContent:(NSString *)context  lineWidth:(float) lineWidth  {
    
    
    CGSize size = CGSizeMake(lineWidth, MAXFLOAT);
    
    CGSize lablesize = [context sizeWithFont:self.font
                           constrainedToSize:size
                               lineBreakMode:UILineBreakModeCharacterWrap];
    
    
    [self setFrame:CGRectMake(self.frame.origin.x,
                              self.frame.origin.y,
                              lablesize.width,
                              lablesize.height)];
    
    self.numberOfLines = 0;
    self.lineBreakMode = UILineBreakModeCharacterWrap;
    self.text = context;
    
}


@end





@interface AttributedLabel(){
    
}
@property (nonatomic,retain)NSMutableAttributedString    *attString;
@end

@implementation AttributedLabel
@synthesize attString = _attString;

- (void)dealloc{
    

}

- (id)initWithFrame:(CGRect)frame  text:(NSString *)text
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.attString = [[NSMutableAttributedString alloc] initWithString:text];
        [super setText:text];
    }
    return self;
}

- (void)drawRect:(CGRect)rect{
    
    
    CATextLayer *oldTextLayer=nil;
    for (CATextLayer *textLayer in self.layer.sublayers) {
        
        oldTextLayer=textLayer;
        
    }
    
    CATextLayer *textLayer = [CATextLayer layer];
    textLayer.string = _attString;
    textLayer.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    
    CGFloat fscale = [[UIScreen mainScreen] scale];
    textLayer.contentsScale = fscale;
    [self.layer addSublayer:textLayer];
    
    if (oldTextLayer) {
        
        [oldTextLayer removeFromSuperlayer];
    }
    
    
    
}

- (void)setText:(NSString *)text
{
    
    [super setText:text];
    
    if (text == nil) {
        
        self.attString = nil;
        
    }else{
        
        if (self.attString) { //清楚旧的,因为有可能位置发生变化了
        
            self.attString=nil;
        }
        
        self.attString = [[NSMutableAttributedString alloc] initWithString:text];
        [self setColor:self.textColor queryString:self.text];
        
    }
}


- (void)setColor:(UIColor *)color fromIndex:(NSInteger)location length:(NSInteger)length{
    
    if (location < 0||location>self.text.length-1||length+location>self.text.length) {
        
        return;
    }
    
    [_attString addAttribute:(NSString *)kCTForegroundColorAttributeName
                       value:(id)color.CGColor
                       range:NSMakeRange(location, length)];
}

// 设置某段字的颜色
- (void)setColor:(UIColor *)color queryString:(NSString*) queryString{
    
    NSRange queryRange=[self.text rangeOfString:queryString];
    [self setColor:color fromIndex:queryRange.location length:queryRange.length];
    
}

// 设置某段字的字体
- (void)setFont:(UIFont *)font fromIndex:(NSInteger)location length:(NSInteger)length{
    
    if (location < 0||location>self.text.length-1||length+location>self.text.length) {
        
        return;
    }
    
    [_attString addAttribute:(NSString *)kCTFontAttributeName
                       value:(id)CFBridgingRelease(CTFontCreateWithName((CFStringRef)font.fontName,
                                                      font.pointSize,
                                                      NULL))
                       range:NSMakeRange(location, length)];
}

// 设置某段字下划线，删除线的风格
- (void)setStyle:(CTUnderlineStyle)style fromIndex:(NSInteger)location length:(NSInteger)length{
    
    if (location < 0||location>self.text.length-1||length+location>self.text.length) {
        return;
    }
    
    [_attString addAttribute:(NSString *)kCTUnderlineStyleAttributeName
                       value:(id)[NSNumber numberWithInt:style]
                       range:NSMakeRange(location, length)];
}

-(void) setFont:(UIFont *)font{
    
    [_attString addAttribute:(NSString *)kCTFontAttributeName
                       value:(id)CFBridgingRelease(CTFontCreateWithName((CFStringRef)font.fontName,
                                                      font.pointSize,
                                                      NULL))
                       range:NSMakeRange(0, self.text.length)];
    
}

-(void) setTextColor:(UIColor *)textColor{
    
    [super setTextColor:textColor];
    [self setColor:textColor queryString:self.text];
}

 


//-(void) setStrikethrough:(NSUnderlineStyle) style{
//
//    [_attString addAttribute:NSStrikethroughStyleAttributeName
//                    value:(id)[NSNumber numberWithInteger:NSUnderlineStyleThick]
//                       range:NSMakeRange(0, self.text.length)];
//
//
//    //drawRect和这个有冲突，并且是ios6的方法，所以放弃该方法
//}

@end


@interface StrikethroughLabel(){
    
    UIFont *fontRef;
    
}

@end
@implementation StrikethroughLabel

-(void) setFont:(UIFont *)font{
    
    fontRef=font;
    [super setFont:font];
    
}

- (void)drawRect:(CGRect)rect
{
    
    if (self.isWithStrikeThrough)//显示删除线
    {
        
        
        CGContextRef c = UIGraphicsGetCurrentContext();
        
        CGFloat color[4] = {
            
            [[self.strikeThroughRGBAlphaArray objectAtIndex:0] floatValue],
            [[self.strikeThroughRGBAlphaArray objectAtIndex:1] floatValue],
            [[self.strikeThroughRGBAlphaArray objectAtIndex:2] floatValue],
            [[self.strikeThroughRGBAlphaArray objectAtIndex:3] floatValue]
            
        };
        
        CGFloat halfWayUp = (self.bounds.size.height - self.bounds.origin.y) / 2.0;
        
        
        CGSize    lableSize=  [self.text sizeWithFont:fontRef
                                    constrainedToSize:CGSizeMake(MAXFLOAT, MAXFLOAT)
                                        lineBreakMode:UILineBreakModeWordWrap];
        
        
        CGContextSetStrokeColor(c, color);
        
        CGContextSetLineWidth(c, self.strikeThroughLineWidth);
        
        //标记
        CGContextBeginPath(c);
        
        //开始点
        CGContextMoveToPoint(c, self.bounds.origin.x, halfWayUp );
        //结束点
        CGContextAddLineToPoint(c, self.bounds.origin.x + lableSize.width, halfWayUp);
        
        CGContextStrokePath(c);
        
        
    }
    
    [super drawRect:rect];
}

@end




