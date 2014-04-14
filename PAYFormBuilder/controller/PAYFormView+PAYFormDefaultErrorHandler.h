//
//  PAYFormView+PAYFormDefaultErrorHandler.h
//  PAYFormBuilder
//
//  Created by Simon Seyer on 14.04.14.
//  Copyright (c) 2014 Paij. All rights reserved.
//

#import "PAYFormView.h"
#import "PAYFormBuilder.h"
#import "PAYFormDefaultErrorHandler.h"

@interface PAYFormView (PAYFormDefaultErrorHandler)

+ (void)setErrorMessage:(PAYFormErrorMessage *)errorMessage forErrorCode:(NSUInteger)code;
- (void)setErrorMessage:(PAYFormErrorMessage *)errorMessage forErrorCode:(NSUInteger)code;
- (PAYFormErrorMessage *)errorMessageForErrorCode:(NSUInteger)code;

@end
