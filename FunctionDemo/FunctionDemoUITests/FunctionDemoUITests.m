//
//  FunctionDemoUITests.m
//  FunctionDemoUITests
//
//  Created by chaziyjs on 2018/4/8.
//  Copyright © 2018年 chaziyjs. All rights reserved.
//

#import <XCTest/XCTest.h>

@interface FunctionDemoUITests : XCTestCase

@end

@implementation FunctionDemoUITests

- (void)setUp {
    [super setUp];
    
    // Put setup code here. This method is called before the invocation of each test method in the class.
    
    // In UI tests it is usually best to stop immediately when a failure occurs.
    self.continueAfterFailure = NO;
    // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
    [[[XCUIApplication alloc] init] launch];
    
    // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}


- (void)testExample {
    
    
    XCUIApplication *app = [[XCUIApplication alloc] init];
    [[[[app childrenMatchingType:XCUIElementTypeWindow] elementBoundByIndex:0] childrenMatchingType:XCUIElementTypeOther].element tap];
    
    XCUIElementQuery *tablesQuery = app.scrollViews.tables;
    XCUIElement *row4StaticText = tablesQuery/*@START_MENU_TOKEN@*/.staticTexts[@"row:4"]/*[[".cells.staticTexts[@\"row:4\"]",".staticTexts[@\"row:4\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/;
    [row4StaticText swipeLeft];
    [row4StaticText swipeRight];
    [tablesQuery/*@START_MENU_TOKEN@*/.staticTexts[@"row:3"]/*[[".cells.staticTexts[@\"row:3\"]",".staticTexts[@\"row:3\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/ swipeDown];
    
    XCUIElement *row6StaticText = tablesQuery/*@START_MENU_TOKEN@*/.staticTexts[@"row:6"]/*[[".cells.staticTexts[@\"row:6\"]",".staticTexts[@\"row:6\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/;
    [row6StaticText swipeUp];
    
    XCUIElement *row8StaticText = tablesQuery/*@START_MENU_TOKEN@*/.staticTexts[@"row:8"]/*[[".cells.staticTexts[@\"row:8\"]",".staticTexts[@\"row:8\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/;
    [row8StaticText swipeLeft];
    [row6StaticText tap];
    
    XCUIElement *row5StaticText = tablesQuery/*@START_MENU_TOKEN@*/.staticTexts[@"row:5"]/*[[".cells.staticTexts[@\"row:5\"]",".staticTexts[@\"row:5\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/;
    [row5StaticText swipeUp];
    [row8StaticText swipeRight];
    [row8StaticText swipeLeft];
    
    XCUIElement *row7StaticText = tablesQuery/*@START_MENU_TOKEN@*/.staticTexts[@"row:7"]/*[[".cells.staticTexts[@\"row:7\"]",".staticTexts[@\"row:7\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/;
    [row7StaticText swipeLeft];
    [row7StaticText swipeDown];
    [row6StaticText swipeDown];
    [row5StaticText swipeRight];
    [row4StaticText swipeLeft];
    [row4StaticText swipeLeft];
    [row5StaticText swipeUp];
    [tablesQuery/*@START_MENU_TOKEN@*/.staticTexts[@"row:24"]/*[[".cells.staticTexts[@\"row:24\"]",".staticTexts[@\"row:24\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/ tap];
    [row7StaticText tap];
        
    
       

    // Use recording to get started writing UI tests.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
}

@end
