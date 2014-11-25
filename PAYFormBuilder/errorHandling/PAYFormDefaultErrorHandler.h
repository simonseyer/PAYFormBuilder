//
//  DefaultErrorHandler.h
//  PAYFormBuilder
//
//  Created by Simon Seyer on 11.04.14.
//  Copyright (c) 2014 Paij. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PAYFormTable.h"

/**
 *  An error handler that displays dialogs for errors.
 */
@interface PAYFormDefaultErrorHandler : NSObject <PAYFormTableErrorDelegate>

/**
 *  Set the text of the button that is used to hide the dialog
 *
 *  @param text the text
 */
+ (void)setButtonText:(NSString *)text;


@end
