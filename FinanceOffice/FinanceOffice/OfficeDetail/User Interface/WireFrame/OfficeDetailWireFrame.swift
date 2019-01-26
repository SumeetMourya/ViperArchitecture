//
//  OfficeDetailWireFrame.swift
//  FinanceOffice
//
//  Created by sumeet mourya on 01/26/2019.
//  Copyright © 2019 Developer. All rights reserved.
//

import Foundation
import UIKit


class OfficeDetailWireFrame: OfficeDetailWireFrameProtocol {
    
    
    class func createModule(withIdOfOffice: String) -> OfficeDetailViewController {
        
        // Generating module components
        let view: OfficeDetailViewProtocol = mainstoryboard.instantiateViewController(withIdentifier: "OfficeDetailViewControllerID") as! OfficeDetailViewController
        
        let presenter: OfficeDetailPresenterProtocol & OfficeDetailInteractorOutputProtocol = OfficeDetailPresenter(value: withIdOfOffice)
        let interactor: OfficeDetailInteractorInputProtocol = OfficeDetailInteractor()
        let APIDataManager: OfficeDetailAPIDataManagerInputProtocol = OfficeDetailAPIDataManager()
        let localDataManager: OfficeDetailLocalDataManagerInputProtocol = OfficeDetailLocalDataManager()
        let wireFrame: OfficeDetailWireFrameProtocol = OfficeDetailWireFrame()
        
        // Connecting
        view.presenter = presenter
        presenter.view = view
        presenter.wireFrame = wireFrame
        presenter.interactor = interactor
        interactor.presenter = presenter
        interactor.APIDataManager = APIDataManager
        interactor.localDatamanager = localDataManager
        
        return view as! OfficeDetailViewController
    }
    
    static var mainstoryboard: UIStoryboard{
        return UIStoryboard(name:"Main",bundle: Bundle.main)
    }
    
    func pushToMapScreen(navigationConroller navigationController:UINavigationController, withOfficeID: String) {
        
        let detailModule = OfficeOnMapWireFrame.presentOfficeOnMapModule(withIdOfOffice: withOfficeID)
        navigationController.pushViewController(detailModule, animated: true)
        
    }
    
    
}
