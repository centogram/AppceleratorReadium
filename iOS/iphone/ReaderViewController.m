
#import "ReaderViewController.h"
#import "ContainerList.h"
#import "ContainerController.h"

@interface ReaderViewController ()

@end

@implementation ReaderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)dealloc{
}

-(id)initWithArray:(NSArray *)paths{
    self = [super init];
    if (self) {
        self.m_paths = paths;
    };
    return self;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;

        NSString *path = [self.m_paths objectAtIndex:indexPath.row];
       
        NSArray *components = path.pathComponents;
        cell.textLabel.text = (components == nil || components.count == 0) ?
        @"" : components.lastObject;
    }
    
    return cell;
}

- (void)
tableView:(UITableView *)tableView
didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSString *path = [self.m_paths objectAtIndex:indexPath.row];
    ContainerController *c = [[ContainerController alloc] initWithPath:path];

    if (c != nil) {
        [self.navigationController pushViewController:c animated:YES];
    }
}


- (NSInteger)
tableView:(UITableView *)tableView
numberOfRowsInSection:(NSInteger)section
{
    return [self.m_paths count];
}


- (void)viewDidLayoutSubviews {
   // m_table.frame = self.view.bounds;
}

@end
