//
//  MVVMViewModel.m
//  MVFamilyPractice
//
//  Created by neo_chen on 2015/4/8.
//  Copyright (c) 2015年 CyberLink. All rights reserved.
//

#import "MVVMViewModel.h"
#import "Family.h"
#import "Family+Addon.h"
#import "MVFDBManager.h"

@interface MVVMViewModel()<NSFetchedResultsControllerDelegate>{
    NSFetchedResultsController *fetcher;
    NSManagedObjectContext *moc;
    NSArray *familys;
}
@property (nonatomic, readwrite) NSString *textViewContent;

@end

@implementation MVVMViewModel

-(instancetype)init{
    self=[super init];
    if (!self) return nil;
    [self initFetcher];
    [self startOrReloadFetcher];
    [self fetchDataToTextView];
    
    [[NSNotificationCenter defaultCenter]addObserver:self
                                            selector:@selector(contextChange)
                                                name:NSManagedObjectContextObjectsDidChangeNotification
                                              object:nil];
    
    return self;
}

#pragma mark - --MVVMViewModel Public Method--
-(void)click{
    [Family createFamilyAttribute:self.inputText ManagedObjectContext:moc];
}

#pragma mark - --MVVMViewModel Private Method--

-(void)initFetcher{
    fetcher=[MVFDBManager shareManager].fetcher;
    fetcher.delegate=self;
    moc=[MVFDBManager shareManager].managedObjectContext;
}
-(void)startOrReloadFetcher{
    [fetcher performFetch:nil];
    familys=[fetcher fetchedObjects];
}
-(void)fetchDataToTextView{
    if ([familys count] !=0) {
        NSString *tempString=@"";
        for (Family *family in familys) {
            tempString=[tempString stringByAppendingFormat:@"Family Name: %@ \n",family.familyName];
        }
        [self setValue:tempString forKey:@"textViewContent"];
    }
}

#pragma mark Notification Observer Method
-(void)contextChange{
    [moc save:nil];
    [self startOrReloadFetcher];
    [self fetchDataToTextView];
}

@end
