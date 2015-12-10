//
//  VisitView Controller.m
//  Visitando mi Pais
//
//  Created by Alvaro De la Cruz Lockhart on 3/20/15.
//  Copyright (c) 2015 Alvaro De la Cruz Lockhart. All rights reserved.
//

#import "VisitView Controller.h"
#import "AppDelegate.h"

@interface VisitView_Controller()
@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;
@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (weak, nonatomic) IBOutlet UILabel *labelMapInfo;
@property (strong, nonatomic) NSMutableArray *matchItems;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *loadingMap;
@end

@implementation VisitView_Controller


-(void)viewDidLoad{
    [super viewDidLoad];
    self.matchItems = [[NSMutableArray alloc] init];
    self.mapView.showsUserLocation = true;
    self.title = [NSString stringWithFormat:@"%@",[self.municipio.nombre stringByReplacingOccurrencesOfString:@" (DM)" withString:@""]];
    [self performSearch: [NSString stringWithFormat:@"%@, %@, Republica Dominicana",[self.municipio.provincia nombre], [self.municipio.nombre stringByReplacingOccurrencesOfString:@" (DM)" withString:@""]]];
}

-(void)displayGoodAlert{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Visitas" message:@"Visita agregada exitosamente" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *agree = [UIAlertAction actionWithTitle:@"Aceptar" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
        [self.navigationController popToRootViewControllerAnimated:YES];
    }];
    [alert addAction:agree];
    [self presentViewController:alert animated:YES completion:nil ];
    
}

-(void)performSearch: (NSString *)itemToSearch{
    [self.loadingMap startAnimating];
    [self.matchItems removeAllObjects];
    MKLocalSearchRequest *request = [[MKLocalSearchRequest alloc] init];
    request.naturalLanguageQuery = itemToSearch;
    request.region = self.mapView.region;
    MKLocalSearch *search = [[MKLocalSearch alloc]initWithRequest:request];
    [search startWithCompletionHandler:^(MKLocalSearchResponse *response, NSError *error){
        if(error != nil){
            NSLog(@"Error %@", error.localizedDescription);
            self.labelMapInfo.text = @"Municipio no encontrado";
        }else if(response.mapItems.count ==0 ){
            NSLog(@"No coincidencias encontradas");
            self.labelMapInfo.text = @"Municipio no encontrado";
        }else{
            NSLog(@"Coincidencias encontradas");
            for(MKMapItem *item in response.mapItems){
                [self.matchItems addObject:item];
                MKPointAnnotation *anotation = [[MKPointAnnotation alloc] init];
                anotation.coordinate = item.placemark.coordinate;
                anotation.title = item.name;
                [self.mapView addAnnotation:anotation];
                [self setMapViewZoom];
            }
            [self.loadingMap setHidden:YES];
            [self.labelMapInfo setHidden:YES];
        }
        [self.loadingMap setHidden:YES];
        [self.loadingMap stopAnimating];
    }];
}

- (IBAction)addVisit:(id)sender {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:[NSString stringWithFormat:@"Visitar %@", self.title] message:[NSString stringWithFormat:@"Desea visitar %@ ?", self.title] preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *agree = [UIAlertAction actionWithTitle:@"Aceptar" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
        [self createEventInCalendar];
    }];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"Cancelar" style:UIAlertActionStyleCancel handler:nil];
    [alert addAction:agree];
    [alert addAction:cancel];
    [self presentViewController:alert animated:YES completion:nil ];
}

-(void)createEventInCalendar{
    AppDelegate *delegate = [[UIApplication sharedApplication] delegate];
    EKEvent *event = [EKEvent eventWithEventStore:[delegate eventStore]];
    event.title = [NSString stringWithFormat:@"Visitar %@", self.municipio.nombre];
    event.startDate = [self.datePicker date];
    event.endDate = [event.startDate dateByAddingTimeInterval:(60*60)];
    event.calendar = [delegate calendar];
    NSError *error;
    [delegate.eventStore saveEvent:event span:EKSpanThisEvent commit:TRUE error:&error];
    if(error != nil){
        NSLog(@"Error inserting event: %@", error.localizedDescription);
    }else{
        NSLog(@"Event inserted with identifier: %@", [event eventIdentifier]);
        [self displayGoodAlert];
    }
}

-(void)setMapViewZoom{
    if(self.matchItems.count > 0){
        MKMapCamera *camera = [MKMapCamera cameraLookingAtCenterCoordinate:[[[self.matchItems firstObject] placemark] coordinate] fromEyeCoordinate:[[[self.matchItems firstObject] placemark] coordinate] eyeAltitude:([[self.mapView camera] altitude] - ([[self.mapView camera] altitude] * 0.7))];
        [self.mapView setCamera:camera animated:YES];
        [self lockMapview];
    }
}

-(void)lockMapview{
    self.mapView.zoomEnabled = NO;
    self.mapView.scrollEnabled = NO;
}

@end
