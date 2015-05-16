

#import <UIKit/UIKit.h>

@interface ReaderViewController : UITableViewController
{
@private __weak UITableView *m_table;
}

@property(nonatomic,retain) NSArray *m_paths;
-(id)initWithArray:(NSArray *)paths;
@end
