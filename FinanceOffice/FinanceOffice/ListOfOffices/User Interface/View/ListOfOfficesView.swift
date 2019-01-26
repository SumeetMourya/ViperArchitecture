//
//  ListOfOfficesView.swift
//  FinanceOffice
//
//  Created by sumeet mourya on 01/26/2019.
//  Copyright © 2019 Developer. All rights reserved.
//

import Foundation
import UIKit
import ESPullToRefresh


class ListOfOfficesViewController: UIViewController, ListOfOfficesViewProtocol {
    
    
    var presenter: ListOfOfficesPresenterProtocol?
    var listOfOffice: [ListOfOfficesItem] = [ListOfOfficesItem]()
    
    @IBOutlet var tblvOfficeList: UITableView!
    @IBOutlet var statusText: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Overview"
        
        tblvOfficeList.tableFooterView = UIView(frame: .zero)
        tblvOfficeList.rowHeight = UITableViewAutomaticDimension
        tblvOfficeList.estimatedRowHeight = 50
        
        tblvOfficeList.es.addPullToRefresh { [unowned self] in
            self.presenter?.loadData(refresh: true)
        }
        
        self.presenter?.loadData(refresh: true)
        
    }
    
    // MARK: Private Methods
    
    func showAlertView(msg: String, title: String) {
        let alertController = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        
        alertController.addAction(UIAlertAction(title: "ok", style: .default, handler: { (action:UIAlertAction) in
        }))
        present(alertController, animated: true, completion: nil)
    }
    
    
    // MARK: ListOfOfficesViewProtocol methods
    func updateListOfOffices(data: [ListOfOfficesItem]) {
        
        DispatchQueue.main.async() {
            
            let officesListIsEmpty: Bool = data.count <= 0
            self.statusText.isHidden = !officesListIsEmpty
            self.tblvOfficeList.isHidden = officesListIsEmpty
            
            if !officesListIsEmpty {
                self.listOfOffice.removeAll()
                self.tblvOfficeList.es.stopPullToRefresh()
                self.listOfOffice = data
//                let randomNumber = Int.random(in: 0 ..< data.count/2)
//                for index in 0..<randomNumber {
//                    self.listOfOffice.append(data[index])
//                }
                self.tblvOfficeList.reloadData()
            }
        }
        
    }
    
    func errorInLoadingDataWith(error: Error?, errorCode: ApiStatusType) {
        
        switch errorCode {
        case .apiSucceed:
            break
            
        case .netWorkIssue:
            showAlertView(msg: "Error", title: "Please check your network connectivity.")
            return
            
        case .apiIssue:
            showAlertView(msg: "Error", title: "Server issue")
            return

        case .apiParsingIssue:
            showAlertView(msg: "Error", title: "Server data parsing issue")
            return
            
        case .apiEncodingIssue:
            showAlertView(msg: "Error", title: "Server decoding issue")
            return
            
        case .none:
            break
        }
        
    }
    
    
}

extension ListOfOfficesViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let navigation = self.navigationController, let officeIDValue = listOfOffice[indexPath.row].idOfOffice {
            
            self.presenter?.pushToDetailScreen(navigationConroller: navigation, withOfficeID: officeIDValue)
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat{
        return UITableViewAutomaticDimension
    }
    
}

extension ListOfOfficesViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listOfOffice.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell:OfficeCell? = tableView.dequeueReusableCell(withIdentifier: OfficeCell.identifier) as? OfficeCell
        
        if cell == nil {
            cell = UITableViewCell.init(style: .default, reuseIdentifier: OfficeCell.identifier) as? OfficeCell
        }
        
        cell?.selectionStyle = .none
        cell?.contentView.backgroundColor = UIColor.clear
        cell?.backgroundColor = UIColor.clear
        cell?.bindDataToUI(data: listOfOffice[indexPath.row])
        
        return cell!
        
    }
    
    
}

