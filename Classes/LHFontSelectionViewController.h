//
//  LHFontSelectionViewController.h
//  LHFontSelectionViewController
//
//  Created by Dan Loewenherz on 12/18/13.
//
//

#import <UIKit/UIKit.h>
#import "LHFontSelecting.h"

@interface LHFontSelectionViewController : UITableViewController

@property (nonatomic, strong) NSMutableArray *fonts;
@property (nonatomic, strong) NSString *currentFontName;
@property (nonatomic, strong) UISlider *slider;
@property (nonatomic, strong) NSMutableArray *sectionIndexTitles;
@property (nonatomic, strong) NSMutableDictionary *fontsForSectionIndex;
@property (nonatomic, strong) UIActionSheet *sizeAdjustmentActionSheet;
@property (nonatomic, strong) id<LHFontSelecting> delegate;

- (NSIndexPath *)indexPathForFontName:(NSString *)font;

@end
