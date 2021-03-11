//
//  TooltipObjcViewController.m
//  AndesUI-demoapp
//
//  Created by Juan Andres Vasquez Ferrer on 23-02-21.
//  Copyright © 2021 MercadoLibre. All rights reserved.
//

#import "TooltipObjcViewController.h"

@interface TooltipObjcViewController () <AndesDropdownDelegate>

@property (weak, nonatomic) IBOutlet UITextField *titleTextField;
@property (weak, nonatomic) IBOutlet UITextView *contentTextView;
@property (weak, nonatomic) IBOutlet AndesDropdown *typeDropdown;

@property(nonatomic) NSMutableArray *cellArray;
@property(nonatomic) NSArray *typeArray;
@property(nonatomic) AndesTooltip *tooltip;
@property(nonatomic) NSString *selectedType;


@end

@implementation TooltipObjcViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupView];
    [self setupDropdown];

}

-(void)setupView {
    self.contentTextView.layer.borderColor = UIColor.lightGrayColor.CGColor;
    self.contentTextView.layer.borderWidth = 1;
}

-(void)setupDropdown {
    
    AndesDropDownMenuCell *light = [[AndesDropDownMenuCell alloc]
                                   initWithTitle:@"light"
                                   thumbnail:nil];
    
    AndesDropDownMenuCell *dark = [[AndesDropDownMenuCell alloc]
                                   initWithTitle:@"dark"
                                   thumbnail:nil];
    
    AndesDropDownMenuCell *highlight = [[AndesDropDownMenuCell alloc]
                                   initWithTitle:@"highlight"
                                   thumbnail:nil];
    

    self.typeArray = @[@"light", @"dark", @"highlight"];
    self.cellArray = [[NSMutableArray alloc]init];
    [self.cellArray addObject:light];
    [self.cellArray addObject:dark];
    [self.cellArray addObject:highlight];
    
    self.typeDropdown.delegate = self;
    [self.typeDropdown setTriggerType: [[FormDropdownTrigger alloc]
                                       initWithTitle:@"Type"
                                       placeholder:@"light"
                                       helperText:nil]];
    
    [self.typeDropdown setMenuType:[[DropdownBottomSheetMenu alloc]
                                    initWithSeparatorStyle:AndesSeparatorStyleSingleLine
                                    numberOfLines:1
                                    rows:self.cellArray
                                    selectionStyle:AndesSelectionStyleDefaultStyle]];
}

-(void)configDropdownOptions {
    
}

- (IBAction)buttonTapped:(id)sender {
    if (self.tooltip) {
        [self.tooltip dismiss];
    }
    
    AndesTooltipType type = [self getTooltipType];
    
    self.tooltip = [[AndesTooltip alloc] initWithType:type content:self.contentTextView.text title:self.titleTextField.text isDismissable:YES primaryLoudAction:nil];
    
    UIButton *b = (UIButton *)sender;
    [self.tooltip showIn:b within:self.view position:AndesTooltipPositionTop];
    
}

-(AndesTooltipType)getTooltipType {
    if (self.selectedType == nil) {
        return AndesTooltipTypeLight;
    }
    
    if ([self.selectedType  isEqual: @"light"]) {
        return AndesTooltipTypeLight;
    }
    
    if ([self.selectedType  isEqual: @"dark"]) {
        return AndesTooltipTypeDark;
    }
    
    if ([self.selectedType  isEqual: @"highlight"]) {
        return AndesTooltipTypeHighlight;
    }
    
    return AndesTooltipTypeLight;
}

- (void)didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    self.selectedType = self.typeArray[indexPath.row];
}

@end
