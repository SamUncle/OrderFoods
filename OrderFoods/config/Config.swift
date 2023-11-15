//
//  Config.swift
//  OrderFoods
//
//  Created by admin on 2023/11/15.
//

import Foundation
//配置
let BASE_URL = "https://httpbin.org"
func Dlog (_ item : Any, _ str: String = " ",file : String = #file, lineNum : Int = #line){
   #if DEBUG
       let fileName = (file as NSString).lastPathComponent
       print ("fileName:\(fileName)\n lineNum:\(lineNum)\n \(item)",str)
   #endif
}
