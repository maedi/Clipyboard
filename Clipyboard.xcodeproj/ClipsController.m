//
//  ClipsController.m
//  Clipyboard
//
//  Created by Maedi

#import "CoreData.h"
#import "ClipsController.h"

@implementation ClipsController

@synthesize fetchRequest;
@synthesize entity;
@synthesize app;

- (id) init {
    
    // LOAD THE SINGLETON APP OBJECT
    app = [AppController sharedAppController];
    fetchRequest = app.fetchRequest;
    
    // LOAD CLIP MODEL ENTITY
    entity = [NSEntityDescription entityForName:@"Clip" inManagedObjectContext:app.context];
    
    return self;
}

// SAVING CLIPPINGS
- (void) save
{
	// IF NEW CLIP
    if ([app.pasteboard.lastCount intValue] != [app.pasteboard nowCount]) {
		
        // update last count to match current count, another clip won't be created 'till new app.pasteboard activity
        app.pasteboard.lastCount = [NSNumber numberWithInt:[app.pasteboard nowCount]];
        
        // CREATE CLIP OBJECT
		
		// client
        Clip *clip = [NSEntityDescription insertNewObjectForEntityForName:@"Clip" inManagedObjectContext:app.context];
		clip.text = [app.pasteboard text];
		clip.createdAt = [NSDate date];
		clip.type = @"text";
        clip.clipId = @"77776";
        clip.typeNS = [app.pasteboard typeNS];

        // SAVE CLIP OBJECT
        NSError *error;
        if (![app.context save:&error]) {
            NSLog(@"Whoops, couldn't save: %@", [error localizedDescription]);
        }
        else {
            NSLog(@"Saved #%i: %@", [app.pasteboard.lastCount intValue], [app.pasteboard text]);
        }
	}
}

- (void) show
{    
    // SETUP RESULTS
    NSError *error = nil;
    
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"createdAt"  ascending:NO];
    NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:sortDescriptor, nil];
    
    NSFetchRequest *showFetchRequest = [[NSFetchRequest alloc] init];
	[showFetchRequest setEntity:entity];
    [showFetchRequest setFetchLimit:25];
    [showFetchRequest setSortDescriptors:sortDescriptors];

    NSArray *fetchedObjects = [app.context executeFetchRequest:showFetchRequest error:&error];
    
    // reverse array as menu built from bottom up
    fetchedObjects = [[fetchedObjects reverseObjectEnumerator] allObjects];

    NSUInteger count = [app.context countForFetchRequest:showFetchRequest error: &error];

    // DISPLAY EACH CLIPPING
    for (Clip *clip in fetchedObjects) {
        
        //System/Library/CoreServices/CoreTypes.bundle->Contents/Resources
        //NSLog(@"Displaying Core Data: %@", clip.text);
        
        // display length
        NSString *original = clip.text;
        int displayLength = 50;
        NSString *display;
        
        if (original.length > displayLength) {
            
            display = [[original substringToIndex:displayLength] stringByAppendingString: @"..."];
        }
        else display = [[NSString alloc] initWithFormat: @"%@", clip.text];
        
        display = [[NSString alloc] initWithFormat:@"%i. %@", count, display];
        
        // build menu item
        NSMenuItem *item;
        item = [[NSMenuItem alloc] initWithTitle:display
                                          action:@selector(clipClick:)
                                   keyEquivalent:@""];
        [item setTarget:self];
        [item setEnabled:YES];
        [item setRepresentedObject:clip.text];
        
        NSImage *image;
        
        // TODO: Add image support
        //if(clip.type == @"text") {
        
        image = [[NSImage alloc] initWithContentsOfFile:[app.bundle pathForResource:@"clipping" ofType:@"icns"]];
        //}
        //else {
        //    
        //    image = [[NSImage alloc] initWithSize:[clip.image size]];
        //    [image addRepresentation: clip.image];
        //}            
        
        // configure menu item image
        [image setSize:NSMakeSize(16, 16)];
        [item setImage:image];
        
        // insert menu item
        [app.statusMenu insertItem:item atIndex:0];
        
        [item release];
        [display release];
        [image release];
        
        count = count - 1;
    }
}


- (void) delete  {
	
    NSError *error;
	
    // overriding fetch request
	NSFetchRequest *hfetchRequest = [[NSFetchRequest alloc] init];

    [hfetchRequest setEntity:entity];
    
    NSArray *fetchedObjects = [app.context executeFetchRequest:hfetchRequest error:&error];
	
    for (Clip *clip in fetchedObjects) {
        [app.context deleteObject:clip];
        NSLog(@"%@ object deleted", entity);
    }
    
    if (![app.context save:&error]) {
        NSLog(@"Error deleting %@ - error:%@", entity, error);
    }
    
    [app updateMenu];
}

// USER INTERACTS WITH MENU ITEMS
- (void) clipClick:(id)sender
{
    int index=[[sender menu] indexOfItem:sender];
    [self addClipToPasteboard:index];
}

// ADD CLICKED ITEM TO PASTEBOARD
- (BOOL) addClipToPasteboard:(int)index {
    
  NSMenuItem *item = [app.statusMenu itemAtIndex:index];
  NSString *text = [item representedObject];
  [app.pasteboard setText:text];    
        
  return true;
}

@end
