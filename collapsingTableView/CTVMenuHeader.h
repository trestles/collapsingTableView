//
//  CTVMenuHeader.h
//  collapsingTableView
//
//  Created by jonathan twaddell on 9/8/14.
//  Copyright (c) 2014 jrturton. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CTVMenuHeader : NSObject

@property (nonatomic, strong) NSString *name;
@property (nonatomic, assign) NSNumber *menuHeaderID;
@property (nonatomic, strong) NSMutableArray *menuHeaders;
@property (nonatomic, strong) NSMutableArray *menuItems;

@end
