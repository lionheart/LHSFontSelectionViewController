//
//  LHFontSelectionViewController.m
//  LHFontSelectionViewController
//
//  Created by Dan Loewenherz on 12/18/13.
//
//

#import "LHTableViewCellValue1.h"
#import "LHFontSelectionViewController.h"

static NSString *CellIdentifier = @"Cell";

@interface LHFontSelectionViewController ()

@end

@implementation LHFontSelectionViewController

- (id)initWithStyle:(UITableViewStyle)style {
    self = [super initWithStyle:UITableViewStylePlain];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Font";
    self.currentFontName = [self.delegate fontNameForFontSelectionViewController:self];
    
    self.fonts = [NSMutableArray array];
    self.fontsForSectionIndex = [NSMutableDictionary dictionary];
    self.sectionIndexTitles = [NSMutableArray array];
    for (NSString *familyName in [UIFont familyNames]) {
        for (NSString *fontName in [UIFont fontNamesForFamilyName:familyName]) {
            [self.fonts addObject:fontName];
            
            NSString *firstCharacter = [fontName substringToIndex:1];
            if (![self.sectionIndexTitles containsObject:firstCharacter]) {
                [self.sectionIndexTitles addObject:firstCharacter];
                self.fontsForSectionIndex[firstCharacter] = [NSMutableArray arrayWithObject:fontName];
            }
            else {
                [self.fontsForSectionIndex[firstCharacter] addObject:fontName];
            }
        }
    }
    
    [self.sectionIndexTitles sortUsingComparator:^(NSString *a, NSString *b) {
        return [a compare:b];
    }];
    
    [self.fonts sortUsingComparator:^(NSString *obj1, NSString *obj2) {
        return [obj1 compare:obj2];
    }];
    
    [[NSNotificationCenter defaultCenter] addObserver:self.tableView selector:@selector(reloadData) name:UIContentSizeCategoryDidChangeNotification object:nil];
    
    [self.tableView registerClass:[LHTableViewCellValue1 class] forCellReuseIdentifier:CellIdentifier];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    NSIndexPath *indexPathForCurrentlySelectedFont = [self indexPathForFontName:self.currentFontName];
    [self.tableView scrollToRowAtIndexPath:indexPathForCurrentlySelectedFont atScrollPosition:UITableViewScrollPositionTop animated:NO];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.sectionIndexTitles.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSString *sectionName = self.sectionIndexTitles[section];
    return [self.fontsForSectionIndex[sectionName] count];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return self.sectionIndexTitles[section];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    cell.accessoryType = UITableViewCellAccessoryNone;
    cell.textLabel.text = nil;
    cell.textLabel.font = nil;
    cell.detailTextLabel.text = nil;
    cell.detailTextLabel.font = nil;
    
    NSString *sectionName = self.sectionIndexTitles[indexPath.section];
    NSString *fontName = self.fontsForSectionIndex[sectionName][indexPath.row];
    
    cell.textLabel.text = fontName;
    cell.textLabel.font = [UIFont fontWithName:fontName size:[self.delegate fontSizeForFontSelectionViewController:self] + 4];
    if ([fontName isEqualToString:self.currentFontName]) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }
    
    return cell;
}

- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView {
    return self.sectionIndexTitles;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSIndexPath *indexPathForPreviouslySelectedFont = [self indexPathForFontName:self.currentFontName];
    
    NSString *sectionName = self.sectionIndexTitles[indexPath.section];
    NSString *fontName = self.fontsForSectionIndex[sectionName][indexPath.row];
    
    if (![fontName isEqualToString:self.currentFontName]) {
        self.currentFontName = fontName;
        [self.delegate setFontName:fontName forFontSelectionViewController:self];
        
        [self.tableView beginUpdates];
        [self.tableView reloadRowsAtIndexPaths:@[indexPathForPreviouslySelectedFont, indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
        [self.tableView endUpdates];
    }
}

#pragma mark - Utils

- (NSIndexPath *)indexPathForFontName:(NSString *)font {
    NSString *firstCharacter = [self.currentFontName substringToIndex:1];
    NSInteger section = [self.sectionIndexTitles indexOfObject:firstCharacter];
    NSInteger row = [self.fontsForSectionIndex[firstCharacter] indexOfObject:font];
    return [NSIndexPath indexPathForRow:row inSection:section];
}
@end
