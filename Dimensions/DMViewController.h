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


@interface DMViewController : UIViewController <UIImagePickerControllerDelegate, UIActionSheetDelegate, UIGestureRecognizerDelegate>

@property (strong, nonatomic) NSMutableArray *lines;
@property (assign, nonatomic) IBOutlet DMLine *line;
@property (strong, nonatomic) IBOutlet UIButton *chooseButton;
@property (strong, nonatomic) IBOutlet UIImageView *imageView;
@property (strong, nonatomic) IBOutlet UIView *controls;

@property (strong, nonatomic) IBOutlet RCDirectionalPanGestureRecognizer *horizontalPan;
@property (strong, nonatomic) IBOutlet RCDirectionalPanGestureRecognizer *verticalPan;
@property (strong, nonatomic) IBOutlet UITapGestureRecognizer *tapGesture;

@property BOOL uiShowing;

- (IBAction)horizontalPan:(RCDirectionalPanGestureRecognizer *)press;
- (IBAction)verticalPan:(RCDirectionalPanGestureRecognizer *)press;
- (IBAction)chooseButton:(id)sender;
- (IBAction)clearLines:(id)sender;
- (IBAction)tapGesture:(id)sender;

- (void)receiveLineNotification:(NSNotification *)notification;

@end
