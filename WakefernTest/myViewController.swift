//
//  ViewController.swift
//  Test
//
//  Created by Mikhail Zoline on 11/8/18.
//  Copyright © 2018 MZ. All rights reserved.
//

import UIKit

fileprivate let myReuseIdentifier = "myTableViewCell"

var productsStub : [[String : Any]] = [["weight" : "21 oz", "description" : "6 bagels. Low fat.", "product" : "Pepperidge Farm Bagels - Plain Pre-Sliced", "category" : "Bakery", "icon" : "https://securecontent.shoprite.com/legacy/productimagesroot/DJ/0/46700.jpg", "price" : 3.10, "onSale" : false, "index" : 0, "SKU" : "014100078081"], ["weight" : "10.5 oz", "description" : "Colombian", "product" : "Maxwell House Coffee", "category" : "Beverages", "icon" : "https://securecontent.shoprite.com/legacy/productimagesroot/DJ/4/750484.jpg", "price" : 3.99, "onSale" : false, "index" : 1, "SKU" : "043000029268"], ["weight" : "128 fl oz", "description" : "Vitamins A & D. 1 gallon", "product" : "ShopRite Milk - 2% Reduced Fat", "category" : "Beverages", "icon" : "https://securecontent.shoprite.com/legacy/productimagesroot/DJ/4/172224.jpg", "price" : 3.65, "onSale" : false, "index" : 2, "SKU" : "041190454648"], ["weight" : "1 lb", "description" : "Store Sliced", "product" : "Fresh Deli Department White American Cheese", "category" : "Deli", "icon" : "https://securecontent.shoprite.com/legacy/productimagesroot/DJ/6/177036.jpg", "price" : 3.99, "onSale" : true, "index" : 3, "SKU" : "277742000005"], ["weight" : "24 fl oz", "description" : "Natural Butter Flavor", "product" : "Aunt Jemima Butter Syrup - Rich", "category" : "Breakfast", "icon" : "https://securecontent.shoprite.com/legacy/productimagesroot/DJ/6/72316.jpg", "price" : 2.99, "onSale" : true, "index" : 4, "SKU" : "030000059401"], ["weight" : "28 oz", "description" : "98% fat free. High in fiber.", "product" : "B&M Bacon & Onion Baked Beans", "category" : "Canned & Packaged", "icon" : "https://securecontent.shoprite.com/legacy/productimagesroot/DJ/0/57880.jpg", "price" : 1.99, "onSale" : true, "index" : 5, "SKU" : "047800330487"], ["weight" : "15.25 oz", "description" : "Pineapple and red and yellow papaya chunks packed in lightly sweetened passion fruit juice. Rich in Vitamins A & C.", "product" : "Dole Mixed Fruit Tropical", "category" : "Canned & Packaged", "icon" : "https://securecontent.shoprite.com/legacy/productimagesroot/DJ/7/54397.jpg", "price" : 1.79, "onSale" : false, "index" : 6, "SKU" : "038900090814"], ["weight" : "6 oz", "description" : "Bag", "product" : "Annie's Homegrown Baked Snack Crackers - Cheddar Squares", "category" : "Snacks", "icon" : "https://securecontent.shoprite.com/legacy/productimagesroot/DJ/9/1371689.jpg", "price" : 2.29, "onSale" : false, "index" : 7, "SKU" : "013562000784"]]

