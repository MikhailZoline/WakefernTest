//
//  myProduct.swift
//
//  Created by Mikhail Zoline.
//  Copyright © 2018 MZ. All rights reserved.
//

import UIKit
// myProductd contains an image, url and other data fields
class myProduct : Codable{
// The following fields are specified in JSON from the REST API
    var  weight: String
    var  description: String
    var  product: String
    var  category: String
    var  icon: String
    var  onsale: Bool
    var  index: Int
    var  SKU: String
    var  price: Double
    
    enum CodingKeys: String, CodingKey {
      case weight = "weight"
      case description = "description"
      case product = "product"
      case category = "category"
      case icon = "icon"
      case onsale = "onSale"
      case index = "index"
      case SKU = "SKU"
      case price = "price"
    }
   /*
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        weight = try values.decode(String.self, forKey: .weight)
        description = try values.decode(String.self, forKey: .description)
        product = try values.decode(String.self, forKey: .product)
        category = try values.decode(String.self, forKey: .category)
        icon = try values.decode(String.self, forKey: .icon)
        onsale = try values.decode(Bool.self, forKey: .onsale)
        index = try values.decode(Int.self, forKey: .index)
        SKU = try values.decode(String.self, forKey: .SKU)
        price = try values.decode(Double.self, forKey: .price)
//        let  imageData = NSData(contentsOf: URL(string: icon ) ?? URL(string: "https://securecontent.shoprite.com/legacy/productimagesroot/DJ/0/46700.jpg")!)
//        if imageData != nil {
//            self.image = UIImage(data:imageData! as Data)!
//        }else{
//            self.image = UIImage(named: "failed")!
//        }
    }
    */
}




