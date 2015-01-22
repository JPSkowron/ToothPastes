//
//  ViewController.m
//  ToothPastesIHaveLovedAndAdored
//
//  Created by JP Skowron on 1/22/15.
//  Copyright (c) 2015 JP Skowron. All rights reserved.
//

#import "adoredToothPastesViewController.h"
#import "ToothPastesTableViewController.h"

#define kNSUserDefaultsLastSavedKey @"lastSavedKey"

@interface adoredToothPastesViewController () <UITableViewDelegate, UITableViewDataSource>
@property NSMutableArray *adoredThoothpastes;
@property (strong, nonatomic) IBOutlet UITableView *toothPastesTableView;
@end

@implementation adoredToothPastesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self load];

    if (self.adoredThoothpastes == nil){
        self.adoredThoothpastes = [NSMutableArray new];
    }


}
-(NSURL *)documentsDirectory {
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] firstObject];

}
-(void)load {

    NSURL *plist = [[self documentsDirectory] URLByAppendingPathComponent:@"pastes.plist"];
    self.adoredThoothpastes = [NSMutableArray arrayWithContentsOfURL:plist];

}
-(void)save{

    NSURL *plist = [[self documentsDirectory] URLByAppendingPathComponent:@"pastes.plist"];
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];

    [self.adoredThoothpastes writeToURL:plist atomically:YES];

    [userDefaults setObject:[NSDate date] forKey:kNSUserDefaultsLastSavedKey];
    [userDefaults synchronize];

}
-(IBAction)unwindFromToothPasteViewController:(UIStoryboardSegue *)segue {
    ToothPastesTableViewController *viewController = segue.sourceViewController;
    [self.adoredThoothpastes addObject:[viewController adoredToothpaste]];
    [self save];
    [self.toothPastesTableView reloadData];

    

}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {


    return self.adoredThoothpastes.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MyCellID"];
    cell.textLabel.text = [self.adoredThoothpastes objectAtIndex:indexPath.row];
    return  cell;
}
@end
