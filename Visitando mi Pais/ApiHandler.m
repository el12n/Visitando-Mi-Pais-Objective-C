//
//  ApiHandler.m
//  Visitando mi Pais
//
//  Created by Alvaro De la Cruz Lockhart on 3/19/15.
//  Copyright (c) 2015 Alvaro De la Cruz Lockhart. All rights reserved.
//

#import "ApiHandler.h"

@implementation ApiHandler


- (void) connect {
    NSURL *url = [NSURL URLWithString: [self url]];
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [session dataTaskWithURL:url completionHandler: ^(NSData *data, NSURLResponse *response, NSError *error){
        NSLog(@"Peticion relizada");
        if (error != nil) {
            NSLog(@"Error %@", [error localizedDescription]);
        }
        NSError *err;
        NSArray *jsonResult = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&err];
        if (err != nil){
            NSLog(@"Error %@", err.localizedDescription);
        }else{
            [[self delegate] didJsonCame:jsonResult];
        }
    }];
    [dataTask resume];
}

@end
