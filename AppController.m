#import "AppController.h"
#import "CoreData.h"
#import "Clip.h"
#import "Pasteboard.h"
#import "ClipsController.h"

@implementation AppController : NSObject

@synthesize pasteboard;
@synthesize bundle;
@synthesize context;
@synthesize fetchRequest;
@synthesize entity;
@synthesize clips;
@synthesize statusMenu;


#pragma mark Class methods

+ (AppController *) sharedAppController
{
    return [NSApp delegate];
}

#pragma mark Instance methods

- (void) awakeFromNib {
 
    //[[NSApplication sharedApplication] setDelegate:AppController];   
    [NSApp setDelegate: self];

    // CREATE FILE STORE
    bundle = [NSBundle mainBundle];

	// CREATE CORE DATA
	context = [[[CoreData alloc] init] managedObjectContext];
	fetchRequest = [[NSFetchRequest alloc] init];
	entity = [NSEntityDescription entityForName:@"Clip" inManagedObjectContext:context];
	[fetchRequest setEntity:entity];
	
	// CREATE PASTEBOARD
	pasteboard = [[Pasteboard alloc] init];
	
	// CREATE CLIPS CONTROLLER
    clips = [[ClipsController alloc] init];

    // CREATE STATUS MENU ITEM
    [self createStatusMenu];
	
    // SHOW STATUS MENU
    [self updateMenu];
	
    // START APP UPDATE LOOP
	timer = [[NSTimer scheduledTimerWithTimeInterval:(0.5)
	target:self
	selector:@selector(updateLoop:)
	userInfo:nil
	repeats:YES] retain];
	[timer fire];

    [self addAppAsLoginItem];
}

- (void) updateLoop:(NSTimer *)timer;
{
    [clips save];
    [self updateMenu];
}

- (void) createStatusMenu
{  
	statusItem = [[[NSStatusBar systemStatusBar] statusItemWithLength:NSSquareStatusItemLength] retain];

	// icon
	statusImage = [[NSImage alloc] initWithContentsOfFile:[bundle pathForResource:@"clipyboard-icon" ofType:@"png"]];
	statusHighlightImage = [[NSImage alloc] initWithContentsOfFile:[bundle pathForResource:@"clipyboard-icon-over" ofType:@"png"]];
    [statusItem setImage:statusImage];
	[statusItem setAlternateImage:statusHighlightImage];
	
	// attach statusMenu to statusItem
	[statusItem setMenu:statusMenu];
	[statusItem setToolTip:@"Clipyboard 0.1"];
	[statusItem setHighlightMode:YES];
}

// DISPLAYING CLIPPINGS

- (IBAction) updateMenu
{
    // REFRESH
    [statusMenu removeAllItems];
    
    // ADD LINKS
    // quit
    NSMenuItem *quit;
    quit = [[NSMenuItem alloc] initWithTitle:@"Quit" action:@selector(quit) keyEquivalent:@""];
    [quit setTarget:self];
    [quit setEnabled:YES];
    [statusMenu insertItem:quit atIndex:0];
    [quit release];
    
    // clear history
    NSMenuItem *clear;
    clear = [[NSMenuItem alloc] initWithTitle:@"Clear History" action:@selector(delete) keyEquivalent:@""];
    [clear setTarget:clips];
    [clear setEnabled:YES];
    [statusMenu insertItem:clear atIndex:0];
    [clear release];

    // -- seperator --
    [statusMenu insertItem:[NSMenuItem separatorItem] atIndex:0];
    
    // SHOW CLIPS
    [clips show];
    
    // clipyboard title
    NSMenuItem *clipyboard;
    clipyboard = [[NSMenuItem alloc] initWithTitle:@"Clipyboard"
                                      action:nil
                               keyEquivalent:@""];
    [clipyboard setTarget:self];
    [clipyboard setEnabled:YES];
    [statusMenu insertItem:clipyboard atIndex:0];
    [clipyboard release];
}

-(void) gotoweb {
	
	[[NSWorkspace sharedWorkspace] openURL:[NSURL URLWithString:@"http://clipyboard.com"]];
}

- (void) quit {
    
    [[NSApplication sharedApplication] terminate:nil];
}

- (void) addAppAsLoginItem {
    // http://cocoatutorial.grapewave.com/tag/lssharedfilelist-h/
    
	NSString *appPath = [bundle bundlePath];
    
	// This will retrieve the path for the application
	// For example, /Applications/test.app
	CFURLRef url = (CFURLRef)[NSURL fileURLWithPath:appPath]; 
    
	// Create a reference to the shared file list.
    // We are adding it to the current user only.
    // If we want to add it all users, use
    // kLSSharedFileListGlobalLoginItems instead of
    //kLSSharedFileListSessionLoginItems
	LSSharedFileListRef loginItems = LSSharedFileListCreate(NULL,
                                                            kLSSharedFileListSessionLoginItems, NULL);
	if (loginItems) {
		//Insert an item to the list.
		LSSharedFileListItemRef item = LSSharedFileListInsertItemURL(loginItems,
                                                                     kLSSharedFileListItemLast,
                                                                     NULL,
                                                                     NULL,
                                                                     url,
                                                                     NULL,
                                                                     NULL);
		if (item){
			CFRelease(item);
        }
	}	
    
	CFRelease(loginItems);
}

- (void) dealloc {
	//Releases the 2 images we loaded into memory
	[statusImage release];
	[statusHighlightImage release];
    [fetchRequest release];

	[super dealloc];
}
@end