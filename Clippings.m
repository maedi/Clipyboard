//
//  Clippings.m
//  Clipyboard2
//
//  Created by Graham Prichard on 10/03/11.
//  Copyright 2011 Artisan Baker Pty Ltd. All rights reserved.
//

#import "Clippings.h"


@implementation Clippings


@synthesize clips = _clips;
@synthesize context = _context;

- (void)viewDidLoad {

    // [super viewDidLoad];
    
	// fetch
	NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
	NSEntityDescription *entity = [NSEntityDescription 
								   entityForName:@"LocalClip" inManagedObjectContext:_context];
	[fetchRequest setEntity:entity];
	
	NSError *error;
    self.clips = [_context executeFetchRequest:fetchRequest error:&error];
    //self.title = @"Clippings"; 
    [fetchRequest release];		
}

- (id)initWithFrame:(NSRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code here.
    }
    return self;
}

- (void)drawRect:(NSRect)dirtyRect {
    // Drawing code here.
}

- (void) dealloc {

	self.clips = nil;
	self.context = nil;
    [super dealloc];
}
@end
