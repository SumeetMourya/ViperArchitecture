//
//  OfficeDetailInteractor.swift
//  FinanceOffice
//
//  Created by sumeet mourya on 01/26/2019.
//  Copyright © 2019 Developer. All rights reserved.
//

import Foundation

class OfficeDetailInteractor: OfficeDetailInteractorInputProtocol {
    
    weak var presenter: OfficeDetailInteractorOutputProtocol?
    var APIDataManager: OfficeDetailAPIDataManagerInputProtocol?
    var localDatamanager: OfficeDetailLocalDataManagerInputProtocol?
    
    init() {}
    
    // MARK: OfficeDetailInteractorInputProtocol Methods
    func getOfficeData(forOfficeID: String) {
        
        if let dataOfOffice = self.localDatamanager?.getOfficeDataFromLocalForGiven(idOfOffice: forOfficeID) {
            self.presenter?.updateDataOnView(data: dataOfOffice)
        } else {
            self.presenter?.showEmptyDataState()
        }
        
    }
}
