//
//  DMViewController.h
//  Dimensions
//
//  Created by Ruiwen Chua on 6/17/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HorizontalLine.h"
#import "VerticalLine.h"
#import "RCDirectionalPanGestureRecognizer.h"


@interface DMViewController : UIViewController

@property (strong, nonatomic) NSMutableArray *lines;
@property (weak,nonatomic) IBOutlet HorizontalLine *horizontalLine;
@property (weak, nonatomic) IBOutlet VerticalLine *verticalLine;

@property (strong, nonatomic) IBOutlet RCDirectionalPanGestureRecognizer *horizontalPan;
@property (strong, nonatomic) IBOutlet RCDirectionalPanGestureRecognizer *verticalPan;

- (IBAction)horizontalPan:(RCDirectionalPanGestureRecognizer *)press;
- (IBAction)verticalPan:(RCDirectionalPanGestureRecognizer *)press;

@end
