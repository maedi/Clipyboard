//
//  Clippings.h
//  Clipyboard2
//
//  Created by Graham Prichard on 10/03/11.
//  Copyright 2011 Artisan Baker Pty Ltd. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface Clippings : NSView {

	NSArray *_clips;
    NSManagedObjectContext *_context;
	
}


@property (nonatomic, retain) NSArray *clips;
@property (nonatomic, retain) NSManagedObjectContext *context;


@end
