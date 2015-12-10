//
//  ViewController.m
//  Visitando mi Pais
//
//  Created by Alvaro De la Cruz Lockhart on 3/19/15.
//  Copyright (c) 2015 Alvaro De la Cruz Lockhart. All rights reserved.
//

#import "ViewController.h"
#import "MunicipioViewController.h"

@interface ViewController ()

@property (nonatomic, strong) ProvinciaHandler *provinciaHandler;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self.view addSubview:[[LoadingView alloc] initWithFrame:self.view.bounds]];
    self.provinciaHandler = [[ProvinciaHandler alloc] init];
    self.provinciaHandler.delegate = self;
    [self.provinciaHandler requestProvincias];
    self.myData = [[NSMutableArray alloc] init];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([segue.identifier  isEqual: @"ProvinciaToMunicipio"]){
        ProvinciaHandler *provincia = self.myData[[[self.tableView indexPathForSelectedRow]row]];
        MunicipioViewController *municipioViewController = segue.destinationViewController;
        municipioViewController.provincia = provincia;
    }
}

#pragma mark - Table View Data source
- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _myData.count;
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifier = @"ProvinciaCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    ProvinciaHandler *provincia = [_myData objectAtIndex:indexPath.row];
    cell.textLabel.text = provincia.nombre;
    return cell;
}

#pragma mark - Table View Delegate
- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"Provincia seleccionada %@", [[_myData objectAtIndex:indexPath.row] nombre]);
}

#pragma mark - Provincia Handler Delegate
-(void) loadTable:(NSMutableArray *)provincias{
    dispatch_async(dispatch_get_main_queue(), ^(){
        for(ProvinciaHandler *provincia in provincias){
            [self.myData addObject:provincia];
        }
        [self.tableView reloadData];
        [[self.view.subviews lastObject] removeFromSuperview];
    });
}
@end
