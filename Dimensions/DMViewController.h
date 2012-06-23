//
//  DMViewController.h
//  Dimensions
//
//  Created by Ruiwen Chua on 6/17/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HorizontalLine.h"

@interface DMViewController : UIViewController

@property (strong, nonatomic) NSMutableArray *lines;
@property (weak,nonatomic) IBOutlet HorizontalLine *horizontalLine;


- (IBAction)downPan:(UIPanGestureRecognizer *)press;

@end
