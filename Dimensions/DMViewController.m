//
//  DMViewController.m
//  Dimensions
//
//  Created by Ruiwen Chua on 6/17/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "DMViewController.h"
#import <QuartzCore/QuartzCore.h>

@interface DMViewController () 

@property (strong, nonatomic) UIActionSheet *as;

@property (strong , nonatomic) NSDictionary *mediaInfo;

- (void)captureImageWithSource:(UIImagePickerControllerSourceType)source;
- (void)showCaptureActionSheet;
- (void)showIU:(BOOL)show;

@end


@implementation DMViewController

@synthesize as;
@synthesize mediaInfo;

@synthesize horizontalPan;
@synthesize verticalPan;
@synthesize tapGesture;

@synthesize uiShowing;

@synthesize lines;
@synthesize horizontalLine;
@synthesize verticalLine;
@synthesize chooseButton;
@synthesize imageView;
@synthesize controls;

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - UIActionSheetDelegate methods
- (void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex {
	
	NSString *action = [as buttonTitleAtIndex:buttonIndex];
	
	if(action == @"Camera"){
		// Activate the camera
		[self captureImageWithSource:UIImagePickerControllerSourceTypeCamera];
	}
	else if (action == @"Photo Library"){
		// Show the photo library
		[self captureImageWithSource:UIImagePickerControllerSourceTypeSavedPhotosAlbum];
	} 
}

#pragma mark - Utility methods

- (void)captureImageWithSource:(UIImagePickerControllerSourceType)source {
	
	// Create image picker controller
	UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
	
	// Set source to the camera
	imagePicker.sourceType = source;
	
	//Default using the front camera
	//imagePicker.cameraDevice = UIImagePickerControllerCameraDeviceBack;
	
	// Delegate is self
	imagePicker.delegate = self;
	
	// Show image picker
	[self presentModalViewController:imagePicker animated:YES];
	
}

- (void)showCaptureActionSheet {
	// Describe the UIActionSheet
	as = [[UIActionSheet alloc] initWithTitle:@"Select image" 
									 delegate:self 
							cancelButtonTitle:nil 
					   destructiveButtonTitle:nil 
							otherButtonTitles:nil];
	
	// Let's see what options we have
	if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
		[as addButtonWithTitle:@"Camera"];
	}
	if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeSavedPhotosAlbum]) {
		[as addButtonWithTitle:@"Photo Library"];
	}
	
	// Manually add the Cancel button, instead of using the initializer above
	as.cancelButtonIndex = [as addButtonWithTitle:@"Cancel"];
	
	as.actionSheetStyle = UIActionSheetStyleBlackTranslucent;
	[as showInView:self.view];
	//[as showFromTabBar:self.tabBarController.tabBar]; // Show the ActionSheet
}


- (void)showIU:(BOOL)show {
	
	// Don't do anything if there's no image showing
	if(!show && !imageView.image ) { return; }
	
	// Get the frame for the control bar
	CGRect frame = self.controls.frame;
	frame.origin.y = (show) ? 436 : 480;
	
	// Set its z-index to the top
	[self.view bringSubviewToFront:self.controls];
	
	[UIView animateWithDuration:0.4
						  delay:0.0
						options: UIViewAnimationOptionCurveEaseIn
					 animations:^{
						 self.controls.frame = frame;
					 } completion:^(BOOL finished) {
						 NSLog(@"Done hiding");
					 }];

	// Toggle the flag
	self.uiShowing = !self.uiShowing;
}

#pragma mark - UIImagePickerController Delegate
// Image picker delegate
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
	
	// Assign to controller variable
	self.mediaInfo = info;
	NSLog(@"Media info: %@", self.mediaInfo);
	
	// Code here to work with media
	UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
	
	//Set taken image to the image from the picker
	[self.imageView setImage:image];
	
	//Need to dismiss camera picker with NO animation to be able to segue to the next controller
	[self dismissModalViewControllerAnimated:YES];
	//Need to save to local app a copy of the image.
	//	[self performSegueWithIdentifier:@"FeaturedToCreateOwnPose" sender:self];
	
	[[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationSlide];
	
	// Hide the UI
	[self showIU:NO];
}

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
	[self dismissModalViewControllerAnimated:YES];
}



#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
	
	self.uiShowing = YES;
	
	self.horizontalPan.direction = RCPanGestureRecognizerHorizontal;
	self.verticalPan.direction = RCPanGestureRecognizerVertical;
	
	self.lines = [[NSMutableArray alloc] init];
}

- (void)viewDidUnload
{
	[self setHorizontalPan:nil];
	[self setVerticalPan:nil];
	[self setHorizontalLine:nil];
	[self setVerticalLine:nil];
	[self setChooseButton:nil];
	[self setImageView:nil];
	[self setControls:nil];
	[self setTapGesture:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
	return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

- (IBAction)horizontalPan:(RCDirectionalPanGestureRecognizer *)press {

	NSLog(@"Horizontal Pan: %@", press);
	
	if(press.state == UIGestureRecognizerStateBegan) {
		NSLog(@"Coordinate X:%f, Y:%f", [press locationInView:self.view].x, [press locationInView:self.view].y);
		
		[[NSBundle mainBundle] loadNibNamed:@"VerticalLineView" owner:self options:nil];
		
		[self.view addSubview:self.verticalLine]; // Add verticalLine view as subview first, so it can retrieve touch coordinates with respect to our main view
		[self.verticalLine setConstraint:DMLineConstrainX];
		[self.verticalLine updateLocation:[press locationInView:self.view]];
		[self.lines addObject:self.verticalLine];
		
		//self.horizontalLine = nil;
		
	}
	else if (press.state == UIGestureRecognizerStateChanged) {
		
		[self.verticalLine updateLocation:[press locationInView:self.view]];
	}
	
	else if(press.state == UIGestureRecognizerStateEnded) {
		
		self.verticalLine = nil; // Nullify
	}
	
}


- (IBAction)verticalPan:(RCDirectionalPanGestureRecognizer *)press {
	
	NSLog(@"Vertical Pan: %@", press);
	
	if(press.state == UIGestureRecognizerStateBegan) {
		NSLog(@"Coordinate X:%f, Y:%f", [press locationInView:self.view].x, [press locationInView:self.view].y);
		
		[[NSBundle mainBundle] loadNibNamed:@"HorizontalLineView" owner:self options:nil];
		
		[self.view addSubview:self.horizontalLine]; // Add horizontalLine view as subview first, so it can retrieve touch coordinates with respect to our main view
		[self.horizontalLine setConstraint:DMLineConstrainY];
		[self.horizontalLine updateLocation:[press locationInView:self.view]];
		[self.lines addObject:self.horizontalLine];
		
		//self.horizontalLine = nil;
		
	}
	else if (press.state == UIGestureRecognizerStateChanged) {
		
		[self.horizontalLine updateLocation:[press locationInView:self.view]];
	}
	
	else if(press.state == UIGestureRecognizerStateEnded) {
	
		self.horizontalLine = nil; // Nullify
	}
}

- (IBAction)chooseButton:(id)sender {
	[self showCaptureActionSheet];
}

- (IBAction)clearLines:(id)sender {
	
	// Kill _ALL_ the lines!
	[self.lines makeObjectsPerformSelector:@selector(removeFromSuperview)];	
	[self.lines removeAllObjects];
}

- (IBAction)tapGesture:(id)sender {
	
	[self showIU:!self.uiShowing];
}

@end
