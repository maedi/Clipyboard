//
//  ClipsController.h
//  Clipyboard
//
//  Created by Maedi

#import <Foundation/Foundation.h>
#import "AppController.h"
#import "Pasteboard.h"
#import "CoreData.h"
#import "Clip.h"

@class AppController;

@interface ClipsController : NSObject {

  /* data */
  NSFetchRequest *fetchRequest;
  NSEntityDescription *entity;
  AppController *app;  // alias for AppController singleton instance
}

// data accessors
@property (nonatomic, retain) NSFetchRequest *fetchRequest;
@property (nonatomic, retain) NSEntityDescription *entity;
@property (nonatomic, retain) AppController *app;

// define methods
- (id) init;
- (void) save;
- (void) show;
- (void) delete;
- (void) clipClick:(id)sender;
- (BOOL) addClipToPasteboard:(int)indexInt;

@end
