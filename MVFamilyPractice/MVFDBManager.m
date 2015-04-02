//
//  MVFDBManager.m
//  MVFamilyPractice
//
//  Created by neo_chen on 2015/4/2.
//  Copyright (c) 2015年 CyberLink. All rights reserved.
//

#import "MVFDBManager.h"
#import "Family+instanceFRC.h"

#define SQLITE_FILE @"MVFamily.sqlite"

@interface MVFDBManager()
@property (nonatomic) NSFetchedResultsController *fetcher;
@property (nonatomic) NSManagedObjectContext *moc;

@end

@implementation MVFDBManager

+(MVFDBManager *)shareManager{
    static MVFDBManager *manager=nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[MVFDBManager alloc] init];
    });
    return manager;
}

-(NSFetchedResultsController *) fetcher{
    if (!_fetcher) {
         self.fetcher=[Family establishFetcherWithEntityName:@"Family"];
    }
    return  _fetcher;
}

-(NSManagedObjectContext *) managedObjectContext{
    if (!self.moc) {
        self.moc = self.fetcher.managedObjectContext;
    }
    return self.moc;
}


@end
