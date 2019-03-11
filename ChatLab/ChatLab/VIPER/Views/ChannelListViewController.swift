//
//  ChannelListViewController.swift
//  ChatLab
//
//  Created by Nestor Hernandez on 2/21/19.
//  Copyright © 2019 Nestor Hernandez. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources

class ChannelListViewController: UIViewController {
    
    fileprivate var channelListPresenter: ChannelListPresenterProtocol!
    fileprivate var navigationCoordinator: NavigationCoordinatorProtocol?
    
    fileprivate var bag = DisposeBag()
    fileprivate var dataSource: RxTableViewSectionedReloadDataSource<ChannelSection>?
    @IBOutlet weak var channelsTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()        
        self.initDataSource()
        self.initTableView()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if isMovingFromParent {
            navigationCoordinator?.movingBack()
        }
    }
    
    func configure(with presenter: ChannelListPresenterProtocol, navigationCoordinator: NavigationCoordinatorProtocol){
        self.channelListPresenter = presenter
        self.navigationCoordinator = navigationCoordinator
        
        self.configureNavBar()
    }
    
    fileprivate func configureNavBar() {
        let addBtn = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(self.addChannel))
        self.navigationItem.rightBarButtonItem = addBtn
    }
    
    @objc fileprivate func addChannel(){
        //let vc = registry.
        navigationCoordinator?.presentModalController(arguments: ["type":ModalType.newChannel])
    }
}

extension ChannelListViewController {
    func initDataSource(){
        dataSource = RxTableViewSectionedReloadDataSource<ChannelSection>(configureCell: { (sectionedDataSource, tableview, indexPath, channel)  in
            let cell = UITableViewCell()
            cell.textLabel?.text = channel.channelName
            return cell
        })
        dataSource?.titleForHeaderInSection = { ds, index in
            return ds.sectionModels[index].header
        }
    }
    
    func initTableView() {
        guard let ds = self.dataSource else {return}
        channelListPresenter.channelSections.asObservable()
            .bind(to: channelsTable.rx.items(dataSource: ds)).disposed(by: bag)
    }
}
