/**
 * Readium
 *
 * Created by Your Name
 * Copyright (c) 2015 Your Company. All rights reserved.
 */

#import "ComCentogramReadiumModule.h"
#import "ComCentogramReadiumViewController.h"
#import <AVFoundation/AVFoundation.h>

@implementation ComCentogramReadiumModule

#pragma mark Internal

// this is generated for your module, please do not change it
-(id)moduleGUID
{
	return @"4d37f616-86ad-4bc9-8693-f545a10a5f79";
}

// this is generated for your module, please do not change it
-(NSString*)moduleId
{
	return @"com.centogram.readium";
}

#pragma mark Lifecycle

-(void)startup
{
	// this method is called when the module is first loaded
	// you *must* call the superclass
    [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayback error:nil];
	[super startup];

	NSLog(@"[INFO] %@ loaded",self);
}

-(void)shutdown:(id)sender
{
	// this method is called when the module is being unloaded
	// typically this is during shutdown. make sure you don't do too
	// much processing here or the app will be quit forceably

	// you *must* call the superclass
    
	[super shutdown:sender];
}

#pragma mark Cleanup

-(void)dealloc
{
	// release any resources that have been retained by the module
}

#pragma mark Internal Memory Management

-(void)didReceiveMemoryWarning:(NSNotification*)notification
{
	// optionally release any resources that can be dynamically
	// reloaded once memory is available - such as caches
	[super didReceiveMemoryWarning:notification];
}

#pragma mark Listener Notifications

-(void)_listenerAdded:(NSString *)type count:(int)count
{
	if (count == 1 && [type isEqualToString:@"my_event"])
	{
		// the first (of potentially many) listener is being added
		// for event named 'my_event'
	}
}

-(void)_listenerRemoved:(NSString *)type count:(int)count
{
	if (count == 0 && [type isEqualToString:@"my_event"])
	{
		// the last listener called for event named 'my_event' has
		// been removed, we can optionally clean up any resources
		// since no body is listening at this point for that event
	}
}

#pragma Public APIs


-(void)open:(id)args
{
    ENSURE_UI_THREAD(open, nil);
    readerViewController=[[ReaderViewController alloc] initWithArray:[ContainerList shared].paths];
    //NSLog(@"[INFO] %@ paths",[ContainerList shared].paths);
    readerViewController.title=@"Epub Reader";

    UINavigationController *EpudReaderController = [[ComCentogramReadiumViewController alloc] initWithRootViewController:readerViewController];

    [[TiApp app] showModalController: EpudReaderController animated: YES];
}

@end
