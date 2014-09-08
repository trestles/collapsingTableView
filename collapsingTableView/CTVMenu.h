//
//  CTVMenu.h
//  collapsingTableView
//
//  Created by jonathan twaddell on 9/8/14.
//  Copyright (c) 2014 jrturton. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CTVMenu : NSObject

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSMutableArray *menuHeaders;
@property (nonatomic, strong) NSMutableArray *menuList;

-(NSMutableArray *)processAsList;

+(CTVMenu *)getOne;

@end
