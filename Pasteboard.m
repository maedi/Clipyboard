#import "Pasteboard.h"
#import "AppController.h"
#import "Clip.h"

@implementation Pasteboard

@synthesize lastCount;
@synthesize lastCountInt;


-(id) init
{
   	// GET PASTEBOARD
	
	// Create our pasteboard interface
    pb = [NSPasteboard generalPasteboard];
	lastCount = [[NSNumber numberWithInt:[pb changeCount]] retain];
    lastCountInt = [pb changeCount];
    text = @"";
	
    return self;
}

- (NSString *) typeNS
{
    // TODO: Image support
	/*BOOL image = [[pb pasteboardTypes] containsObject:@"public.png"];
	
	if(image){
		return @"image";
	}
	else {
		return @"text";
	}*/

	return [[pb types] objectAtIndex:1];
}

- (NSString *) text
{
    return [pb stringForType:NSPasteboardTypeString];
}

/*- (NSImageRep *) image
{
    NSImage *image = [[NSImage alloc] initWithData: [pb dataForType:NSPasteboardTypePNG]];
    NSImage *image2 = [[NSImage alloc ] initWithPasteboard:pb];
    NSImageRep *imagerep = [NSImageRep imageRepWithPasteboard:pb];
    return imagerep;
}*/


- (void) setImage:(NSImageRep *) image
{
    [pb clearContents];
    [pb writeObjects:[NSArray arrayWithObject:image]];
}


- (void) setText:(NSString *) string
{
    [pb clearContents];
    [pb writeObjects:[NSArray arrayWithObject:string]];
}


- (int) nowCount
{
    return [pb changeCount];
}


- (BOOL) isText
{
    // Test for strings on the pasteboard.
    NSArray *classes = [NSArray arrayWithObject:[NSString class]];
    NSDictionary *options = [NSDictionary dictionary];
    
    if([pb canReadObjectForClasses:classes options:options]) 
    {
        return YES;
    }
    return NO;
}


- (BOOL) isImage
{
    // Test for strings on the pasteboard.
    NSArray *classes = [NSArray arrayWithObject:[NSImage class]];
    NSDictionary *options = [NSDictionary dictionary];
    
    if([pb canReadObjectForClasses:classes options:options]) 
    {
        return YES;
    }
    return NO;
}

/*- (BOOL) pasteUpdate
{
    if(lastCountInt != [self currCount])
    {
        return YES;
    }
    else {
        return NO;
    }
}*/

@end
