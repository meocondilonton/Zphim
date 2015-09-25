//
//  KMActivityIndicator.h
//  Yodablog
//
//  Created by Kevin Mindeguia on 19/08/2013.
//  Copyright (c) 2013 iKode Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@interface KMActivityIndicator : UIView
{
}

@property (nonatomic) BOOL hidesWhenStopped;
@property (nonatomic, strong) UIColor *color;

-(void)startAnimating;
-(void)stopAnimating;
-(BOOL)isAnimating;

@end
// Copyright belongs to original author
// http://code4app.net (en) http://code4app.com (cn)
// From the most professional code share website: Code4App.net