//
//  PAYFormErrorMessage_protected.h
//  PAYFormBuilder
//
//  Created by Simon Seyer on 14.07.14.
//  Copyright (c) 2014 Paij. All rights reserved.
//

#import "PAYFormErrorMessageManager.h"

@class PAYFormErrorMessage;

@interface PAYFormErrorMessageManager ()

+ (PAYFormErrorMessage *)errorMessageForError:(NSError *)error;

@end
