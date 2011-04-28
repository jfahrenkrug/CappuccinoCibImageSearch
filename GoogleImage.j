@import <Foundation/CPObject.j>
 
@implementation GoogleImage : CPObject
{
    CPString title @accessors;
    CPString unescapedUrl @accessors;
    CPString tbUrl @accessors;
    int width @accessors;
    int height @accessors;
}
 
- (id)init
{
    self = [super init];
    
    if (self)
    {
        title = @"";
        unescapedUrl = @"";
        width = 0;
        height = 0;
    }
    
    return self;
}

/*!
    Initializes it with the data from a JSON Object
*/
- (id)initFromJSONObject:(id)aJSONObject
{
    self = [self init];
    
    if (self)
    {  
        // the html entities have to be unescaped
        var e = document.createElement('div');
        e.innerHTML = aJSONObject.titleNoFormatting;
        title = e.childNodes[0].nodeValue;
        unescapedUrl = aJSONObject.unescapedUrl;
        width = aJSONObject.width;
        height = aJSONObject.height;
    }
    
    return self;
}

- (CPString)size
{
    return width + "x" + height;
}

/*!
    Returns an array of images built from an array of JSON objects
*/
+ (CPArray)imagesFromJSONObjects:(id)someJSONObjects
{
    var images = [[CPArray alloc] init];
    
    if (someJSONObjects) 
    {
        for (var i=0; i < someJSONObjects.length; i++) 
        {
            var image = [[GoogleImage alloc] initFromJSONObject:someJSONObjects[i]];
            [images addObject:image];
        };
    }
    
    return images;
}

@end

