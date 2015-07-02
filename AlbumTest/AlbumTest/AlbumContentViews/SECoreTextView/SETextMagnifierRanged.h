//
//  SETextMagnifierRanged.h
//  SECoreTextView-iOS
//
//  Created by kishikawa katsumi on 2013/04/26.
//  Copyright (c) 2013 kishikawa katsumi. All rights reserved.
//

#import <TargetConditionals.h>

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@interface SETextMagnifierRanged : UIView

- (void)showInView:(UIView *)view atPoint:(CGPoint)point;
- (void)moveToPoint:(CGPoint)point;
- (void)hide;

@end
