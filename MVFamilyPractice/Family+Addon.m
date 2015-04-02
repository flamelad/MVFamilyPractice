//
//  Family+Addon.m
//  MVFamilyPractice
//
//  Created by neo_chen on 2015/4/2.
//  Copyright (c) 2015年 CyberLink. All rights reserved.
//

#import "Family+Addon.h"

@implementation Family (Addon)
+(void)createFamilyAttribute:(NSString *)name ManagedObjectContext:(NSManagedObjectContext *)moc{
    if (![self isExistName:name inManagedObjectContext:moc]) {
        Family *family=(Family *)[NSEntityDescription insertNewObjectForEntityForName:@"Family"
                                                               inManagedObjectContext:moc];
        family.familyName=name;
    }
}

+(BOOL) isExistName:(NSString *)name inManagedObjectContext:(NSManagedObjectContext *)moc{
    NSPredicate *predicate=[NSPredicate predicateWithFormat:@"familyName == %@",name];
    NSEntityDescription *entity=[NSEntityDescription entityForName:@"Family" inManagedObjectContext:moc];
    NSFetchRequest *request=[[NSFetchRequest alloc]init];
    [request setEntity:entity];
    [request setPredicate:predicate];
    return ([[moc executeFetchRequest:request error:nil] count]==0)?NO:YES;
}
@end
