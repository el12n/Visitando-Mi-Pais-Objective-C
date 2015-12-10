//
//  MunicipioViewController.h
//  Visitando mi Pais
//
//  Created by Alvaro De la Cruz Lockhart on 3/19/15.
//  Copyright (c) 2015 Alvaro De la Cruz Lockhart. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProvinciaHandler.h"
#import "MunicipioHandler.h"

@interface MunicipioViewController : UIViewController<UITableViewDelegate, UITableViewDataSource, MunicipioHandlerProtocol>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSMutableArray *myMunicipios;
@property (strong,nonatomic) ProvinciaHandler *provincia;

@end
