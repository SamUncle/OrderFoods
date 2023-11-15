//
//  IndexBrandViewCell.swift
//  OrderFoods
//
//  Created by admin on 2023/11/15.
//

import UIKit
import RxCocoa
import RxSwift
import Kingfisher
import SnapKit
class IndexBrandViewCell: UITableViewCell {
    private var bag: DisposeBag = DisposeBag()
    private var brandImageV: UIImageView!
    private var brandName: UILabel!
    private var countLabel: UILabel!

    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        contentView.backgroundColor = UIColor.white
        setUpUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        bag = DisposeBag()
    }
    //数据绑定
    func bind(viewModel: IndexBrandCellViewModel) {
        viewModel.brandLogo.drive(onNext: { [weak self] url in
            guard let `self` = self, let url = url else { return }
            self.brandImageV.kf.setImage(with: url)

        }).disposed(by: bag)
//        viewModel.brandID.drive(countLabel.rx.text).disposed(by: bag)
        viewModel.brandName.drive(brandName.rx.text).disposed(by: bag)
        
    }
    
    private func setUpUI() {
        brandImageV = UIImageView()
//        brandImageV.backgroundColor = .gray
        brandImageV.contentMode = .scaleAspectFit
        contentView.addSubview(brandImageV)
         
        brandName = UILabel()
        brandName.textColor = UIColor.black
        contentView.addSubview(brandName)
        
        brandImageV.snp.makeConstraints { make in
            make.width.equalTo(140)
            make.height.equalTo(70)
            make.left.equalToSuperview().offset(15)
        }
        brandName.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.height.equalTo(70)
            make.left.equalTo(brandImageV.snp.right).offset(8)
        }
      
         
        
    }

}
