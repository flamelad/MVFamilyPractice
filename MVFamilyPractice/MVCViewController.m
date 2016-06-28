//
//  ViewController.m
//  MVFamilyPractice
//
//  Created by neo_chen on 2015/4/1.
//  Copyright (c) 2015年 CyberLink. All rights reserved.
//

#import "MVCViewController.h"
#import "MVFUserInputView.h"
#import "Family.h"
#import "Family+Addon.h"
#import "MVFDBManager.h"


@interface MVCViewController () <MVFUserInputViewDelegate,NSFetchedResultsControllerDelegate>{
    NSFetchedResultsController *fetcher;
    NSManagedObjectContext *moc;
    NSArray *familys;
    
}
@property MVFUserInputView *userInputView;
@end

@implementation MVCViewController

#pragma mark - View Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    self.userInputView=[[MVFUserInputView alloc] initWithFrame:self.view.frame];
    self.userInputView.delegate=self;
    [self.view addSubview:self.userInputView];
    
    [self initFetcher];
    [self startOrReloadFetcher];
    [self fetchDataToTextView];

    [[NSNotificationCenter defaultCenter]addObserver:self
                                            selector:@selector(contextChange)
                                                name:NSManagedObjectContextObjectsDidChangeNotification
                                              object:nil];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - --MVFViewController Private Method--

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
        NSString *content=@"";
        for (Family *family in familys) {
            content=[content stringByAppendingFormat:@"Family Name: %@ \n",family.familyName];
        }
        [self.userInputView setTextViewContent:content];
    }
}

#pragma mark Notification Observer Method
-(void)contextChange{
    [moc save:nil];
    [self startOrReloadFetcher];
    [self fetchDataToTextView];
}

#pragma mark - MVFUserInputViewDelegate

-(void)clickButton{
    [Family createFamilyAttribute:self.userInputView.getInputFamilyName ManagedObjectContext:moc];
}

@end
