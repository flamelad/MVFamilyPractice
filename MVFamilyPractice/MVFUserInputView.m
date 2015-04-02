//
//  MVFUserInputView.m
//  MVFamilyPractice
//
//  Created by neo_chen on 2015/4/1.
//  Copyright (c) 2015年 CyberLink. All rights reserved.
//

#import "MVFUserInputView.h"


@interface MVFUserInputView()
@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic) IBOutlet UITextField *inputText;

@end

@implementation MVFUserInputView

-(instancetype) initWithFrame:(CGRect)frame{
    self=[super initWithFrame:frame];
    if (self) {
        self=[[[NSBundle mainBundle] loadNibNamed:@"MVFUserInputView" owner:self options:nil] objectAtIndexedSubscript:0];
        self.frame=frame;
        self.textView.text=@"There is no any information...";
    }
    return self;
}

-(NSString *)getInputFamilyName{
    return _inputText.text;
}

-(void)setTextViewContent:(NSString *)content{
    self.textView.text = content;
}

- (IBAction)submitAction:(id)sender {
    if([self.delegate respondsToSelector:@selector(clickButton)]){
        [self.delegate clickButton];
    }
}
@end
