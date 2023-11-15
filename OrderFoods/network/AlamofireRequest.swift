//
//  AlamofireRequest.swift
//  OrderFoods
//
//  Created by admin on 2023/11/15.
//

import UIKit
import Alamofire
@objc protocol RequestEvent {
    @objc optional func responseBefore(_ url:String )
    @objc optional func responseError(_ url:String , error: AnyObject)
    @objc optional func responseReturnData(_ url:String , data: Data)
    func responseReturn(_ url:String , jsonStr: String)
}
struct Login: Encodable {
    let email: String
    let password: String
}
class AlamofireRequest:NSObject {
    class func postParametersUrl(url:String ,parameters: Encodable , delegate:RequestEvent) {
        delegate.responseBefore?(url)
        AF.request(url,
                   method: .post,
                   parameters: parameters,
                   encoder: JSONParameterEncoder.default).response { response in
            debugPrint(response)
            switch response.result {
            case .success(let data):
//                debugPrint("Validation Successful")
                let jsonString = String(data: data ?? Data(), encoding: .utf8)
//                Dlog("接口响应：\(String(describing: jsonString))")
                delegate.responseReturn(url,jsonStr: jsonString ?? "")
            case let .failure(error):
                debugPrint(error)
                
                delegate.responseError?(url, error: error as AnyObject)
                
            }
        }
    }
}

