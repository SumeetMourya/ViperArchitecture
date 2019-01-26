//
//  ListOfOfficesWireFrame.swift
//  FinanceOffice
//
//  Created by sumeet mourya on 01/26/2019.
//  Copyright © 2019 Developer. All rights reserved.
//

import Foundation
import UIKit

class ListOfOfficesWireFrame: ListOfOfficesWireFrameProtocol {
    
    
    static func createModule() -> ListOfOfficesViewController {
        
        // Generating module components
        let view: ListOfOfficesViewProtocol = mainstoryboard.instantiateViewController(withIdentifier: "ListOfOfficesViewControllerID") as! ListOfOfficesViewController
        let presenter: ListOfOfficesPresenterProtocol & ListOfOfficesInteractorOutputProtocol = ListOfOfficesPresenter()
        let interactor: ListOfOfficesInteractorInputProtocol = ListOfOfficesInteractor()
        let APIDataManager: ListOfOfficesAPIDataManagerInputProtocol = ListOfOfficesAPIDataManager()
        let localDataManager: ListOfOfficesLocalDataManagerInputProtocol = ListOfOfficesLocalDataManager()
        let wireFrame: ListOfOfficesWireFrameProtocol = ListOfOfficesWireFrame()
        
        // Connecting
        view.presenter = presenter
        presenter.view = view
        presenter.wireFrame = wireFrame
        presenter.interactor = interactor
        interactor.presenter = presenter
        interactor.APIDataManager = APIDataManager
        interactor.localDatamanager = localDataManager
        
        return view as! ListOfOfficesViewController
    }
    
    static var mainstoryboard: UIStoryboard{
        return UIStoryboard(name:"Main",bundle: Bundle.main)
    }
    
    func pushToDetailScreen(navigationConroller navigationController:UINavigationController, withOfficeID: String) {
        
        let detailModule = OfficeDetailWireFrame.createModule(withIdOfOffice: withOfficeID)
        navigationController.pushViewController(detailModule, animated: true)
        
    }
}
