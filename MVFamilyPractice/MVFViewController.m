//
//  ViewController.m
//  MVFamilyPractice
//
//  Created by neo_chen on 2015/4/1.
//  Copyright (c) 2015年 CyberLink. All rights reserved.
//

#import "MVFViewController.h"
#import "MVFUserInputView.h"
#import "Family.h"
#import "Family+Addon.h"
#import "MVFDBManager.h"


@interface MVFViewController () <MVFUserInputViewDelegate,NSFetchedResultsControllerDelegate>{
    NSFetchedResultsController *fetcher;
    NSManagedObjectContext *moc;
    NSArray *familys;
    
}
@property MVFUserInputView *subView;
@end

@implementation MVFViewController

#pragma mark - View Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    self.subView=[[MVFUserInputView alloc] initWithFrame:self.view.frame];
    self.subView.delegate=self;
    [self.view addSubview:self.subView];
    
    [self initFetcher];
    [self startOrReloadFetcher];
    [self fetchDataToTextView];

    [[NSNotificationCenter defaultCenter]addObserver:self
                                            selector:@selector(contextChange)
                                                name:NSManagedObjectContextObjectsDidChangeNotification
                                              object:nil];
    // Do any additional setup after loading the view, typically from a nib.
    
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
        [self.subView setTextViewContent:content];
    }
}

#pragma mark - MVFUserInputViewDelegate

-(void)clickButton{
    [Family createFamilyAttribute:self.subView.getInputFamilyName ManagedObjectContext:moc];
}

#pragma mark Notification Observer Method
-(void)contextChange{
    [moc save:nil];
    [self startOrReloadFetcher];
    [self fetchDataToTextView];
}

@end
