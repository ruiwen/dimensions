//
//  HorizontalLine.h
//  Dimensions
//
//  Created by Ruiwen Chua on 6/17/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HorizontalLine : UIView
@property (strong, nonatomic) IBOutlet UIView *line;
@property (strong, nonatomic) IBOutlet UILabel *label;

- (void)withGesture:(UIGestureRecognizer *)press;
- (void)updateLocation:(float)y;

@end
