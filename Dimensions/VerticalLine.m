//
//  VerticalLine.m
//  Dimensions
//
//  Created by Ruiwen Chua on 6/24/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "VerticalLine.h"

#define LINE_OFFSET_X 46

#define LABEL_X_ORIG 52
#define LABEL_X_ALT 0

#define LINE_X_THRESHOLD 274.0

@implementation VerticalLine
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

- (void)updateLocationX:(CGPoint)point {

	CGRect frame = self.frame;	
	CGRect labelFrame = self.label.frame;

	if(point.x >= LINE_X_THRESHOLD) {		
		labelFrame.origin.x = LABEL_X_ALT;
	}
	else {
		labelFrame.origin.x = LABEL_X_ORIG;
	}
	
	self.label.frame = labelFrame;
	frame.origin.x = point.x - LINE_OFFSET_X;
	
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
