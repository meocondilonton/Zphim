//
//  KMMovie.h
//  TheMovieDB
//
//  Created by Kevin Mindeguia on 03/02/2014.
//  Copyright (c) 2014 iKode Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KMMovie : NSObject

@property (nonatomic, copy) NSString* movieTitle;
@property (nonatomic, copy) NSString* movieId;
@property (nonatomic, copy) NSString* movieSynopsis;
@property (nonatomic, copy) NSString* movieYear;
@property (nonatomic, copy) NSString* movieOriginalBackdropImageUrl;
@property (nonatomic, copy) NSString* movieOriginalPosterImageUrl;
@property (nonatomic, copy) NSString* movieThumbnailPosterImageUrl;
@property (nonatomic, copy) NSString* movieThumbnailBackdropImageUrl;
@property (nonatomic, copy) NSString* movieGenresString;
@property (nonatomic, copy) NSString* movieVoteCount;
@property (nonatomic, copy) NSString* movieVoteAverage;
@property (nonatomic, copy) NSString* moviePopularity;
@property (nonatomic, copy) NSString* mnUrlPage;
@property (nonatomic, strong) NSString* movieUrlVideo;
@property (nonatomic, strong) NSString* movieDescription;
@property (nonatomic, strong) NSMutableArray* movieArrType;

- (id)initWithDictionary:(NSDictionary*)dictionary;

@end
// Copyright belongs to original author
// http://code4app.net (en) http://code4app.com (cn)
// From the most professional code share website: Code4App.net