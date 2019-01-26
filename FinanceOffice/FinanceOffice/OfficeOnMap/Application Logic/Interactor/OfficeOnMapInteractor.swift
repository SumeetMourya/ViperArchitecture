//
//  OfficeOnMapInteractor.swift
//  FinanceOffice
//
//  Created by sumeet mourya on 01/26/2019.
//  Copyright © 2019 Developer. All rights reserved.
//

import Foundation

class OfficeOnMapInteractor: OfficeOnMapInteractorInputProtocol {
    
    weak var presenter: OfficeOnMapInteractorOutputProtocol?
    var APIDataManager: OfficeOnMapAPIDataManagerInputProtocol?
    var localDatamanager: OfficeOnMapLocalDataManagerInputProtocol?
    
    init() {}
    
    // MARK: OfficeOnMapInteractorInputProtocol Methods
    func getOfficeLocationData(forOfficeID: String) {
        
        if let dataOfOffice = self.localDatamanager?.getOfficeLocationDataFromLocalForGiven(idOfOffice: forOfficeID) {
            self.presenter?.updateDataOnView(data: dataOfOffice)
        } else {
            self.presenter?.showEmptyDataState()
        }
        
    }
    
}
