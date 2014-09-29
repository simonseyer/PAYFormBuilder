//
//  PAYRegistrationFormTest.m
//  Example
//
//  Created by Simon Seyer on 15.05.14.
//  Copyright (c) 2014 Paij. All rights reserved.
//

#import "PAYRegistrationFormTest.h"
#import <KIF/KIF.h>
#import "KIFTestCase+PAYComfort.h"

@implementation PAYRegistrationFormTest


- (void)setUp {
    [super setUp];
    
   self.stopTestsOnFirstBigFailure = YES;
}

- (void)beforeAll {
    [super beforeAll];
    
    [tester tapViewWithAccessibilityLabel:@"Registration form"];
}

- (void)afterAll {
    [super afterAll];
    [tester tapViewWithAccessibilityLabel:@"Back"];
}

- (void)test_A_firstFieldIsSelected {
    [tester waitForTimeInterval:0.1];
    UITextField *userNameField = (UITextField *)[tester waitForViewWithAccessibilityLabel:@"usernameField"];
    if (!userNameField.isFirstResponder) {
        [tester fail];
    }
}

- (void)test_B_jumpToNextField {
    [tester enterText:@"Donald" intoViewWithAccessibilityLabel:@"usernameField"];
    // This test only succeeds with an english keyboard
    [tester tapViewWithAccessibilityLabel:@"next"];
    UITextField *pwField = (UITextField *)[tester waitForViewWithAccessibilityLabel:@"passwordField"];
    if (!pwField.isFirstResponder) {
        [tester fail];
    }
}

- (void)test_C_passwordEqualFail {
    // prerequisits
    [tester clearTextFromAndThenEnterText:@"teststreet" intoViewWithAccessibilityLabel:@"streetField"];
    [tester clearTextFromAndThenEnterText:@"123456" intoViewWithAccessibilityLabel:@"postalCodeField"];
    [tester clearTextFromAndThenEnterText:@"testcity" intoViewWithAccessibilityLabel:@"cityField"];
    UISwitch *switchUI = (UISwitch *)[tester waitForViewWithAccessibilityLabel:@"termsSwitch"];
    [switchUI setOn:YES animated:YES];
    
    // Scrolls to the top so the password field is in the visible area. Otherwise KIF could not tap on the view.
    UITableView *tableView = (UITableView *) [tester waitForViewWithAccessibilityLabel:@"PAYFormTable"];
    [tableView scrollRectToVisible:CGRectMake(0, 0, 1, 1) animated:NO];
    
    // test
    [tester enterText:@"abcd" intoViewWithAccessibilityLabel:@"passwordField"];
    [tester enterText:@"1234" intoViewWithAccessibilityLabel:@"password2Field"];
    
    [tester tapViewWithAccessibilityLabel:@"Done"];
    if ([self findViewWithLabel:@"Password wrong"] && [self findViewWithLabel:@"Please enter the same password again"]) {
        [tester tapViewWithAccessibilityLabel:@"Ok"];
    } else {
        [tester fail];
    }
}

- (void)test_D_passwordEqual {
   // [tester tapViewWithAccessibilityLabel:@"passwordField"]; // not clear, why this is needed
    [tester clearTextFromAndThenEnterText:@"abcd" intoViewWithAccessibilityLabel:@"password2Field"];
    
    [tester tapViewWithAccessibilityLabel:@"Done"];
    if ([self findViewWithLabel:@"Password wrong"] && [self findViewWithLabel:@"Please enter the same password again"]) {
        [tester fail];
    } else {
        [tester tapViewWithAccessibilityLabel:@"Ok"];
        
    }
}

- (void)test_E_customSwitchErrorMessage {
    UISwitch *switchUI = (UISwitch *)[tester waitForViewWithAccessibilityLabel:@"termsSwitch"];
    [switchUI setOn:NO animated:YES];

    [tester tapViewWithAccessibilityLabel:@"Done"];
    if ([self findViewWithLabel:@"Accept"] && [self findViewWithLabel:@"Please accept the terms and conditions to continue"]) {
        [tester tapViewWithAccessibilityLabel:@"Ok"];
        [switchUI setOn:YES animated:YES];
    } else {
        [tester fail];
    }
}

- (void)test_F_cleanedValue {
    [tester clearTextFromAndThenEnterText:@"123 456 789" intoViewWithAccessibilityLabel:@"postalCodeField"];
    
    [tester tapViewWithAccessibilityLabel:@"Done"];
    if ([self findViewWithLabel:@"Success"] && [self findViewWithLabel:@"Well done, Donald. Here your cleaned postal code: 123456789. Country code: usa"]) {
        [tester tapViewWithAccessibilityLabel:@"Ok"];
    } else {
        [tester fail];
    }
}

- (void)test_G_singleSelection {
    [tester tapViewWithAccessibilityLabel:@"Germany"];
    
    [tester tapViewWithAccessibilityLabel:@"Done"];
    if ([self findViewWithLabel:@"Success"] && [self findViewWithLabel:@"Well done, Donald. Here your cleaned postal code: 123456789. Country code: de"]) {
        [tester tapViewWithAccessibilityLabel:@"Ok"];
    } else {
        [tester fail];
    }
}

- (void)test_H_finishOnLasField {
    [tester tapViewWithAccessibilityLabel:@"cityField"];
    
    [tester tapViewWithAccessibilityLabel:@"Done"]; // keyboard done
    if ([self findViewWithLabel:@"Success"]) {
        [tester tapViewWithAccessibilityLabel:@"Ok"];
    } else {
        [tester fail];
    }
}

@end
