//
//  PersonInfoTableViewCell.h
//  loterryTicket
//
//  Created by gleeeli on 2017/6/24.
//  Copyright © 2017年 luoluo. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PersonInfoTableViewCell;

@protocol PersonInfoCellDelegate<NSObject>

- (void)textfieldChange:(PersonInfoTableViewCell *)cell;

@end

@interface PersonInfoTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *leftTitleLabel;
@property (weak, nonatomic) IBOutlet UITextField *contentTextField;

@property (assign, nonatomic) BOOL isEdit;

@property (weak, nonatomic) id<PersonInfoCellDelegate> delegate;
@property (strong, nonatomic) NSIndexPath *indexPath;
@end


