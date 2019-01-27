//
//  OfficeDetailProtocols.swift
//  FinanceOffice
//
//  Created by sumeet mourya on 01/26/2019.
//  Copyright © 2019 Developer. All rights reserved.
//

import Foundation
import UIKit

protocol OfficeDetailViewProtocol: class {
    
    var presenter: OfficeDetailPresenterProtocol? { get set }
    
    //here we are adding for communication PRESENTER -> VIEW
    func updateDataOnView(data: OfficeDetailItemDM)
    func showEmptyDataState()
    
}

protocol OfficeDetailWireFrameProtocol: class {
    
    static func createModule(withIdOfOffice: String) -> OfficeDetailViewController
    
    //here we are adding for communication PRESENTER -> WIREFRAME
    func pushToMapScreen(navigationConroller navigationController:UINavigationController, withOfficeID: String)
    
}

protocol OfficeDetailPresenterProtocol: class {
    var view: OfficeDetailViewProtocol? { get set }
    var interactor: OfficeDetailInteractorInputProtocol? { get set }
    var wireFrame: OfficeDetailWireFrameProtocol? { get set }
    
    //here we are adding methods for communication VIEW -> PRESENTER
    func getOfficeData()
    func pushToDetailScreen(navigationConroller navigationController:UINavigationController)
    
}

protocol OfficeDetailInteractorOutputProtocol: class {
    
    //here we are adding methods for communication INTERACTOR -> PRESENTER
    func updateDataOnView(data: OfficeDetailItemDM)
    func showEmptyDataState()
    
}

protocol OfficeDetailInteractorInputProtocol: class
{
    var presenter: OfficeDetailInteractorOutputProtocol? { get set }
    var APIDataManager: OfficeDetailAPIDataManagerInputProtocol? { get set }
    var localDatamanager: OfficeDetailLocalDataManagerInputProtocol? { get set }
    
    //here we are adding methods for communication PRESENTER -> INTERACTOR
    
    func getOfficeData(forOfficeID: String)
}

protocol OfficeDetailDataManagerInputProtocol: class
{
    //here we are adding methods for communication INTERACTOR -> DATAMANAGER
    
}

protocol OfficeDetailAPIDataManagerInputProtocol: class
{
    //here we are adding methods for communication INTERACTOR -> APIDATAMANAGER
    
}

protocol OfficeDetailLocalDataManagerInputProtocol: class
{
    
    //here we are adding methods for communication INTERACTOR -> LOCALDATAMANAGER
    func getOfficeDataFromLocalForGiven(idOfOffice: String) -> OfficeDetailItemDM?
    
}
