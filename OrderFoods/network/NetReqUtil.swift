//
//  NetReqUtil.swift
//  OrderFoods
//
//  Created by admin on 2023/11/15.
//

import Foundation
import Moya
class NetReqUtil {
    static func urlRequestParameters(para:[String:Any]) -> Task {
        return .requestParameters(parameters: para, encoding: URLEncoding.default)
    }
}
