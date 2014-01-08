//
//  MapNavigationController.m
//  JOC
//
//  Created by A.C. Gos on 23/12/13.
//  Copyright (c) 2013 Anna Gos. All rights reserved.
//

#import "MapNavigationController.h"
#import "DirectionsViewController.h"
#import "VenueViewController.h"

@interface MapNavigationController ()
@property(nonatomic, strong, readwrite) UISegmentedControl *segmentedControl;
@property(nonatomic, strong, readwrite) NSArray *segmentViewControllers;
@end


@implementation MapNavigationController


  /**
   * This method is called when a view is instantiated from the storyboard.
   */
- (id)initWithCoder:(NSCoder *)decoder {
    self = [super initWithCoder:decoder];
    if (self) {
        [self setup];
    }
    return self;
}

  /**
   * Sets up the view by adding a segmented control to the navigation bar.
   */
- (void)setup {
    self.segmentViewControllers = [self segmentViewControllers];
    NSArray *segments = [[NSArray alloc] initWithObjects:@"Venue", @"Directions", nil];
    self.segmentedControl = [[UISegmentedControl alloc] initWithItems:segments];
    self.segmentedControl.frame = CGRectMake(60, 8, 200, 28);
    [self.segmentedControl addTarget:self action:@selector(segmentChanged:) forControlEvents:UIControlEventValueChanged];
    [self.navigationBar addSubview:self.segmentedControl];

}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.segmentedControl.selectedSegmentIndex = 0;
    [self segmentChanged:self.segmentedControl];
}

  /**
   * Displays the view controller corresponding to chosen segment of the segmented control.
   *
   * @param segmentedControl the segmented control on which a segment got chosen
   */
- (void)segmentChanged:(UISegmentedControl *)segmentedControl {
    NSInteger selectedSegmentIndex = [segmentedControl selectedSegmentIndex];
    UIViewController *viewController = [self.segmentViewControllers objectAtIndex:selectedSegmentIndex];
    NSArray *theViewControllers = [NSArray arrayWithObject:viewController];
    [self setViewControllers:theViewControllers animated:NO];
}

  /**
   * Loads the views used with the segmented control.
   */
- (NSArray *)segmentViewControllers {
    UIViewController *map = (DirectionsViewController *) [self.storyboard instantiateViewControllerWithIdentifier:@"DirectionsViewController"];
    UIViewController *venue = (VenueViewController *) [self.storyboard instantiateViewControllerWithIdentifier:@"VenueViewController"];
    NSArray *viewControllers = [NSArray arrayWithObjects:map, venue, nil];
    return viewControllers;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
