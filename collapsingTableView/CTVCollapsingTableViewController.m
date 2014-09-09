//
//  CTVCollapsingTableViewController.m
//  collapsingTableView
//
//  Created by Richard Turton on 07/09/2014.
//  Copyright (c) 2014 jrturton. All rights reserved.
//

#import "CTVCollapsingTableViewController.h"
#import "CTVMenu.h"
#import "CTVMenuHeader.h"
#import "CTVMenuItem.h"

@interface CTVCollapsingTableViewController (){
  NSArray *_menuList;
}


@property (nonatomic,strong) NSMutableArray *sectionOpenFlags;

@end

@implementation CTVCollapsingTableViewController

-(void)viewDidLoad
{
  [super viewDidLoad];
  CTVMenu *menu=[CTVMenu getOne];
  _menuList=[menu processAsList];
  NSLog(@"here is menuList %@", _menuList);
  self.sectionOpenFlags = [@[@NO,@NO] mutableCopy];
  
  // lets test this
  NSMutableArray *testArray=[[NSMutableArray alloc] init];
  // lets add an item
  CTVMenuHeader *mh1=[[CTVMenuHeader alloc] init];
  mh1.name=@"menu-header 1";
  [testArray addObject:mh1];
  
  CTVMenuItem *mi1=[[CTVMenuItem alloc] init];
  mi1.name=@"sub1 - menu item name #1";
  mi1.menuHeaderID=@11;
  [testArray addObject:mi1];
  
  CTVMenuItem *mi2=[[CTVMenuItem alloc] init];
  mi2.name=@"sub1 - menu item name #2";
  mi2.menuHeaderID=@12;
  [testArray addObject:mi2];

  /*
  NSLog(@"here is array %@", testArray);
  NSArray *selected=[testArray filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:
                                          @"(class == %@) AND (menuHeaderID == %i)",
                                          [CTVMenuItem class],
                                          12]];
  //NSArray *selected=[testArray filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"menuHeaderID == %i", 12]];
  NSLog(@"here is selected %@", selected);
   */
}

#pragma mark - Table view data source

/*
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
  return 2;
}
*/

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
  return [_menuList count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  
  id rowItem=_menuList[indexPath.row];
  if([rowItem isKindOfClass:[CTVMenuHeader class]]){
    CTVMenuHeader *tmpMenuHeader= (CTVMenuHeader *) rowItem; //_menuList[indexPath.row];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HeaderCell" forIndexPath:indexPath];
    cell.textLabel.text = [NSString  stringWithFormat:@"%@ and %@", tmpMenuHeader.name, tmpMenuHeader.ID];
    return cell;
  }else if([rowItem isKindOfClass:[CTVMenuItem class]]){
    CTVMenuItem *tmpMenuItem= (CTVMenuItem *) rowItem; //_menuList[indexPath.row];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DetailCell" forIndexPath:indexPath];
    //cell.textLabel.text = tmpMenuItem.name;
    cell.textLabel.text = [NSString  stringWithFormat:@"%@ and %@", tmpMenuItem.name, tmpMenuItem.menuHeaderID];
    return cell;
  }
  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DetailCell" forIndexPath:indexPath];
  return cell;
  /*
  if (indexPath.row == 0)
  {
    // Header cell
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HeaderCell" forIndexPath:indexPath];
    cell.textLabel.text = [NSString stringWithFormat:@"Header %d",indexPath.section + 1];
    return cell;
  }
  else
  {
    // Detail cell
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DetailCell" forIndexPath:indexPath];
    cell.textLabel.text = [NSString stringWithFormat:@"Detail %d",indexPath.row];
    return cell;
  }
  */
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
  //return 44.0;
  
  id rowItem=_menuList[indexPath.row];
  if([rowItem isKindOfClass:[CTVMenuHeader class]]){
    return 44.0f;
  }else if([rowItem isKindOfClass:[CTVMenuItem class]]){
    CTVMenuItem *tmpMI=(CTVMenuItem *)rowItem;
    if(tmpMI.showFlag==YES){
      return 44.0f;
    }else{
    return 0.0f;
     }
  }else{
    return 44.0f;
  }
  
  
  /*
  if (indexPath.row == 0)
    return 44.0;
  
  if ([self.sectionOpenFlags[indexPath.section] boolValue])
  {
    return 44.0;
  }
  else
  {
    return 0.0;
  }
  */
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
  [tableView deselectRowAtIndexPath:indexPath animated:YES];
  id rowItem=_menuList[indexPath.row];
  if([rowItem isKindOfClass:[CTVMenuHeader class]]){
     CTVMenuHeader *tmpMenuHeader= (CTVMenuHeader *) rowItem; //_menuList[indexPath.row];
    
    NSLog(@"menu header id: %@", tmpMenuHeader.ID);
   
    NSArray *selected=[_menuList filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:
                                                              @"(class == %@) AND (menuHeaderID == %@)",
                                                              [CTVMenuItem class],
                                                              tmpMenuHeader.ID]];
    /*
    NSArray *selected=[_menuList filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:
                                                              @"(class == %@)",
                                                              [CTVMenuItem class]]];
   */
    NSLog(@"here is selected %@", selected);
    for(CTVMenuItem *mi in selected){
      mi.showFlag=!mi.showFlag;
    }
    [tableView beginUpdates];
    [tableView endUpdates];
  
//  NSArray *selected=[_menuList filteredArrayUsingPredicate:[NSPredicate
//                                        predicateWithFormat:@"menuHeaderID == %@", 11]];
    
//    NSLog(@"here is selected array: %@", selected);
  }
  /*
  if (indexPath.row == 0)
  {
    // Toggle open flag
    BOOL currentOpenStatus = [self.sectionOpenFlags[indexPath.section] boolValue];
    self.sectionOpenFlags[indexPath.section] = @(!currentOpenStatus);
    [tableView beginUpdates];
    [tableView endUpdates];
  }
  */
}

@end
