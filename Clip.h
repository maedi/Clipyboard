//
//  Clip.h
//  Clipyboard2
//
//  Created by Graham Prichard on 9/03/11.
//  Copyright 2011 Artisan Baker Pty Ltd. All rights reserved.
//

#import <CoreData/CoreData.h>


@interface Clip :  NSManagedObject  
{
}

@property (nonatomic, retain) NSString * label;
@property (nonatomic, retain) NSString * text;
@property (nonatomic, retain) NSDate * createdAt;
@property (nonatomic, retain) NSString * type;
@property (nonatomic, retain) NSString * typeNS;
@property (nonatomic, retain) NSImageRep * image;
@property (nonatomic, retain) NSString * clipId;


@end



