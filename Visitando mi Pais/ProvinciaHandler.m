//
//  ProvinciaHandler.m
//  Visitando mi Pais
//
//  Created by Alvaro De la Cruz Lockhart on 3/19/15.
//  Copyright (c) 2015 Alvaro De la Cruz Lockhart. All rights reserved.
//

#import "ProvinciaHandler.h"

NSString *const URL = @"http://data.developers.do/api/v1/provincias.json";

@implementation ProvinciaHandler

- (id) init: (NSDictionary *)dictionary{
    self = [super init];
    if (self){
        [self loadHandler:dictionary];
    }
    return self;
}

- (void) requestProvincias{
    ApiHandler *apiHandler = [[ApiHandler alloc] init];
    apiHandler.url = URL;
    apiHandler.delegate = self;
    [apiHandler connect];
}

- (void) loadHandler: (NSDictionary *) dictionary{
    self._id = [dictionary[@"id"] integerValue];
    self.nombre = dictionary[@"nombre"];
}

+(ProvinciaHandler *) fromJson:(NSDictionary *)dictionary{
    return [[ProvinciaHandler alloc] init:dictionary];
}

+(NSMutableArray *) fromJsonArra:(NSArray *)provinciasFromServer{
    NSMutableArray *provinciasHandler = [[NSMutableArray alloc] init];
    for(NSDictionary *provincia in provinciasFromServer){
        [provinciasHandler addObject:[self fromJson:provincia]];
    }
    return provinciasHandler;
}

-(void) didJsonCame:(NSArray *)rawArray{
    if (self.delegate != nil){
        [self.delegate loadTable:[ProvinciaHandler fromJsonArra:rawArray]];
    }else{
        NSLog(@"Error the delegate is nil");
    }
}

@end
