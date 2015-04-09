//
//  PAYTableTheme.h
//  Pods
//
//  Created by COBI on 09.04.15.
//
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol PAYTableTheme <NSObject>

- (CGFloat)labelStyleNoneHeight;
- (CGFloat)labelStyleEmptyHeight;
- (CGFloat)infoIconMargin;

@end
