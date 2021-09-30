//
//  ProductModel.swift
//  ttiTest
//
//  Created by iOS-马振宇 on 2021/9/28.
//

import Foundation
import HandyJSON

class ProductModel: HandyJSON {
    required init() {}
    var id = 0
    var sku = ""
    var name = ""
    var price = 0
    var created_at = ""
    var updated_at = ""
}
