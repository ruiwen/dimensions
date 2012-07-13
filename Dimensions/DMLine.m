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

@synthesize constraint = _constraint;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
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

@end
