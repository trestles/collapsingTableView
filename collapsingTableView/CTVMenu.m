//
//  CTVMenu.m
//  collapsingTableView
//
//  Created by jonathan twaddell on 9/8/14.
//  Copyright (c) 2014 jrturton. All rights reserved.
//

#import "CTVMenu.h"
#import "CTVMenuHeader.h"
#import "CTVMenuItem.h"

@implementation CTVMenu


// let me apologize for this menu before you look at it
+(CTVMenu *)getOne
{
  CTVMenu *menu=[[CTVMenu alloc] init];
  menu.name=@"menu name";
  menu.menuHeaders=[[NSMutableArray alloc] init];
  
  
  CTVMenuHeader *mh1=[[CTVMenuHeader alloc] init];
  mh1.name=@"menu header 1";
  mh1.menuHeaderID=@7;
  mh1.menuHeaders=[[NSMutableArray alloc] init];
  mh1.menuItems=[[NSMutableArray alloc] init];
  [menu.menuHeaders addObject:mh1];
  
  
  CTVMenuHeader *subMH1=[[CTVMenuHeader alloc] init];
  subMH1.name=@"sub menu-header 1";
  subMH1.menuHeaderID=@11;
  subMH1.menuItems=[[NSMutableArray alloc] init];

  [mh1.menuHeaders addObject:subMH1];
  
  // lets add an item
  CTVMenuItem *mi1=[[CTVMenuItem alloc] init];
  mi1.name=@"sub1 - menu item name #1";
  mi1.menuHeaderID=@11;
  [subMH1.menuItems addObject:mi1];

  CTVMenuItem *mi2=[[CTVMenuItem alloc] init];
  mi2.name=@"sub1 - menu item name #2";
  mi2.menuHeaderID=@11;
  [subMH1.menuItems addObject:mi2];

  NSLog(@"here is a subMH1.menuItems: %@", subMH1.menuItems);
  
  CTVMenuHeader *mh2=[[CTVMenuHeader alloc] init];
  mh2.name=@"menu header 1";
  mh2.menuHeaderID=@9;

  [menu.menuHeaders addObject:mh2];
  mh2.menuItems=[[NSMutableArray alloc] init];
  
  // lets add an item
  CTVMenuItem *mi3=[[CTVMenuItem alloc] init];
  mi3.name=@"sub2 - menu item name #1";
  [mh2.menuItems addObject:mi3];

  
  return menu;
}


-(void)processMenuHeader:(CTVMenuHeader *)menuHeader
{
  if([menuHeader.menuHeaders count] > 0){
    for(CTVMenuHeader *mh in menuHeader.menuHeaders){
      [self.menuList addObject:mh];
      NSLog(@"that is greater than 0");
      [self processMenuHeader:mh];
    }
  }
  if([menuHeader.menuItems count] > 0){
    for(CTVMenuItem *mi in menuHeader.menuItems){
      NSLog(@"mi's exist in here");
      [self.menuList addObject:mi];
    }
  }else{
    NSLog(@"couunt == 0");
  }
}

-(NSMutableArray *)processAsList
{
  self.menuList=[[NSMutableArray alloc] init];
  
  for(CTVMenuHeader *mh in self.menuHeaders){
    [self.menuList addObject:mh];
    if([mh.menuHeaders count] > 0){
      NSLog(@"that is greater than 0");
      [self processMenuHeader:mh];
    }
    for(CTVMenuItem *mi in mh.menuItems){
      NSLog(@"mi's exist");
      [self.menuList addObject:mi];
    }
  }
  
  return self.menuList;
}



@end
