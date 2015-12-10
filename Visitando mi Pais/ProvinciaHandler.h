//
//  ProvinciaHandler.h
//  Visitando mi Pais
//
//  Created by Alvaro De la Cruz Lockhart on 3/19/15.
//  Copyright (c) 2015 Alvaro De la Cruz Lockhart. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ApiHandler.h"

@protocol ProvinciaHandlerProtocol <NSObject>

-(void) loadTable: (NSMutableArray*)provincias;

@end

@interface ProvinciaHandler : NSObject<ApiHandlerProtocol>

FOUNDATION_EXPORT NSString *const URL;

@property (nonatomic) NSInteger _id;
@property (nonatomic, strong) NSString *nombre;
@property (nonatomic, strong) id<ProvinciaHandlerProtocol> delegate;

-(void) requestProvincias;
+(ProvinciaHandler *) fromJson: (NSDictionary *)dictionary;
+(NSMutableArray *) fromJsonArra: (NSArray *) provinciasFromServer;

@end
