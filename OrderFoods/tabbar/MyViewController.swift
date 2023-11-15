//
//  MyViewController.swift
//  OrderFoods
//
//  Created by admin on 2023/11/14.
//
import UIKit
import RxCocoa
import RxSwift
import SnapKit
import NSObject_Rx
private let CellId: String = "MusicListCellId"
class MyViewController: UIViewController {
    private var tableView: UITableView = UITableView(frame: CGRect.zero, style: .plain)
    fileprivate var didScroll: ((UIScrollView) -> ())?
    private var bag: DisposeBag = DisposeBag()
    
    private let viewModel = MusicListViewModel()
    private let homeViewModel = HomeViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.backgroundColor = UIColor("f7f7f7")
        tableView.showsVerticalScrollIndicator = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(MusicViewCell.self, forCellReuseIdentifier: CellId)

        tableView.estimatedRowHeight = 95
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
            make.left.right.equalToSuperview()
            make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom)
        }
        tableView.separatorStyle = .none
        
        if #available(iOS 11.0, *) {
            tableView.contentInsetAdjustmentBehavior = .never
        } else {
            automaticallyAdjustsScrollViewInsets = false
        }
        viewModel.requestData()
        viewModel.dataSourceDriver.drive(onNext: { [weak self] _ in
            guard let `self` = self else { return }
            self.tableView.reloadData()
        }).disposed(by: bag)
    }
}
 
extension MyViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 85
    }
}

extension MyViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.dataSource.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CellId, for: indexPath) as! MusicViewCell
        let cellViewModel = viewModel.dataSource[indexPath.row]
        cell.bind(viewModel: cellViewModel)
        return cell
    }

}

