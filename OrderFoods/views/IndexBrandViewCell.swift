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
class IndexBrandViewCell: UITableViewCell {
    private var bag: DisposeBag = DisposeBag()
    private var brandBtn: UIButton!
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
            self.brandBtn.kf.setBackgroundImage(with: url, for: .normal)

        }).disposed(by: bag)
        viewModel.brandID.drive(countLabel.rx.text).disposed(by: bag)
        viewModel.brandName.drive(brandName.rx.text).disposed(by: bag)
        
    }
    
    private func setUpUI() {
        brandBtn = UIButton(type: .custom)
        contentView.addSubview(brandBtn)
        brandBtn.translatesAutoresizingMaskIntoConstraints = false
        brandBtn.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 20).isActive = true
        brandBtn.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        brandBtn.widthAnchor.constraint(equalToConstant: 70).isActive = true
        brandBtn.heightAnchor.constraint(equalToConstant: 70).isActive = true
        
        let icon = UIImageView(image: UIImage(named: "icon_home_original_musicnote16x16"))
        contentView.addSubview(icon)
        icon.translatesAutoresizingMaskIntoConstraints = false
        icon.topAnchor.constraint(equalTo: brandBtn.topAnchor, constant: 8).isActive = true
        icon.leftAnchor.constraint(equalTo: brandBtn.rightAnchor, constant: 10).isActive = true
        
        brandName = UILabel()
        brandName.textColor = UIColor.black
        brandName.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(brandName)
        brandName.centerYAnchor.constraint(equalTo: icon.centerYAnchor).isActive = true
        brandName.leftAnchor.constraint(equalTo: icon.rightAnchor, constant: 4).isActive = true
        
        countLabel = UILabel()
        countLabel.textColor = UIColor.gray
        contentView.addSubview(countLabel)
        countLabel.translatesAutoresizingMaskIntoConstraints = false
        countLabel.leftAnchor.constraint(equalTo: icon.leftAnchor).isActive = true
        countLabel.topAnchor.constraint(equalTo: brandName.bottomAnchor, constant: 15).isActive = true
         
        
        let btnStack = UIStackView()
        btnStack.axis = .horizontal
        btnStack.spacing = 20
        contentView.addSubview(btnStack)
        btnStack.translatesAutoresizingMaskIntoConstraints = false
        btnStack.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -20).isActive = true
        btnStack.topAnchor.constraint(equalTo: brandBtn.topAnchor, constant: 5).isActive = true
        
        let collectionBtn = UIButton(type: .system)
        collectionBtn.setImage(UIImage(named: "icon_white_nocollection24x24")?.withRenderingMode(.alwaysOriginal), for: .normal)
        
        let detailBtn = UIButton(type: .system)
        detailBtn.setImage(UIImage(named: "icon_ost_detail24x24")?.withRenderingMode(.alwaysOriginal), for: .normal)
        
        btnStack.addArrangedSubview(collectionBtn)
        btnStack.addArrangedSubview(detailBtn)
        
    }

}
