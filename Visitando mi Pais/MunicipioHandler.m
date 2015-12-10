//
//  MunicipioHandler.m
//  Visitando mi Pais
//
//  Created by Alvaro De la Cruz Lockhart on 3/19/15.
//  Copyright (c) 2015 Alvaro De la Cruz Lockhart. All rights reserved.
//

#import "MunicipioHandler.h"

@implementation MunicipioHandler

- (id) init: (NSDictionary *) dictionary{
    self = [super init];
    if (self) {
        [self loadHandler:dictionary];
    }
    return self;
}

-(void) loadHandler: (NSDictionary *) dictionary{
    self._id = [dictionary[@"id"] integerValue];
    self.nombre = dictionary[@"nombre"];
    self.provincia_id = [dictionary[@"provincia_id"] integerValue];
}

-(void) makeRequest:(NSString *)url{
    ApiHandler *apiHandler = [[ApiHandler alloc] init];
    apiHandler.delegate = self;
    apiHandler.url = url;
    [apiHandler connect];
}

+(MunicipioHandler *)fromJson:(NSDictionary *)dictionary{
    return [[MunicipioHandler alloc] init:dictionary];
}

+(NSMutableArray *)fromJsonArray:(NSArray *)municipioArray{
    NSMutableArray *municipiosArray = [[NSMutableArray alloc] init];
    for(NSDictionary *municipio in municipioArray){
        [municipiosArray addObject:[MunicipioHandler fromJson:municipio]];
    }
    return municipiosArray;
}


-(void)didJsonCame:(NSArray *)rawArray{
    if (self.delegate != nil) {
        [self.delegate loadTable:[MunicipioHandler fromJsonArray:rawArray]];
    }else{
        NSLog(@"Error delegate is nil");
    }
}

@end
