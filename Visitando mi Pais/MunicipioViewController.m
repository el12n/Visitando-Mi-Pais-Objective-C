//
//  MunicipioViewController.m
//  Visitando mi Pais
//
//  Created by Alvaro De la Cruz Lockhart on 3/19/15.
//  Copyright (c) 2015 Alvaro De la Cruz Lockhart. All rights reserved.
//

#import "MunicipioViewController.h"
#import "LoadingView.h"
#import "VisitView Controller.h"

@interface MunicipioViewController()
@property (nonatomic, strong) MunicipioHandler *municipioHandler;
@end


@implementation MunicipioViewController

-(void) viewDidLoad{
    [super viewDidLoad];
    self.title = [self.provincia nombre];
    if(self.myMunicipios.count <= 0){
        self.myMunicipios = [[NSMutableArray alloc] init];
        if(self.provincia != nil){
            [self.view addSubview:[[LoadingView alloc]initWithFrame:self.view.bounds]];
            self.municipioHandler = [[MunicipioHandler alloc] init];
            self.municipioHandler.delegate = self;
            [self.municipioHandler makeRequest:@"http://data.developers.do/api/v1/municipios"];
        }
    }
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.myMunicipios.count;
}

-(UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell* cell = [self.tableView dequeueReusableCellWithIdentifier:@"MunicipioCell"];
    MunicipioHandler *municipioHandler = self.myMunicipios[indexPath.row];
    cell.textLabel.text = municipioHandler.nombre;
    return cell;
}

-(void)loadTable:(NSArray *)rawArray{
    dispatch_async(dispatch_get_main_queue(), ^(){
        for(MunicipioHandler *municipio in rawArray){
            if(municipio.provincia_id == self.provincia._id){
                [self.myMunicipios addObject:municipio];
            }
        }
        [self.tableView reloadData];
        [[self.view.subviews lastObject]removeFromSuperview];
    });
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([segue.identifier isEqualToString:@"MunicipioToVisit"]){
        VisitView_Controller *visitViewController = (VisitView_Controller *)segue.destinationViewController;
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        MunicipioHandler *municipio = [self.myMunicipios objectAtIndex:indexPath.row];
        municipio.provincia = [self provincia];
        visitViewController.municipio = municipio;
    }
}

@end
