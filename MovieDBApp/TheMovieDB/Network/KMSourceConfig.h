//
//  KMSourceConfig.h
//  TheMovieDB
//
//  Created by Kevin Mindeguia on 03/02/2014.
//  Copyright (c) 2014 iKode Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KMSourceConfig : NSObject

+ (KMSourceConfig*)config;

@property (nonatomic, copy, readonly) NSString* version;
@property (nonatomic, copy, readonly) NSString* build;
@property (nonatomic, copy, readonly) NSString* theMovieDbHost;
@property (nonatomic, copy, readonly) NSString* apiKey;

@end
// Copyright belongs to original author
// http://code4app.net (en) http://code4app.com (cn)
// From the most professional code share website: Code4App.net