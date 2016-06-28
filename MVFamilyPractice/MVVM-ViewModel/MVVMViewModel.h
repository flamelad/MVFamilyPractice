//
//  MVVMViewModel.h
//  MVFamilyPractice
//
//  Created by neo_chen on 2015/4/8.
//  Copyright (c) 2015年 CyberLink. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Family.h"

@interface MVVMViewModel : NSObject
-(void)click;

@property (nonatomic, readonly) NSString *textViewContent;
@property (nonatomic) NSString *inputText;
@end
