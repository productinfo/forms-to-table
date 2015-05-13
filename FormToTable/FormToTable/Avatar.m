//
//  Avatar.m
//  FormToTable
//
//  Created by Alison Clarke on 13/05/2015.
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

#import "Avatar.h"


@interface Avatar()

- (id)initWithName:(NSString *)name;

@end

static NSArray *avatars;

@implementation Avatar

+ (NSArray *)allAvatars {
  static dispatch_once_t pred;
  static NSArray *avatars = nil;
  dispatch_once(&pred, ^{
    avatars = @[[[Avatar alloc] initWithName:@"Person1"],
                [[Avatar alloc] initWithName:@"Person2"],
                [[Avatar alloc] initWithName:@"Person3"],
                [[Avatar alloc] initWithName:@"Person4"]];
  });
  return avatars;
}

- (id)initWithName:(NSString *)name {
  self = [super init];
  if (self) {
    _smallImage = [[UIImage imageNamed:name]
                   imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    _largeImage = [[UIImage imageNamed:[NSString stringWithFormat:@"%@Big", name]]
                   imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
  }
  return self;
}

@end
