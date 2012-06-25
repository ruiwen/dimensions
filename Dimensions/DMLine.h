//
//  DMLine.h
//  Dimensions
//
//  Created by Ruiwen Chua on 6/25/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    DMLineConstrainX,
    DMLineConstrainY
} DMLineConstraint;

@interface DMLine : UIView {

	DMLineConstraint _constraint;
}

@property (strong, nonatomic) IBOutlet UIView *line;
@property (strong, nonatomic) IBOutlet UILabel *label;
@property (assign, nonatomic) DMLineConstraint constraint;

- (void)updateLocation:(CGPoint)point;

@end
