//
//  MusicListViewModel.swift
//  DouyinSwift
//
//  Created by 赵福成 on 2019/6/5.
//  Copyright © 2019 zhaofucheng. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import Moya
class MusicListViewModel {
    private var musicDataSource: BehaviorRelay<[MusicCellViewModel]> = BehaviorRelay(value: [])
    
    public var dataSourceDriver: Driver<[MusicCellViewModel]> {
        return musicDataSource.asDriver()
    }
    public var dataSource: [MusicCellViewModel] {
        return musicDataSource.value
    }
    
    func requestData(page: Int = 10) {
//        let provider = MoyaProvider<SamApiManager>()
        ApiProvider.request(.createUser(firstName: "James", lastName: "Potter")) { result in
//            Dlog(result)
            switch result {
            case let .success(response):
                do {
                    let filteredResponse = try response.filterSuccessfulStatusCodes()
                    let user = try filteredResponse.map(HTTPOrgPost.self)
                    debugPrint(user.data)
                }
                catch let error {
                    debugPrint(error)
                }
                //自定义解析response 成 json字符串
//                let data = response.data
//                let statusCode = response.statusCode
//                let dataString = String(data: data, encoding: .utf8)
//                print("request success : \(statusCode) \(String(describing: dataString))")
            case let .failure(err):
                print("request fail :\(err)")
            }
        }
        //rxswift 解析
//        ApiProvider.rx.request(.createUser(firstName: "Sam", lastName: "Ming")).filterSuccessfulStatusCodes().map(HTTPOrgPost.self).subscribe { res in
//            switch res {
//            case .success(let http):
//                debugPrint(http.data)
//            case .failure(let err):
//                debugPrint(err)
//            }
//        }
        //rxswift 指定字段解析
        ApiProvider.rx.request(.createUser(firstName: "Zm", lastName: "Ming")).filterSuccessfulStatusCodes().map(String.self,atKeyPath: "data",failsOnEmptyData: false).subscribe { res in
            switch res {
            case .success(let data):
                debugPrint(data)
            case .failure(let err):
                debugPrint(err)
            }
        }
        
//        let observable = ApiProvider.rx.request(.music(page: page)).map([Music].self, atKeyPath: "music", using: JSONDecoder(), failsOnEmptyData: false).asObservable()
//        _ = observable.subscribe(onNext: { [weak self] musics in
//            guard let `self` = self else { return }
//            var newArray = self.musicDataSource.value
//            newArray.append(contentsOf: musics.map { MusicCellViewModel(music: $0) })
//            self.musicDataSource.accept(newArray)
//        })
    }
}
