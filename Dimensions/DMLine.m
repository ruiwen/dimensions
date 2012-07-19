//
//  DMLine.m
//  Dimensions
//
//  Created by Ruiwen Chua on 6/25/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "DMLine.h"

#define LINE_OFFSET_Y self.frame.size.height

@interface DMLine ()

- (void)updateLocationY:(CGPoint)point;
- (void)updateLocationX:(CGPoint)point;

@end

@implementation DMLine

@synthesize line;
@synthesize label;
@synthesize longPress;

@synthesize constraint = _constraint;

- (id)initWithCoder:(NSCoder *)aDecoder {
	
	if(self = [super initWithCoder:aDecoder]) {

		// Set up the gesture recognizer on init
		[self setLongPress:[[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressAction:)]];
		self.longPress.minimumPressDuration = 0.3;
		
		self.longPress.delegate = self; // Set to self, so we can override the default gestureRecognizer:shouldRecognizeSimultaneouslyWithGestureRecognizer:
		
		[self addGestureRecognizer:self.longPress];
		
	}
	return self;
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
	
	return YES;
}

- (void)updateLocation:(CGPoint)point {
	
	if(self.constraint == DMLineConstrainY) { // Constrain in the y-axis
		[self updateLocationY:point];
	}
	else if(self.constraint == DMLineConstrainX) { // Constrain in the x-axis
		[self updateLocationX:point];
	}
}

- (void)updateLocationY:(CGPoint)point {

	CGRect frame = self.frame;
	frame.origin.y = point.y - LINE_OFFSET_Y;
	[self.label setText:[NSString stringWithFormat:@"%3.0f", point.y]];

	[self setFrame:frame];
}


- (void)updateLocationX:(CGPoint)point {
	
	CGRect frame = self.frame;
	frame.origin.x = point.x;
	[self.label setText:[NSString stringWithFormat:@"%3.0f", point.x]];
	
	[self setFrame:frame];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

-(void)longPressAction:(UILongPressGestureRecognizer *)press {
	
	if(press.state == UIGestureRecognizerStateBegan) {
		// Indicate that this Line is ready to be moved
		[UIView animateWithDuration:0.2
						 animations:^{
							 self.line.backgroundColor = LINE_COLOUR_ALT;
						 }];
		
		[[NSNotificationCenter defaultCenter] postNotificationName:@"LineActivated" object:self];

	}
	else if(press.state == UIGestureRecognizerStateEnded) {
		// Indicate that this Line is now fixed
		[UIView animateWithDuration:0.2
						 animations:^{
							 self.line.backgroundColor = LINE_COLOUR_ORIG;
						 }];
		
		[[NSNotificationCenter defaultCenter] postNotificationName:@"LineDeactivated" object:self];
			
	}
}

@end
