//
//  OfficeOnMapPresenter.swift
//  FinanceOffice
//
//  Created by sumeet mourya on 01/26/2019.
//  Copyright © 2019 Developer. All rights reserved.
//

import Foundation

class OfficeOnMapPresenter: OfficeOnMapPresenterProtocol, OfficeOnMapInteractorOutputProtocol {
    
    
    weak var view: OfficeOnMapViewProtocol?
    var interactor: OfficeOnMapInteractorInputProtocol?
    var wireFrame: OfficeOnMapWireFrameProtocol?
    
    let idOfOffice: String
    
    init(value: String) {
        idOfOffice = value
    }
    
    // MARK: OfficeOnMapPresenterProtocol methods
    func getOfficeLocationData() {
        self.interactor?.getOfficeLocationData(forOfficeID: idOfOffice)
    }
    
    // MARK: OfficeOnMapInteractorOutputProtocol Methods
    func updateDataOnView(data: OfficeOnMapItemDM) {
        self.view?.updateOfficeLocationDataOnView(data: data)
    }
    
    func showEmptyDataState() {
        self.view?.showEmptyDataState()
    }
    
    
}
