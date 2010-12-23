@import <Foundation/CPObject.j>
@import "GoogleImage.j"

@implementation AppController : CPObject
{
    CPWindow    theWindow; //this "outlet" is connected automatically by the Cib
    CPTextField textField;
    CPTableView tableView;
    CPImageView imageView;
    CPArray images;
}

- (void)applicationDidFinishLaunching:(CPNotification)aNotification
{
    // This is called when the application is done loading.
}

- (void)awakeFromCib
{
    [theWindow setFullBridge:YES];
}

- (void)search:(id)sender {
    var term = [textField stringValue];
    if (term && [term length] > 0) {
        var request = [CPURLRequest requestWithURL:'http://ajax.googleapis.com/ajax/services/search/images?v=1.0&rsz=large&imgtype=photo&q=' + term];
        [request setHTTPMethod:@"GET"];

        receivedData = nil;
        [CPURLConnection connectionWithRequest:request delegate:self];
    } else {
        alert("Please enter a search term!");
    }
}

/* CPURLConnection delegate methods */ 
 
- (void)connection:(CPURLConnection)connection didReceiveData:(CPString)data
{
    if (!receivedData) {
        receivedData = data;
    } else {
        receivedData += data;
    }
}
 
- (void)connection:(CPURLConnection)connection didFailWithError:(CPString)error
{
    alert("Connection did fail with error : " + error) ;
    receivedData = nil;
}
 
- (void)connectionDidFinishLoading:(CPURLConnection)aConnection
{
    var result = nil;
    
    try {
        result = CPJSObjectCreateWithJSON(receivedData).responseData.results;
    } catch(err) {
        alert("Error while parsing search results: " + err);
    }
    
    if (result) {
        images = [GoogleImage imagesFromJSONObjects:result]
        console.log(images);
        if (images) {
          [tableView reloadData];
        } else {
            alert("Nothing found.");
        }
    }
}

/* CPTableViewDataSource delegate methods */
- (CPInteger)numberOfRowsInTableView:(CPTableView)aTableView
{
    return images ? images.length : 0;
}

- (id)tableView:(CPTableView)aTableView 
      objectValueForTableColumn:(CPTableColumn)aTableColumn 
                            row:(CPInteger)aRowIndex
{
    return [images[aRowIndex] performSelector:CPSelectorFromString([aTableColumn identifier])];
}

/* CPTableViewDelegate methods */
-(void) tableViewSelectionDidChange:(CPNotification)note
{
    var image = [images objectAtIndex:[tableView selectedRow]];
    [imageView setImage:[[CPImage alloc] initWithContentsOfFile:[image unescapedUrl]]];
}

@end


