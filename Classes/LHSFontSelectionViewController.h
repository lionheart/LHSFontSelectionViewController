//
//  LHFontSelectionViewController.h
//  LHFontSelectionViewController
//
//  Created by Dan Loewenherz on 12/18/13.
//
//

#import <UIKit/UIKit.h>
#import "LHFontSelecting.h"

@interface LHSFontSelectionViewController : UITableViewController

@property (nonatomic) BOOL onlyShowPreferredFonts;
@property (nonatomic, strong) NSMutableArray *preferredFontNames;
@property (nonatomic, strong) NSMutableArray *fonts;
@property (nonatomic, strong) NSString *currentFontName;
@property (nonatomic, strong) UISlider *slider;
@property (nonatomic, strong) NSMutableArray *sectionIndexTitles;
@property (nonatomic, strong) NSMutableDictionary *fontsForSectionIndex;
@property (nonatomic, strong) UIActionSheet *sizeAdjustmentActionSheet;
@property (nonatomic, strong) id<LHFontSelecting> delegate;

- (NSArray *)indexPathsForFontName:(NSString *)fontName;
- (instancetype)initWithPreferredFontNames:(NSArray *)fontNames
                    onlyShowPreferredFonts:(BOOL)onlyShowPreferredFonts;

@end