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
#import "FixedWidthFormFieldLayout.h"

@interface FormViewController()<SFormDelegate>

@property (strong, nonatomic) ShinobiForm *form;
@property (strong, nonatomic) SFormView *formView;

@end

@implementation FormViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  
  // Create the form field models
  SFormTextField *forenameField = [[SFormTextField alloc] initWithTitle:@"Forename"];
  forenameField.required = YES;
  
  SFormTextField *surnameField = [[SFormTextField alloc] initWithTitle:@"Surname"];
  surnameField.required = YES;
  
  SFormTextField *emailField = [[SFormEmailField alloc] initWithTitle:@"Email"];
  emailField.required = YES;
  
  // Create an array of small images to use to pick an avatar
  NSArray *avatarImages = [Avatar.allAvatars valueForKey:@"smallImage"];
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
  
    // Create a fixed width layout
    FixedWidthFormFieldLayout *layout = [[FixedWidthFormFieldLayout alloc] init];
    
    // Set the width of the layout to match that of our last field (the choice field)
    NSArray *fieldViews = ((SFormSectionView *)self.formView.sectionViews[0]).fieldViews;
    layout.width = ((SFormFieldView *) [fieldViews lastObject]).inputElement.frame.size.width;
    
    // Apply the layout to every field
    for (SFormFieldView *fieldView in fieldViews) {
      fieldView.layout = layout;
    }
    
    [self.formView sizeToFit];
    [self.view addSubview:self.formView];
  
    self.preferredContentSize = self.formView.frame.size;
}

#pragma mark - SFormDelegate methods

- (void)formDidSubmit:(ShinobiForm *)form {
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
  SFormField *forenameField = section.fields[0];
  SFormField *surnameField = section.fields[1];
  SFormField *emailField = section.fields[2];
  SFormField *avatarField = section.fields[3];
  
  if ([forenameField.value length] == 0 && [surnameField.value length] == 0 &&
      [emailField.value length] == 0 && avatarField.value == nil) {
    return nil;
  } else {
    // Create a person based on the field values
    NSArray *avatars = [Avatar allAvatars];
    NSInteger index = [avatarField.value integerValue];
    return [[Person alloc] initWithForename:forenameField.value
                                    surname:surnameField.value
                               emailAddress:emailField.value
                                     avatar:avatars[index]];
  }
}

@end
