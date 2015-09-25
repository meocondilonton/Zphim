//
//  NSString+UrlEncoding.m
//  TheMovieDB
//
//  Created by Kevin Mindeguia on 26/06/2013.
//  Copyright (c) 2013 iKode Ltd. All rights reserved.
//


#import "KM_NSString+UrlEncoding.h"

@implementation NSString (KM_NSString_UrlEncoding)

-(NSString*)urlEncodedString{
    NSString* unEncodedString = [self stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSString* encodedString = [unEncodedString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    return encodedString;
}

@end
// Copyright belongs to original author
// http://code4app.net (en) http://code4app.com (cn)
// From the most professional code share website: Code4App.net