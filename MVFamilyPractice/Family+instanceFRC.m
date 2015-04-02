//
//  Family+instanceFRC.m
//  MVFamilyPractice
//
//  Created by neo_chen on 2015/4/2.
//  Copyright (c) 2015年 CyberLink. All rights reserved.
//

#import "Family+instanceFRC.h"

#define SQLITE_FILE @"MVFamily.sqlite"

@implementation Family (instanceFRC)

+(NSFetchedResultsController *)establishFetcherWithEntityName:(NSString *)entityName{
    NSFetchRequest *request=[NSFetchRequest fetchRequestWithEntityName:entityName];
    NSSortDescriptor *sorter=[NSSortDescriptor sortDescriptorWithKey:@"familyId" ascending:YES];
    [request setSortDescriptors:@[sorter]];
    return  [[NSFetchedResultsController alloc]initWithFetchRequest:request
                                               managedObjectContext:[self persistentStack]
                                                 sectionNameKeyPath:nil
                                                          cacheName:@"flamelad"];
}

+(NSManagedObjectContext *)persistentStack{
    NSPersistentStoreCoordinator *coordinator=[self persistentStoreCoordinator];
    NSManagedObjectContext* moc=[self managedObjectContext];
    [moc setPersistentStoreCoordinator:coordinator];
    return moc;
}

+(NSManagedObjectContext *)managedObjectContext{
    NSManagedObjectContext* moc=[[NSManagedObjectContext alloc]initWithConcurrencyType:NSMainQueueConcurrencyType];
    
    return moc;
}

+(NSPersistentStoreCoordinator *)persistentStoreCoordinator{
    NSURL *fileURL=[NSURL fileURLWithPath:[self getSqliteFile]];
    NSURL *modelURL=[[NSBundle mainBundle] URLForResource:@"MVFamilyPractice" withExtension:@"momd"];
    NSManagedObjectModel *model = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    NSPersistentStoreCoordinator *coordinator = [[NSPersistentStoreCoordinator alloc]initWithManagedObjectModel:model];
    NSDictionary *coordinatorOptions = @{NSMigratePersistentStoresAutomaticallyOption:@YES,
                                         NSInferMappingModelAutomaticallyOption:@YES};
    [coordinator addPersistentStoreWithType:NSSQLiteStoreType
                              configuration:nil
                                        URL:fileURL
                                    options:coordinatorOptions
                                      error:nil];
    return coordinator;
}

+(NSString *)getSqliteFile{
    NSString *filePath = [NSString stringWithString:[NSTemporaryDirectory() stringByAppendingPathComponent:SQLITE_FILE]];
    if(![[NSFileManager defaultManager] fileExistsAtPath:filePath]){
        [[NSFileManager defaultManager] createFileAtPath:filePath contents:nil attributes:nil];
    }
    return filePath;
}

@end
