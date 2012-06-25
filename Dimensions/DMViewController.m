//
//  DMViewController.m
//  Dimensions
//
//  Created by Ruiwen Chua on 6/17/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "DMViewController.h"

@implementation DMViewController
@synthesize horizontalPan;
@synthesize verticalPan;

@synthesize lines;
@synthesize horizontalLine;
@synthesize verticalLine;

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
	
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

@end
