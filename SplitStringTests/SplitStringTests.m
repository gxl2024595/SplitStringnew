//
//  SplitStringTests.m
//  SplitStringTests
//
//  Created by 龚晓龙 on 16/5/12.
//  Copyright © 2016年 龚晓龙. All rights reserved.
//

#import <XCTest/XCTest.h>

@interface SplitStringTests : XCTestCase

@end

@implementation SplitStringTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
    //定义一个字符串和分隔符
    NSString *string = @"a,b,,c,,,d,,,,e,,,,,frr,,,,,dddd";
    NSString *symbol = @",,,,";
    
    //使用系统方法进行分割
    NSArray *systemArray = [string componentsSeparatedByString:symbol];
    
    //系统方法分割后的数组元素拼接成一个完整字符串当做输出内容
    NSMutableString *systemText = [NSMutableString new];
    for (NSString *str in systemArray) {
        NSString *tempStr = [NSString stringWithFormat:@"%@\n",str];
        [systemText appendString:tempStr];
    }
    
    //使用自定义方法进行分割
    NSMutableArray *mutableArr = [NSMutableArray new];
    for (int flaghead = 0, flagtemp = 0;flagtemp<=string.length-symbol.length; flagtemp++) {
        NSString *tempStr = [string substringWithRange:NSMakeRange(flagtemp, symbol.length)];
        if ([tempStr isEqualToString:symbol]) {
            NSString *splitStr = [string substringWithRange:NSMakeRange(flaghead, flagtemp-flaghead)];
            [mutableArr addObject:splitStr];
            flaghead = flagtemp + (int)symbol.length;
            flagtemp = flaghead-1;
        }
        if (flagtemp >= string.length - symbol.length) {
            NSString *splitStr = [string substringWithRange:NSMakeRange(flaghead, string.length-flaghead)];
            [mutableArr addObject:splitStr];
        }
    }
    
    //自定义方法分割后的数组元素拼接成一个完整字符串当做输出内容
    NSArray *spliteArray = [mutableArr copy];
    NSMutableString *splitText = [NSMutableString new];
    for (NSString *str in spliteArray) {
        NSString *tempStr = [NSString stringWithFormat:@"%@\n",str];
        [splitText appendString:tempStr];
    }
    
    //比较系统与自定义分割字符串后最后的内容是否一致
    XCTAssert([systemText isEqualToString:splitText],@"系统方法与自定义方法输出文本不一致");
    
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
    }];
}



@end
