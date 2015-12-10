//
//  ApiHandler.h
//  Visitando mi Pais
//
//  Created by Alvaro De la Cruz Lockhart on 3/19/15.
//  Copyright (c) 2015 Alvaro De la Cruz Lockhart. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ApiHandlerProtocol

- (void) didJsonCame: (NSArray *) rawArray;

@end

@interface ApiHandler : NSObject

@property (nonatomic, weak) id <ApiHandlerProtocol> delegate;
@property (nonatomic, weak) NSString *url;

- (void) connect;

@end
