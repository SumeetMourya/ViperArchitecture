//
//  ListOfOfficesProtocols.swift
//  FinanceOffice
//
//  Created by sumeet mourya on 01/26/2019.
//  Copyright © 2019 Developer. All rights reserved.
//

import Foundation
import UIKit


protocol ListOfOfficesViewProtocol: LoaderView {
    var presenter: ListOfOfficesPresenterProtocol? { get set }
    
    //here we are adding methods for communication PRESENTER -> VIEW
    func updateListOfOffices(data: [ListOfOfficesItem])
    func errorInLoadingDataWith(error: Error?, errorCode: ApiStatusType)
    
}

protocol ListOfOfficesWireFrameProtocol: class {
    
    static func createModule() -> ListOfOfficesViewController
    
    //here we are adding methods for communication PRESENTER -> WIREFRAME
    func pushToDetailScreen(navigationConroller navigationController:UINavigationController, withOfficeID: String)
    
}

protocol ListOfOfficesPresenterProtocol: class {
    var view: ListOfOfficesViewProtocol? { get set }
    var interactor: ListOfOfficesInteractorInputProtocol? { get set }
    var wireFrame: ListOfOfficesWireFrameProtocol? { get set }
    
    //here we are adding methods for communication VIEW -> PRESENTER
    // this method will load the data from the either local data or Network API data
    func loadData(refresh: Bool)
    func pushToDetailScreen(navigationConroller navigationController:UINavigationController, withOfficeID: String)
    
}

protocol ListOfOfficesInteractorOutputProtocol: class {
    
    //here we are adding methods for communication INTERACTOR -> PRESENTER
    func showActivityIndicator()
    func hideActivityIndicator()
    func hideActivityIndicatorWithError(title: String?, subtitle: String?)
    
    func updateListOfOffices(data: [ListOfOfficesItem])
    func errorInLoadingDataWith(error: Error?, errorCode: ApiStatusType)
    
}

protocol ListOfOfficesInteractorInputProtocol: class
{
    var presenter: ListOfOfficesInteractorOutputProtocol? { get set }
    var APIDataManager: ListOfOfficesAPIDataManagerInputProtocol? { get set }
    var localDatamanager: ListOfOfficesLocalDataManagerInputProtocol? { get set }
    
    //here we are adding methods for communication PRESENTER -> INTERACTOR
    func loadData(refresh: Bool)
    
}

protocol ListOfOfficesDataManagerInputProtocol: class
{
    //here we are adding methods for communication INTERACTOR -> DATAMANAGER
}

protocol ListOfOfficesAPIDataManagerInputProtocol: class
{
    //here we are adding methods for communication INTERACTOR -> APIDATAMANAGER
    func loadDataForURL(url: String, onSuccess success: @escaping (_ data: [ListOfOfficesItem], _ apiStatusCode: ApiStatusType) -> Void, onFailure failure: @escaping (_ error: Error?, _ apiStatusCode: ApiStatusType) -> Void)
    
    
}

protocol ListOfOfficesLocalDataManagerInputProtocol: class
{
    //here we are adding methods for communication INTERACTOR -> LOCALDATAMANAGER
    func saveData(officesData: [ListOfOfficesItem])
    func getOfficeDataFromLocal() -> [ListOfOfficesItem]
    
}

