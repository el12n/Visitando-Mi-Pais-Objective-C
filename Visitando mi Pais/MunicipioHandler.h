//
//  MunicipioHandler.h
//  Visitando mi Pais
//
//  Created by Alvaro De la Cruz Lockhart on 3/19/15.
//  Copyright (c) 2015 Alvaro De la Cruz Lockhart. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ApiHandler.h"
#import "ProvinciaHandler.h"

@protocol MunicipioHandlerProtocol <NSObject>

- (void)loadTable: (NSArray *)rawArray;

@end

@interface MunicipioHandler : NSObject<ApiHandlerProtocol>

@property (nonatomic) NSInteger _id;
@property (nonatomic, strong) NSString *nombre;
@property (nonatomic) NSInteger provincia_id;
@property (nonatomic, strong) ProvinciaHandler *provincia;
@property (nonatomic, weak) id <MunicipioHandlerProtocol> delegate;

+(MunicipioHandler *) fromJson: (NSDictionary *) dictionary;
+(NSMutableArray *) fromJsonArray: (NSArray *) municipioArray;
-(void) makeRequest:(NSString *)url;

@end
