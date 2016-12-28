//
//  LableView.h
//  LiveByTouch
//
//  Created by xiexin on 11-7-26.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreText/CoreText.h>

@interface LableView : UILabel {
    
}
//@property(nonatomic,retain) NSDictionary *parame; //附加参数


//普通设置版本
- (id)initWithFrame:(CGRect)frame
             string:(NSString*)str
           fontSize:(int)fontSize
           colorRef:(NSString*) colorRef;


//自适应宽度
- (id)initWithAdaptiveFrame:(CGRect)frame
                     string:(NSString*)str
                   fontSize:(int)fontSize
                   colorRef:(NSString*) colorRef;

//根据宽度自动换行
- (id)initWithFrameAndWrap:(CGRect)frame
                    string:(NSString*)str
                  fontSize:(int)fontSize
                  colorRef:(NSString*) colorRef;


- (void) setContent:(NSString *)context lineWidth:(float)lineWidth;
@end



/*注意：采用textlayer来实现，比较简单,而且功能强大。缺点：layer会挡住lable设置，
 所以只能通过自己来扩展NSMutableAttributedString，或者自己重绘。
 */
@interface AttributedLabel : LableView

- (id)initWithFrame:(CGRect)frame  text:(NSString *)text;

// 设置某段字下划线，删除线的风格
- (void)setStyle:(CTUnderlineStyle)style fromIndex:(NSInteger)location length:(NSInteger)length;

// 设置某段字的颜色
- (void)setColor:(UIColor *)color queryString:(NSString*) queryString;

@end


@interface StrikethroughLabel : AttributedLabel
@property (nonatomic, assign) BOOL isWithStrikeThrough; //控制是否显示删除线
@property (nonatomic, assign) CGFloat strikeThroughLineWidth;//设置删除线的宽度
@property (nonatomic, retain) NSArray *strikeThroughRGBAlphaArray;//设置删除线的颜色
@end
