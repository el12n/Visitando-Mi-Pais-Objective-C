//
//  ViewController.h
//  Visitando mi Pais
//
//  Created by Alvaro De la Cruz Lockhart on 3/19/15.
//  Copyright (c) 2015 Alvaro De la Cruz Lockhart. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProvinciaHandler.h"
#import "LoadingView.h"

@interface ViewController : UIViewController<UITableViewDataSource, UITableViewDelegate, ProvinciaHandlerProtocol>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSMutableArray *myData;

@end