class myViewController : UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var myProducts : [myProduct] = [myProduct]()
    
    @IBOutlet var myTableView : UITableView!
    
    var myCache : NSCache<NSString, UIImage> = NSCache<NSString, UIImage>()
    
    var myQueue: OperationQueue = OperationQueue()
    
    override func viewDidLoad()
    {
        // Call the parent class viewDidLoad
        super.viewDidLoad()
        myQueue.qualityOfService = .userInteractive
        let operation = BlockOperation(block: {[weak self] in
            do {
                let jsonData = try JSONSerialization.data(withJSONObject: productsStub, options: .prettyPrinted)
                // here "jsonData" is the dictionary encoded in JSON data
                self!.myProducts =  try JSONDecoder().decode([myProduct].self, from: jsonData)
                // here "decoded" is of type `Any`, decoded from JSON data
                // you can now cast it with the right type
            } catch {
                print(error.localizedDescription)
            }
        })
        operation.completionBlock = { OperationQueue.main.addOperation {[weak self] in
            self?.myTableView.reloadData()
            }
        }
        myQueue.addOperation(operation)
/*
        // Make a REST request to the Product API to get the list of products
        guard let url = URL(string: "https://depwfc-test-cisd-dev.azure-api.net/mockexample/V1/") else {
            fatalError("Failed to create URL with https://depwfc-test-cisd-dev.azure-api.net/mockexample/V1/")
        }
        var request = URLRequest(url: url)
        request.setValue("d104277a07a74cfb8a52a219bed20f20", forHTTPHeaderField: "Ocp-Apim-Subscription-Key")
        request.httpMethod = "GET"
        URLSession.shared.dataTask(with : request) {
            (data, response, error) in if error != nil {
                fatalError(
                    "Failed Network Request at \(String(describing: request.url))")
            }else{
                OperationQueue.main.addOperation {
                    do {
                        self.myProducts = try
                            JSONDecoder().decode([myProduct].self, from : data!)
                    }catch{
                        fatalError("Failed to Initialize JSON object \(error)")
                    }
                    OperationQueue.main.addOperation {
                        [weak self] in self?.myTableView.reloadData()
                    }
                }
            }
        }.resume()
*/
    }
    
    func tableView(_ tableView
        : UITableView, numberOfRowsInSection section
        : Int)
        ->Int{return myProducts.count}
    
    func tableView(_ tableView
        : UITableView, cellForRowAt indexPath
        : IndexPath)
        ->UITableViewCell
    {
        let myCell = tableView.dequeueReusableCell(withIdentifier: myReuseIdentifier, for: indexPath) as! myTableViewCell
        
        let product = myProducts[indexPath.row]
        // Use cache
        if
            let image = myCache.object(forKey : product.icon as NSString) {
            myCell.Icon.image = image
        }
        else {
            URLSession.shared.dataTask(with: URL(string: product.icon) ?? URL(string: "https://securecontent.shoprite.com/legacy/productimagesroot/DJ/0/46700.jpg")!) {
                (imageData, response, error) in if error != nil {
                    print(error as Any)
                    OperationQueue.main.addOperation {
                        [weak self] in if let image : UIImage =
                            UIImage(named
                                : "failed") {
                            self?.myCache.setObject(
                                image, forKey: product.icon as NSString)
                            if let updateCell =
                                    tableView.cellForRow(at
                                        : indexPath) {
                                    updateCell.imageView?.image = image
                            }
                        }
                    }
                }
                else if (imageData != nil) {
                    OperationQueue.main.addOperation {
                        [weak self] in if let image
                            : UIImage = UIImage(data
                                : imageData! as Data) {
                            self?.myCache
                                .setObject(image, forKey
                                : product.icon as NSString)
                            if myCell == tableView.cellForRow(at:indexPath){
                                myCell.Icon.image = image
                            }
                        }
                    }
                }
            }.resume()
        }
        myCell.Category.text = product.category
        myCell.Description.text = product.description
        myCell.Product.text = product.product
        myCell.Weight.text = product.weight
        myCell.Price.text = String(product.price)
        myCell.OnSale.text = product.onsale ? "OnSale" : "No"
        myCell.SKU.text = product.SKU
        return myCell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 96
    }

    @IBAction func sortByPrice(_ sender : UIButton)
    {
        let operation = BlockOperation(block: {[weak self] in
            self?.myProducts.sort(by: { (prod1, prod2) -> Bool in
                return prod1.price > prod2.price
            } )
            } )
        operation.completionBlock = { OperationQueue.main.addOperation { [weak self] in
            self?.myTableView.reloadData()
            }
        }
        OperationQueue.main.addOperation(operation)
    }
    
    
    @IBAction func sortByCategory(_ sender: UIButton) {
        let operation = BlockOperation(block: {[weak self] in
            self?.myProducts.sort(by: { (prod1, prod2) -> Bool in
                return prod1.category < prod2.category
            } )
        } )
        operation.completionBlock = { OperationQueue.main.addOperation { [weak self] in
            self?.myTableView.reloadData()
            }
        }
        OperationQueue.main.addOperation(operation)
    }

}
