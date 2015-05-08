//
//  ComCentogramReadiumViewController.m
//  Readium
//
//  Created by Ishan Singh on 07/05/15.
//
//

#import "ComCentogramReadiumViewController.h"

@interface ComCentogramReadiumViewController ()

@end

@implementation ComCentogramReadiumViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (id)init
{
    self = [super init];
    if (self) {
        UIViewController *readerViewController=[[UIViewController alloc] init];
        readerViewController.title=@"Epub Reader";
        UIView *readerView=[[UIView alloc] init];
        readerView.backgroundColor=[UIColor whiteColor];
        readerViewController.view=readerView;
        [self initWithRootViewController:readerViewController];
    };
    return self;
}

/*
#pragma mark - Navigation
// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
