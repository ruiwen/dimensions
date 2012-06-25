//
//  HorizontalLine.m
//  Dimensions
//
//  Created by Ruiwen Chua on 6/17/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "HorizontalLine.h"

@implementation HorizontalLine
@synthesize line;
@synthesize label;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/


//- (void)withGesture:(UIGestureRecognizer *)press {
//
//	CGPoint touch = [press locationInView:self.superview];
//
//	// Set the frame
//	CGRect frame = self.frame;	
//	frame.origin.y = touch.y - frame.size.height; // Set the same y coordinate
//
//	// Set the label
//	NSLog(@"touch.y: %f", touch.y);
//	[self.label setText:[NSString stringWithFormat:@"%3.0f", touch.y]];
//	
//	[self setFrame:frame];
//}

@end
