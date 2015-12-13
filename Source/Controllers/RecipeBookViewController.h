//
//  RecipeBookViewController.h
//  RecipeBook
//
//  Created by Simon Ng on 14/6/12.
//  Copyright (c) 2012 Appcoda. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/parse.h>

@interface RecipeBookViewController : PFQueryTableViewController 


- (IBAction)addPatient:(UIBarButtonItem *)sender;
@property (strong) NSString *passedUser;
@end
