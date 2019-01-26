//
//  ListOfOfficesPresenter.swift
//  FinanceOffice
//
//  Created by sumeet mourya on 01/26/2019.
//  Copyright © 2019 Developer. All rights reserved.
//

import Foundation
import UIKit

class ListOfOfficesPresenter: ListOfOfficesPresenterProtocol, ListOfOfficesInteractorOutputProtocol {
    
    weak var view: ListOfOfficesViewProtocol?
    var interactor: ListOfOfficesInteractorInputProtocol?
    var wireFrame: ListOfOfficesWireFrameProtocol?
    
    init() {}
    
    // MARK: ListOfOfficesPresenterProtocol methods
    func loadData(refresh: Bool = false) {
        interactor?.loadData(refresh: refresh)
    }
    
    func pushToDetailScreen(navigationConroller navigationController:UINavigationController, withOfficeID: String) {
        
        self.wireFrame?.pushToDetailScreen(navigationConroller: navigationController, withOfficeID: withOfficeID)
    }
    
    // MARK: ListOfOfficesInteractorOutputProtocol methods
    
    func showActivityIndicator() {
        self.view?.showActivityIndicator()
    }
    
    func hideActivityIndicator() {
        self.view?.hideActivityIndicator()
    }
    
    func hideActivityIndicatorWithError(title: String?, subtitle: String?) {
        self.view?.hideActivityIndicatorWithError(title: title, subtitle: subtitle)
    }
    
    func updateListOfOffices(data: [ListOfOfficesItem]) {
        self.view?.updateListOfOffices(data: data)
    }
    
    func errorInLoadingDataWith(error: Error?, errorCode: ApiStatusType) {
        self.view?.errorInLoadingDataWith(error: error, errorCode: errorCode)
    }
    
    
}
