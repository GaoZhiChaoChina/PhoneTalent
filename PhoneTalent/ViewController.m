//
//  ViewController.m
//  PhoneTalent
//
//  Created by gaozhichao on 2016/12/28.
//  Copyright © 2016年 gaozhicao. All rights reserved.
//

#import "ViewController.h"


#define STRINGIZE_(x)  #x
#define STRINGIZE2(x)  STRINGIZE_(x)
#define OCNSSTRING(x) @STRINGIZE2(x)
#define metamacro_concat(A, B) A ## B



@interface ViewController ()

@end

@implementation ViewController

+ (void)load{
//    NSLog(@"%s",__func__);
//    NSLog(@"%s",object_getClassName(@"string"));
//    NSLog(@"%@",[self class]);
    NSLog(@"name = %@, age = %d", @"Ryan", 18);
    NSString *str      = @"This is Ryan!";
    NSLog(@"%@", metamacro_concat(st, r));  // This is Ryan!
    
//    NSLog(@"%s",STRINGIZE_(11));
//    NSLog(@"%s",STRINGIZE2(22));
//
//    NSLog(@"%s",object_getClassName(@STRINGIZE_(11)));
//
//    NSLog(@"%@",OCNSSTRING(33));

}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
