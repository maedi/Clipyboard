#import <Cocoa/Cocoa.h>
#import <ApplicationServices/ApplicationServices.h>
#import <Foundation/Foundation.h>
#import "Pasteboard.h"
#import "CoreData.h"
#import "ClipsController.h"

@class ClipsController;

@interface AppController : NSObject {
		
	/* Menu Item */
	IBOutlet NSMenu *statusMenu;
	NSStatusItem *statusItem;
	NSImage *statusImage;
	NSImage *statusHighlightImage;
    NSBundle *bundle;
    
	/* Pasteboard */
    Pasteboard *pasteboard;		// the interface to the pasteboard

	/* Updates */
	NSTimer *timer;

    ClipsController *clips;

    /* Data */
    NSFetchRequest *fetchRequest;
    NSEntityDescription *entity;      
    @public
    NSManagedObjectContext *context;    // alias for AppDelegate context
  
}

@property (nonatomic, retain) Pasteboard *pasteboard;
@property (nonatomic, retain) IBOutlet NSMenu *statusMenu;
@property (nonatomic, retain) NSBundle *bundle;
@property (nonatomic, retain) ClipsController *clips;
@property (nonatomic, retain) NSManagedObjectContext *context;
@property (nonatomic, retain) NSFetchRequest *fetchRequest;
@property (nonatomic, retain) NSEntityDescription *entity;

#pragma mark Class methods

/**
 * Returns a shared instance (singleton) of this class
 */
+ (AppController *) sharedAppController;


#pragma mark Instance methods

/* interface */
- (void) createStatusMenu;

/* actions */
- (void) updateLoop:(NSTimer *)timer;
- (void) updateMenu;
- (void) addAppAsLoginItem;
- (void) quit;
- (void) gotoweb;

@end