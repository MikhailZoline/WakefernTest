# WakefernTest
Loading a massive number of images asynchronously in a UITableView
without the help of third-party libraries.

At the beginning the list of products is downloaded from backend API via 
asynchronous network request with URLSession DataTask.

A JSON stanza recived from the backend API looks like this:
```javascript
[{
  "weight": "21 oz",
  "description": "6 bagels. Low fat.",
  "product": "Pepperidge Farm Bagels - Plain Pre-Sliced",
  "category": "Bakery",
  "icon": "https://securecontent.shoprite.com/legacy/productimagesroot/DJ/0/46700.jpg",
  "price": 3.1,
  "onSale": false,
  "index": 0,
  "SKU": "014100078081"
  }, ]
```
Once the list is received, the local array of records is filled via 
JSONSerialization in the completion block of URLSession dataTask and 
only then the table view is reloaded from the main thread.

At the moment of the first reloading the tableView could fill only text labels.
The cell image is temporary assigned to a placeholder image
while waiting for download of image data. 
The NSCashe is used as a collection of UIImage objects.
If there is no cached copy of the given image, then image data will be downloaded 
asynchronously from server using the URLSession dataTask on the background.

Assuming the image is downloaded successfully,
the code will switch to the main thread in order to load it to the image view and add to the cache. 
This is important since all UI tasks should be performed in the main queue and not in a background thread.
