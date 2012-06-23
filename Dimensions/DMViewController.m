//
//  DMViewController.m
//  Dimensions
//
//  Created by Ruiwen Chua on 6/17/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "DMViewController.h"

@implementation DMViewController

@synthesize lines;
@synthesize horizontalLine;

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
	
	self.lines = [[NSMutableArray alloc] init];
}

- (void)viewDidUnload
{
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

- (IBAction)downSwipe:(UITapGestureRecognizer *)recognizer {
	NSLog(@"downSwipe");
}
- (IBAction)rightSwipe:(UITapGestureRecognizer *)recognizer {
	NSLog(@"rightSwipe");
}


- (IBAction)downPan:(UIPanGestureRecognizer *)press {
	
	NSLog(@"Panning: %@", press);
	
	if(press.state == UIGestureRecognizerStateBegan) {
		NSLog(@"longPress: %@", press);
		NSLog(@"Coordinate X:%f, Y:%f", [press locationInView:self.view].x, [press locationInView:self.view].y);
		
		[[NSBundle mainBundle] loadNibNamed:@"HorizontalLineView" owner:self options:nil];
		
		[self.view addSubview:self.horizontalLine]; // Add horizontalLine view as subview first, so it can retrieve touch coordinates with respect to our main view
		[self.horizontalLine updateLocation:[press locationInView:self.view].y];
		[self.lines addObject:self.horizontalLine];
		
		//self.horizontalLine = nil;
		
	}
	else if (press.state == UIGestureRecognizerStateChanged) {
		
		[self.horizontalLine updateLocation:[press locationInView:self.view].y];
	}
	
	else if(press.state == UIGestureRecognizerStateEnded) {
	
		self.horizontalLine = nil; // Nullify
	}
}

@end
