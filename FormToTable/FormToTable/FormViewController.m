//
//  FormViewController.m
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

#import "FormViewController.h"
#import "Person.h"
#import "Avatar.h"
#import "ViewController.h"

@interface FormViewController()

@property (strong, nonatomic) ShinobiForm *form;
@property (strong, nonatomic) SFormView *formView;
@property (strong, nonatomic) NSArray *avatars;

@end

@implementation FormViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  
  // Create an array of small images to use to pick an avatar
  NSMutableArray *avatarImages = [NSMutableArray new];
  for (Avatar *avatar in [Avatar allAvatars]) {
    [avatarImages addObject:avatar.smallImage];
  }
  
  // Create the form field models
  SFormTextField *forenameField = [[SFormTextField alloc] initWithTitle:@"Forename"];
  forenameField.required = YES;
  
  SFormTextField *surnameField = [[SFormTextField alloc] initWithTitle:@"Surname"];
  surnameField.required = YES;
  
  SFormTextField *emailField = [[SFormEmailField alloc] initWithTitle:@"Email"];
  emailField.required = YES;
  
  SFormChoiceField *avatarField = [[SFormChoiceField alloc] initWithTitle:@"Avatar"
                                                                  choices:avatarImages];
  avatarField.required = YES;
  
  // Create a section model
  SFormSection *section = [[SFormSection alloc] initWithFields:@[forenameField,
                                                                 surnameField,
                                                                 emailField,
                                                                 avatarField]];
  
  // Create a form model
  self.form = [ShinobiForm new];
  self.form.delegate = self;
  self.form.sections = @[section];
  
  // Build the views
  self.formView = [[SFormFormViewBuilder new] buildViewFromModel:self.form];
  self.formView.submitButton = [SFormSubmitButton new];
  
  // Fix the widths of the inputs so they're all the same as the last (the choice field)
  NSArray *fieldViews = ((SFormSectionView *)self.formView.sectionViews[0]).fieldViews;
  CGFloat width = ((SFormFieldView *) [fieldViews lastObject]).inputElement.frame.size.width;
  
  for (SFormFieldView *fieldView in fieldViews) {
    // Set the width on both the input element and the field view itself
    CGRect inputFrame = fieldView.inputElement.frame;
    inputFrame.size.width = width;
    fieldView.inputElement.frame = inputFrame;
    
    CGRect fieldFrame = fieldView.frame;
    fieldFrame.size.width = width;
    fieldView.frame = fieldFrame;
  }
  
  [self.formView sizeToFit];
  [self.view addSubview:self.formView];
  
  self.preferredContentSize = self.formView.frame.size;
}

#pragma mark - SFormDelegate methods

-(void)formDidSubmit:(ShinobiForm *)form {
  // Form was submitted with valid inputs so create a person, dismiss the popover, and add
  // the Person to the parent VC
  Person *person = [self getPersonFromForm:form];
  ViewController *parentVC = (ViewController *)self.presentingViewController;
  
  [self dismissViewControllerAnimated:YES completion:^{
    [parentVC addPerson:person];
  }];
}

- (void)form:(ShinobiForm *)form didNotSubmitWithInvalidFields:(NSArray *)invalidFields {
  // Form was submitted with invalid values.
  // If all the fields are empty then we'll assume the user wanted to cancel the action,
  // so we'll dismiss the popover.
  // Otherwise we'll do nothing - the form will highlight the invalid fields for us.
  Person *person = [self getPersonFromForm:form];
  
  if (!person) {
    [self dismissViewControllerAnimated:YES completion:nil];
  }
}

// Returns a Person based on the form fields, unless all fields are empty, in which case
// returns nil.
- (Person *)getPersonFromForm:(ShinobiForm *)form {
  SFormSection *section = form.sections[0];
  SFormField *field1 = section.fields[0];
  SFormField *field2 = section.fields[1];
  SFormField *field3 = section.fields[2];
  SFormField *field4 = section.fields[3];
  
  if ([field1.value length] == 0 && [field2.value length] == 0 &&
      [field3.value length] == 0 && field4.value == nil) {
    return nil;
  } else {
    // Create a person based on the field values
    NSArray *avatars = [Avatar allAvatars];
    NSInteger index = [field4.value integerValue];
    return [[Person alloc] initWithForename:field1.value
                                    surname:field2.value
                               emailAddress:field3.value
                                     avatar:avatars[index]];
  }
}

@end
