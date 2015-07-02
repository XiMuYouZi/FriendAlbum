//
//  SECompatibility.h
//  SECoreTextView
//
//  Created by kishikawa katsumi on 2013/04/21.
//  Copyright (c) 2013 kishikawa katsumi. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <UIKit/UIKit.h>

@compatibility_alias NSView UIView;
@compatibility_alias NSColor UIColor;
@compatibility_alias NSBezierPath UIBezierPath;
@compatibility_alias NSImage UIImage;

typedef UIEdgeInsets NSEdgeInsets;

#define NSEdgeInsetsMake UIEdgeInsetsMake
#define NSRectFill UIRectFill
#define NSStringFromRect NSStringFromCGRect
#define NSStringFromSize NSStringFromCGSize
#define NSTextInputClient UITextInput

extern NSString * const NSLinkAttributeName;
extern NSString * const NSStrikethroughStyleAttributeName;


@interface SECompatibility : NSObject

@end
