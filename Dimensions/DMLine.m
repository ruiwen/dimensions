//
//  DMLine.m
//  Dimensions
//
//  Created by Ruiwen Chua on 6/25/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "DMLine.h"

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
	
	CGRect frame = self.frame;

	if(self.constraint == DMLineConstrainY) { // Constrain in the y-axis
		frame.origin.y = point.y - frame.size.height;
		[self.label setText:[NSString stringWithFormat:@"%3.0f", point.y]];
	}
	else if(self.constraint == DMLineConstrainX) { // Constrain in the x-axis
		frame.origin.x = point.x;
		[self.label setText:[NSString stringWithFormat:@"%3.0f", point.x]];
	}
	
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
