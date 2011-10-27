//
//  CoreData.h
//  Clipyboard
//
//  Created by Maedi

#import <Cocoa/Cocoa.h>

@interface CoreData : NSObject 
{    
    NSPersistentStoreCoordinator *persistentStoreCoordinator;
    NSManagedObjectModel *managedObjectModel;
    NSManagedObjectContext *managedObjectContext;
}

@property (nonatomic, retain, readonly) NSPersistentStoreCoordinator *persistentStoreCoordinator;
@property (nonatomic, retain, readonly) NSManagedObjectModel *managedObjectModel;
@property (nonatomic, retain, readonly) NSManagedObjectContext *managedObjectContext;

- (id) init;
- (IBAction)saveAction:sender;

@end
