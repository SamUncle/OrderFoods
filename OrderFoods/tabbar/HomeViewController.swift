//
//  HomeViewController.swift
//  OrderFoods
//
//  Created by admin on 2023/11/14.
//

import UIKit
import RxCocoa
import RxSwift
import SnapKit
import NSObject_Rx
private let IndexBrandViewCellId:String = "IndexBrandViewCell"
class HomeViewController: UIViewController,RequestEvent {
    //自定义网络请求回调实现
    func responseReturn(_ url: String, jsonStr: String) {
        Dlog(jsonStr)
    }
    private var tableView: UITableView = UITableView(frame: CGRect.zero, style: .plain)
    fileprivate var didScroll: ((UIScrollView) -> ())?
    private var bag: DisposeBag = DisposeBag()
    private let homeViewModel = HomeViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
//        view.backgroundColor = UIColor("f7f7f7")
        tableView.backgroundColor = UIColor("f7f7f7")
        tableView.showsVerticalScrollIndicator = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(IndexBrandViewCell.self, forCellReuseIdentifier: IndexBrandViewCellId)
        tableView.estimatedRowHeight = 95
        tableView.separatorStyle = .none
        view.addSubview(tableView)
    
        tableView.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
            make.left.right.equalToSuperview()
            make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom)
        }
        
        
        if #available(iOS 11.0, *) {
            tableView.contentInsetAdjustmentBehavior = .never
        } else {
            automaticallyAdjustsScrollViewInsets = false
        }
//        let login = Login(email: "test@test.test", password: "testPassword")
//        AlamofireRequest.postParametersUrl(url: BASE_URL + "/post",parameters: login, delegate: self)
        homeViewModel.requestData()
        homeViewModel.dataSourceDriver.drive(onNext: { [weak self] _ in
            guard let `self` = self else { return }
            self.tableView.reloadData()
        }).disposed(by: bag)
         
    }
}
 
extension HomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 85
    }
}

extension HomeViewController: UITableViewDataSource {
   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return homeViewModel.dataSource.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: IndexBrandViewCellId, for: indexPath) as! IndexBrandViewCell
        let cellViewModel = homeViewModel.dataSource[indexPath.row]
        cell.bind(viewModel: cellViewModel)
        return cell
    }
}

