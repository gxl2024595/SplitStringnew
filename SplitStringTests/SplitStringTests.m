//
//  SplitStringTests.m
//  SplitStringTests
//
//  Created by 龚晓龙 on 16/5/12.
//  Copyright © 2016年 龚晓龙. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "ViewController.h"

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

- (void)testFuntion{
    ViewController *controller = [[ViewController alloc] init];
    NSString *string = @"a,b,,c,,,d,,,,e,,,,,f,,,g";
    NSString *symbol = @",,,";
    NSArray *splitArray = [controller splitString:string withSymbol:symbol];
    NSArray *resultArray = @[@"a,b,,c",@"d",@",e",@",,f",@"g"];
    XCTAssertEqualObjects(splitArray, resultArray);
}




- (void)testExample {
    
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
    }];
}



@end
