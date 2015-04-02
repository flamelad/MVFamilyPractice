//
//  MVFUserInputView.h
//  MVFamilyPractice
//
//  Created by neo_chen on 2015/4/1.
//  Copyright (c) 2015年 CyberLink. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MVFUserInputViewDelegate<NSObject>
@required
-(void)clickButton;
@end

@interface MVFUserInputView : UIView
@property (weak, nonatomic) id <MVFUserInputViewDelegate> delegate;

-(NSString *)getInputFamilyName;
-(void)setTextViewContent:(NSString *)content;
@end
