//
//  KM_NSURL+Parameters.m
//  TheMovieDB
//
//  Created by Kevin Mindeguia on 26/06/2013.
//  Copyright (c) 2013 iKode Ltd. All rights reserved.
//

#import "KM_NSURL+Parameters.h"


@implementation NSURL (KM_NSURL_Parameters)

+ (NSURL*)URLWithString:(NSString*)urlString additionalParameters:(NSString*)additionalParameters{
    
    NSURL* url = [NSURL URLWithString:urlString];

    BOOL alreadyHasParameters = url.query.length;
    if (alreadyHasParameters){
        urlString = [urlString stringByAppendingString:@"&"];
    } else {
        urlString = [urlString stringByAppendingString:@"?"];
    }

    urlString = [urlString stringByAppendingString:additionalParameters];

    return [NSURL URLWithString:urlString];
}


@end
// Copyright belongs to original author
// http://code4app.net (en) http://code4app.com (cn)
// From the most professional code share website: Code4App.net