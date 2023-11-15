//
//  IndexBrandCellViewModel.swift
//  OrderFoods
//
//  Created by admin on 2023/11/15.
//

import RxSwift
import RxCocoa
class IndexBrandCellViewModel{
    var bag: DisposeBag = DisposeBag()
    
    private let brand: BehaviorRelay<IndexBrand>
    
    init(brand: IndexBrand) {
        self.brand = BehaviorRelay(value: brand)
    }
}
// MARK: - 界面数据绑定
extension IndexBrandCellViewModel{
    
    public var brandDriver: Driver<IndexBrand> {
        return brand.asDriver()
    }
    
    public var brandName: Driver<String> {
        return brandDriver.map {
            return $0.brandName
        }.asDriver()
    }
    
    public var brandID: Driver<String> {
        return brandDriver.map {
            return "\($0.brandID)"
        }.asDriver()
    }
    public var brandLogo: Driver<URL?> {
        return brandDriver.map {
            return URL(string: $0.brandLogo) ?? nil
        }.asDriver()
    }
    
    public var brandType: Driver<String> {
        return brandDriver.map {
            return $0.brandType
        }.asDriver()
    }
}
