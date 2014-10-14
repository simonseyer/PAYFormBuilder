//
//  PAYRegistrationFormTest.m
//  Example
//
//  Created by Simon Seyer on 15.05.14.
//  Copyright (c) 2014 Paij. All rights reserved.
//

#import "PAYRegistrationFormTest.h"
#import <KIF/KIF.h>
#import "KIFUITestActor+PAYComfort.h"
#import "NSError-KIFAdditions.h"

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
    
    // Check
    UITextField *userNameField = (UITextField *)[tester waitForViewWithAccessibilityLabel:@"usernameField"];
    if (!userNameField.isFirstResponder) {
        [tester failWithError:[NSError KIFErrorWithFormat:@"userNameField should be the first responder."]
                     stopTest:YES];
    }
}

- (void)test_B_jumpToNextField {
    // Enter value
    [tester enterText:@"Donald" intoViewWithAccessibilityLabel:@"usernameField"];
    
    // IMPORTANT: this test only succeeds with an english keyboard
    [tester tapViewWithAccessibilityLabel:@"next"];
    
    // Check
    UITextField *pwField = (UITextField *)[tester waitForViewWithAccessibilityLabel:@"passwordField"];
    if (!pwField.isFirstResponder) {
        [tester failWithError:[NSError KIFErrorWithFormat:@"pwField should be the first responder."]
                     stopTest:YES];
    }
}

- (void)test_C_passwordEqualFail {
    // Enter values
    [tester clearTextFromAndThenEnterText:@"teststreet" intoViewWithAccessibilityLabel:@"streetField"];
    [tester clearTextFromAndThenEnterText:@"123456" intoViewWithAccessibilityLabel:@"postalCodeField"];
    [tester clearTextFromAndThenEnterText:@"testcity" intoViewWithAccessibilityLabel:@"cityField"];
    UISwitch *switchUI = (UISwitch *)[tester waitForViewWithAccessibilityLabel:@"termsSwitch"];
    [switchUI setOn:YES animated:NO];
    
    // Scrolls to the top so the password field is in the visible area. Otherwise KIF could not tap on the view.
    UITableView *tableView = (UITableView *) [tester waitForViewWithAccessibilityLabel:@"PAYFormTable"];
    [tableView scrollRectToVisible:CGRectMake(0, 0, 1, 1) animated:NO];
    
    [tester enterText:@"abcd" intoViewWithAccessibilityLabel:@"passwordField"];
    [tester enterText:@"1234" intoViewWithAccessibilityLabel:@"password2Field"];
    
    [tester tapViewWithAccessibilityLabel:@"Done"];
    
    // Check
    [tester waitForViewWithAccessibilityLabel:@"Password wrong"];
    [tester waitForViewWithAccessibilityLabel:@"Please enter the same password again"];
    
    // Reset
    [tester tapViewWithAccessibilityLabel:@"Ok"];
}

- (void)test_D_passwordEqual {
    // Enter values
    [tester clearTextFromAndThenEnterText:@"abcd" intoViewWithAccessibilityLabel:@"password2Field"];
    
    [tester tapViewWithAccessibilityLabel:@"Done"];
    
    // Check
    [tester checkForAbsenceOfViewWithAccessibilityLabel:@"Password wrong"];
    [tester checkForAbsenceOfViewWithAccessibilityLabel:@"Please enter the same password again"];
    
    // Reset
    [tester tapViewWithAccessibilityLabel:@"Ok"];
}

- (void)test_E_customSwitchErrorMessage {
    // Enter values
    UISwitch *switchUI = (UISwitch *)[tester waitForViewWithAccessibilityLabel:@"termsSwitch"];
    [switchUI setOn:NO animated:NO];

    [tester tapViewWithAccessibilityLabel:@"Done"];
    
    // Check
    [tester waitForViewWithAccessibilityLabel:@"Accept"];
    [tester waitForViewWithAccessibilityLabel:@"Please accept the terms and conditions to continue"];
    
    // Reset
    [tester tapViewWithAccessibilityLabel:@"Ok"];
    [switchUI setOn:YES animated:NO];
}

- (void)test_F_cleanedValue {
    // Enter values
    [tester clearTextFromAndThenEnterText:@"123 456 789" intoViewWithAccessibilityLabel:@"postalCodeField"];
    
    [tester tapViewWithAccessibilityLabel:@"Done"];
    
    // Check
    [tester waitForViewWithAccessibilityLabel:@"Success"];
    [tester waitForViewWithAccessibilityLabel:@"Well done, Donald. Here your cleaned postal code: 123456789. Country code: usa"];
    
    // Reset
    [tester tapViewWithAccessibilityLabel:@"Ok"];
}

- (void)test_G_singleSelection {
    // Enter values
    [tester tapViewWithAccessibilityLabel:@"Germany"];
    
    [tester tapViewWithAccessibilityLabel:@"Done"];
    
    // Check
    [tester waitForViewWithAccessibilityLabel:@"Success"];
    [tester waitForViewWithAccessibilityLabel:@"Well done, Donald. Here your cleaned postal code: 123456789. Country code: de"];
    
    // Reset
    [tester tapViewWithAccessibilityLabel:@"Ok"];
}

- (void)test_H_finishOnLasField {
    // Enter values
    [tester tapViewWithAccessibilityLabel:@"cityField"];
    
    [tester tapViewWithAccessibilityLabel:@"Done"]; // keyboard done
    
    // Check
    [tester waitForViewWithAccessibilityLabel:@"Success"];
    
    // Reset
    [tester tapViewWithAccessibilityLabel:@"Ok"];
}

@end
