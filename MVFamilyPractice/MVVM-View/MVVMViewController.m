//
//  MVVMViewController.m
//  MVFamilyPractice
//
//  Created by neo_chen on 2015/4/8.
//  Copyright (c) 2015年 CyberLink. All rights reserved.
//


#import "MVVMViewController.h"
#import "MVVMViewModel.h"
#import "MVFUserInputView.h"

static void *kTextContextChange=&kTextContextChange;

@interface MVVMViewController ()<MVFUserInputViewDelegate>{
    
}
@property MVVMViewModel *viewModel;
@property MVFUserInputView *userInputView;
@end

@implementation MVVMViewController

#pragma mark - View Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    self.viewModel = [[MVVMViewModel alloc]init];
    self.userInputView=[[MVFUserInputView alloc] initWithFrame:self.view.frame];
    self.userInputView.delegate=self;
    [self.view addSubview:self.userInputView];
    [self.userInputView setTextViewContent:self.viewModel.textViewContent];
    [self.viewModel addObserver:self
                     forKeyPath:@"textViewContent"
                        options:(NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld)
                        context:kTextContextChange];

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - MVFUserInputViewDelegate

-(void)clickButton{
    [self.viewModel setInputText:self.userInputView.getInputFamilyName];
    [self.viewModel click];
}

#pragma mark - KVO

-(void)observeValueForKeyPath:(NSString *)keyPath
                     ofObject:(id)object
                       change:(NSDictionary *)change
                      context:(void *)context{
    NSLog(@"%@",keyPath);
    NSLog(@"%@",object);
    NSLog(@"%@",change);
//    NSLog(@"%@",context);
    [self.userInputView setTextViewContent:self.viewModel.textViewContent];
}

@end
