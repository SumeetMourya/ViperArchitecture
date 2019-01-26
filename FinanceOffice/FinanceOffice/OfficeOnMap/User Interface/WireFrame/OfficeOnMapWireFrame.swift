//
//  OfficeOnMapWireFrame.swift
//  FinanceOffice
//
//  Created by sumeet mourya on 01/26/2019.
//  Copyright © 2019 Developer. All rights reserved.
//

import Foundation
import UIKit

class OfficeOnMapWireFrame: OfficeOnMapWireFrameProtocol {
    
    class func presentOfficeOnMapModule(withIdOfOffice: String) -> OfficeOnMapViewController {
        
        // Generating module components
        let view: OfficeOnMapViewProtocol = mainstoryboard.instantiateViewController(withIdentifier: "OfficeOnMapViewControllerID") as! OfficeOnMapViewController
        
        let presenter: OfficeOnMapPresenterProtocol & OfficeOnMapInteractorOutputProtocol = OfficeOnMapPresenter(value: withIdOfOffice)
        let interactor: OfficeOnMapInteractorInputProtocol = OfficeOnMapInteractor()
        let APIDataManager: OfficeOnMapAPIDataManagerInputProtocol = OfficeOnMapAPIDataManager()
        let localDataManager: OfficeOnMapLocalDataManagerInputProtocol = OfficeOnMapLocalDataManager()
        let wireFrame: OfficeOnMapWireFrameProtocol = OfficeOnMapWireFrame()
        
        // Connecting
        view.presenter = presenter
        presenter.view = view
        presenter.wireFrame = wireFrame
        presenter.interactor = interactor
        interactor.presenter = presenter
        interactor.APIDataManager = APIDataManager
        interactor.localDatamanager = localDataManager
        
        return view as! OfficeOnMapViewController
    }
    
    static var mainstoryboard: UIStoryboard{
        return UIStoryboard(name:"Main",bundle: Bundle.main)
    }
    
    
}

