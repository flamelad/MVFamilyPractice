//
//  MVFDBManager.h
//  MVFamilyPractice
//
//  Created by neo_chen on 2015/4/2.
//  Copyright (c) 2015年 CyberLink. All rights reserved.
//
#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@interface MVFDBManager : NSObject
+(MVFDBManager *) shareManager;
-(NSFetchedResultsController *) fetcher;
-(NSManagedObjectContext *) managedObjectContext;
@end
