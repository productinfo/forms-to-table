//
//  FixedWidthFormFieldLayout.m
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

#import "FixedWidthFormFieldLayout.h"

@implementation FixedWidthFormFieldLayout

- (void)layout:(SFormFieldView *)fieldView {
  // Let our parent do the bulk of hte layout work
  [super layout:fieldView];
  
  // Set the width of the input element
  CGRect inputFrame = fieldView.inputElement.frame;
  inputFrame.size.width = self.width;
  fieldView.inputElement.frame = inputFrame;
  
  // Set the width of the field view
  CGRect fieldFrame = fieldView.frame;
  fieldFrame.size.width = self.width;
  fieldView.frame = fieldFrame;
}

@end
