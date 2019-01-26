//
//  OfficeOnMapProtocols.swift
//  FinanceOffice
//
//  Created by sumeet mourya on 01/26/2019.
//  Copyright © 2019 Developer. All rights reserved.
//

import Foundation

protocol OfficeOnMapViewProtocol: class {
    
    var presenter: OfficeOnMapPresenterProtocol? { get set }
    
    //here we are adding  methods for communication PRESENTER -> VIEW
    func updateOfficeLocationDataOnView(data: OfficeOnMapItem)
    func showEmptyDataState()
    
}

protocol OfficeOnMapWireFrameProtocol: class {
    
    static func presentOfficeOnMapModule(withIdOfOffice: String) -> OfficeOnMapViewController
    
    //here we are adding methods for communication PRESENTER -> WIREFRAME
    
}

protocol OfficeOnMapPresenterProtocol: class {
    var view: OfficeOnMapViewProtocol? { get set }
    var interactor: OfficeOnMapInteractorInputProtocol? { get set }
    var wireFrame: OfficeOnMapWireFrameProtocol? { get set }
    
    //here we are adding methods for communication VIEW -> PRESENTER
    func getOfficeLocationData()
    
}

protocol OfficeOnMapInteractorOutputProtocol: class {
    
    //here we are adding methods for communication INTERACTOR -> PRESENTER
    
    func updateDataOnView(data: OfficeOnMapItem)
    func showEmptyDataState()
    
}

protocol OfficeOnMapInteractorInputProtocol: class
{
    var presenter: OfficeOnMapInteractorOutputProtocol? { get set }
    var APIDataManager: OfficeOnMapAPIDataManagerInputProtocol? { get set }
    var localDatamanager: OfficeOnMapLocalDataManagerInputProtocol? { get set }
    
    //here we are adding methods for communication PRESENTER -> INTERACTOR
    func getOfficeLocationData(forOfficeID: String)
    
}

protocol OfficeOnMapDataManagerInputProtocol: class
{
    //here we are adding methods for communication INTERACTOR -> DATAMANAGER
    
}

protocol OfficeOnMapAPIDataManagerInputProtocol: class
{
    //here we are adding methods for communication INTERACTOR -> APIDATAMANAGER
    
}

protocol OfficeOnMapLocalDataManagerInputProtocol: class
{
    //here we are adding methods for communication INTERACTOR -> LOCALDATAMANAGER
    func getOfficeLocationDataFromLocalForGiven(idOfOffice: String) -> OfficeOnMapItem?
    
}
