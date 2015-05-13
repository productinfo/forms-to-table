//
//  Person.m
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

#import "Person.h"
#import "Avatar.h"

@implementation Person

- (id)initWithForename:(NSString *)forename surname:(NSString *)surname
          emailAddress:(NSString *)emailAddress avatar:(Avatar *)avatar {
  self = [super init];
  if (self) {
    self.forename = forename;
    self.surname = surname;
    self.emailAddress = emailAddress;
    self.avatar = avatar;
  }
  return self;
}

- (NSString *)fullName {
  return [NSString stringWithFormat:@"%@ %@", self.forename, self.surname];
}

@end
