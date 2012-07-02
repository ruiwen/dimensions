//
//  DMAppDelegate.m
//  Dimensions
//
//  Created by Ruiwen Chua on 6/17/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "DMAppDelegate.h"

// Dispatch period in seconds
static const NSInteger kGANDispatchPeriodSec = 10;

@implementation DMAppDelegate

@synthesize window = _window;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
 
	// Initialise Google Analytics
	[[GANTracker sharedTracker] startTrackerWithAccountID:@"UA-33090628-1"
										   dispatchPeriod:kGANDispatchPeriodSec
												 delegate:nil];
	
	
	// Set NSUserDefault with the unique UUID
	NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
	if (![defaults objectForKey:@"appID"]) {
		//If the app ID does not exist, create one and save to defaults
		CFUUIDRef uuID = CFUUIDCreate(NULL);
		CFStringRef idStringRef = CFUUIDCreateString(NULL, uuID);
		// Cast to NSString to silence warning
		NSString *idString = (__bridge NSString *)idStringRef;
		//Set to NSUserDefault and synchronize
		[defaults setObject:idString forKey:@"appID"];
		[defaults synchronize];
	}
	
	
	// GA - Log unique ID
	NSError *error;
	if(![[GANTracker sharedTracker] setCustomVariableAtIndex:1 name:@"user" value:[defaults objectForKey:@"appID"] withError:&error]) {
		// Handler error
	}
	
	
	return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
	/*
	 Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
	 Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
	 */
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
	/*
	 Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
	 If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
	 */
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
	/*
	 Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
	 */
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
	/*
	 Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
	 */
}

- (void)applicationWillTerminate:(UIApplication *)application
{
	/*
	 Called when the application is about to terminate.
	 Save data if appropriate.
	 See also applicationDidEnterBackground:.
	 */
}

@end
