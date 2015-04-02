//
//  Family+Addon.h
//  MVFamilyPractice
//
//  Created by neo_chen on 2015/4/2.
//  Copyright (c) 2015年 CyberLink. All rights reserved.
//

#import "Family.h"
@interface Family (Addon)
+(void)createFamilyAttribute:(NSString *)name ManagedObjectContext:(NSManagedObjectContext *)moc;
@end
