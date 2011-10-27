//
//  Pasteboard.h
//  Clipyboard
//
//  Created by Maedi

#import <Cocoa/Cocoa.h>

@interface Pasteboard : NSObject {

    /* General Pasteboard */
    NSPasteboard *pb;		// we want an interface to the pasteboard
    NSNumber *lastCount;	// track the clipboard count so we only act when its contents change
    NSString *text;         // current text clipping
    int lastCountInt;

}

@property (nonatomic, retain) NSNumber *lastCount;
@property int lastCountInt;

- (id) init;
- (NSString *) text;
- (NSString *) typeNS;
- (NSImageRep *) image;

- (void) setText:(NSString *) string;
// TODO: Image support
//- (void) setImage:(NSImageRep *) image;

- (int) nowCount;
- (BOOL) isText;
- (BOOL) isImage;

@end
