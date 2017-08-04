//
//  HomeMenuCell.h
//  YJMeituan
//
//  Created by wanyongjian on 2017/8/2.
//  Copyright © 2017年 eco. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MenuCellDelegate <NSObject>

- (void)menuButtonClickedAtIndex:(NSInteger)index;

@end

@interface HomeMenuCell : UITableViewCell

//@property (nonatomic,copy) void(^menuClick)(UIButton *sender);
@property (nonatomic, strong) NSMutableArray *dataArray;

@property (nonatomic, weak) id<MenuCellDelegate> delegate;
@end
