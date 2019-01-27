//
//  OfficeDetailPresenter.swift
//  FinanceOffice
//
//  Created by sumeet mourya on 01/26/2019.
//  Copyright © 2019 Developer. All rights reserved.
//

import Foundation
import UIKit

class OfficeDetailPresenter: OfficeDetailPresenterProtocol, OfficeDetailInteractorOutputProtocol {
    
    weak var view: OfficeDetailViewProtocol?
    var interactor: OfficeDetailInteractorInputProtocol?
    var wireFrame: OfficeDetailWireFrameProtocol?
    
    let idOfOffice: String
    
    init(value: String) {
        idOfOffice = value
    }
    
    // MARK: OfficeDetailPresenterProtocol Methods
    
    func pushToDetailScreen(navigationConroller navigationController:UINavigationController) {
        self.wireFrame?.pushToMapScreen(navigationConroller: navigationController, withOfficeID: self.idOfOffice)
    }
    
    func getOfficeData() {
        self.interactor?.getOfficeData(forOfficeID: idOfOffice)
    }
    
    // MARK: OfficeDetailInteractorOutputProtocol Methods
    
    func updateDataOnView(data: OfficeDetailItemDM) {
        self.view?.updateDataOnView(data: data)
    }
    
    func showEmptyDataState() {
        self.view?.showEmptyDataState()
    }
    
    
    
}
