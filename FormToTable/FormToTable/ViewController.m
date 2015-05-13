//
//  ViewController.m
//  FormToTable
//
//  Created by Alison Clarke on 12/05/2015.
//
//  Copyright 2015 Scott Logic
//
//  Licensed under the Apache License, Version 2.0 (the "License");
//  you may not use this file except in compliance with the License.
//  You may obtain a copy of the License at
//
//  http://www.apache.org/licenses/LICENSE-2.0
//
//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an "AS IS" BASIS,
//  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//  See the License for the specific language governing permissions and
//  limitations under the License.
//

#import "ViewController.h"
#import "Person.h"
#import "Avatar.h"

@interface ViewController ()

@property (strong, nonatomic) NSMutableArray *people;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UILabel *detailNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *detailEmailLabel;
@property (weak, nonatomic) IBOutlet UIImageView *detailImageView;

@end

@implementation ViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  
  // Create an initial array of Person objects
  self.people = [@[[[Person alloc] initWithForename:@"John"
                                           surname:@"Smith"
                                      emailAddress:@"john.smith@shinobicontrols.com"
                                             avatar:[Avatar allAvatars][1]],
                   [[Person alloc] initWithForename:@"Jane"
                                            surname:@"Brown"
                                       emailAddress:@"jane.brown@shinobicontrols.com"
                                             avatar:[Avatar allAvatars][3]]] mutableCopy];
}

- (void)addPerson:(Person *)person {
  // Add the person to our array, and reload the table
  [self.people addObject:person];
  [self.tableView reloadData];
}

#pragma mark - UITableViewDataSource methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return self.people.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  static NSString *tableCellIdentifier = @"PersonCell";
  
  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:tableCellIdentifier];
  
  if (cell == nil) {
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle
                                  reuseIdentifier:tableCellIdentifier];
  }
  
  Person *person = self.people[indexPath.row];
  cell.textLabel.text = person.fullName;
  cell.detailTextLabel.text = person.emailAddress;
  cell.imageView.image = person.avatar.smallImage;
  return cell;
}

#pragma mark - UITableViewDelegate methods

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  Person *person = self.people[indexPath.row];
  self.detailNameLabel.text = person.fullName;
  self.detailEmailLabel.text = person.emailAddress;
  self.detailImageView.image = person.avatar.largeImage;
}

@end
