//
//  DMLine.h
//  Dimensions
//
//  Created by Ruiwen Chua on 6/25/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

#define LINE_COLOUR_ORIG [UIColor redColor]
#define LINE_COLOUR_ALT [UIColor greenColor]

typedef enum {
    DMLineConstrainX,
    DMLineConstrainY
} DMLineConstraint;

@interface DMLine : UIView <UIGestureRecognizerDelegate> {

	DMLineConstraint _constraint;
}

@property (strong, nonatomic) IBOutlet UIView *line;
@property (strong, nonatomic) IBOutlet UILabel *label;
@property (assign, nonatomic) DMLineConstraint constraint;
@property (strong, nonatomic) UILongPressGestureRecognizer *longPress;

- (void)longPressAction:(UILongPressGestureRecognizer *)press;
- (void)updateLocation:(CGPoint)point;

@end
