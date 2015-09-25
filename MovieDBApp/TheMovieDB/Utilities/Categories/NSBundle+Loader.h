//
//  NSBundle+Loader.h
//  TheMovieDB
//
//  Created by Kevin Mindeguia on 24/06/2013.
//  Copyright (c) 2014 iKode Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSBundle (Loader)

- (id)dataFromResource:(NSString *)resource;
- (id)jsonFromResource:(NSString *)resource;

@end
// Copyright belongs to original author
// http://code4app.net (en) http://code4app.com (cn)
// From the most professional code share website: Code4App.net