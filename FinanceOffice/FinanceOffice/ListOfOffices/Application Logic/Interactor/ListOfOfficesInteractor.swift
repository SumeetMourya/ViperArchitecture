//
//  ListOfOfficesInteractor.swift
//  FinanceOffice
//
//  Created by sumeet mourya on 01/26/2019.
//  Copyright © 2019 Developer. All rights reserved.
//

import Foundation


class ListOfOfficesInteractor: ListOfOfficesInteractorInputProtocol {
    
    //only If there is not Store data on local device
    var showLoaderOnAPIData: Bool = false
    
    weak var presenter: ListOfOfficesInteractorOutputProtocol?
    var APIDataManager: ListOfOfficesAPIDataManagerInputProtocol?
    var localDatamanager: ListOfOfficesLocalDataManagerInputProtocol?
    
    init() {}
    
    func loadData(refresh: Bool = false) {
        
        //we will check if the local data is there then show the data without loading screen
        //otherwise we will show the loading screen while laading data
        var offices:[ListOfOfficesItem] = [ListOfOfficesItem]()
        
        if let officesDataValue:[ListOfOfficesItem] = localDatamanager?.getOfficeDataFromLocal(), officesDataValue.count > 0 {
            offices = officesDataValue
        } else {
            self.showLoaderOnAPIData = true
        }
        
        if refresh {
            
            //we need to show the laoding if there is no local data, and need to load the data from API if only happend only once in until we didnt save the data after getting data from API.
            if self.showLoaderOnAPIData {
                self.presenter?.showActivityIndicator()
            }
            
            DispatchQueue.global(qos: DispatchQoS.QoSClass.utility).async { [weak self] in
                
                self?.APIDataManager?.loadDataForURL(url: API.baseUrlValue + API.apiPath + API.lastPathComponent, onSuccess: { (officesData, succeedCode) in
                    
                    self?.localDatamanager?.saveData(officesData: officesData)
                    
                    //we need to hide the laoding only if we show the loading screen
                    if let needToShow = self?.showLoaderOnAPIData, needToShow {
                        self?.presenter?.hideActivityIndicator()
                    }
                    
                    //here we have two options either get data from Local or directly load what we have from API
                    self?.presenter?.updateListOfOffices(data: officesData)
                    
                }, onFailure: { (error, errorcodeData) in
                    
                    //we need to hide the laoding only if we show the loading screen
                    if let needToShow = self?.showLoaderOnAPIData, needToShow {
                        self?.presenter?.hideActivityIndicator()
                    }
                    
                    //we will show the alert view of showing error only in one condition if local data is there
                    if offices.count == 0 {
                        self?.presenter?.errorInLoadingDataWith(error: error, errorCode: errorcodeData)
                    } else {
                        self?.presenter?.updateListOfOffices(data: offices)
                    }
                })
                
            }
            
        } else {
            
            if offices.count > 0 {
                self.presenter?.updateListOfOffices(data: offices)
            } else {
                //here we can do two thing either return empty array or nil....
                // but returning nil is better than empty array
                self.presenter?.updateListOfOffices(data: [ListOfOfficesItem]())
            }
        }
        
    }
    
}


