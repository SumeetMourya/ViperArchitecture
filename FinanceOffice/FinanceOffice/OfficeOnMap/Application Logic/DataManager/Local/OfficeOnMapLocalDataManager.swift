//
//  OfficeOnMapLocalDataManager.swift
//  FinanceOffice
//
//  Created by sumeet mourya on 01/26/2019.
//  Copyright © 2019 Developer. All rights reserved.
//

import Foundation
import CoreData

class OfficeOnMapLocalDataManager: OfficeOnMapLocalDataManagerInputProtocol {
    
    init() {}
    
    
    /// MARK: OfficeOnMapLocalDataManagerInputProtocol methods
    func getOfficeLocationDataFromLocalForGiven(idOfOffice: String) -> OfficeOnMapItem? {
        
        guard let context = CoreDataManager.sharedDatabaseManager.managedObjectContext else {
            return nil
        }
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Office")
        let predicate = NSPredicate(format: "%K == %@", "\(ListOfOfficesItem.CodingKeys.DisId.getKeyOfData())", "\(idOfOffice)")
        request.predicate = predicate
        
        request.returnsObjectsAsFaults = false
        
        do {
            let result = try context.fetch(request)
            
            if result.count > 0, let dataOfManageOBJGet = result[0] as? NSManagedObject, let office = try? OfficeOnMapItem(from: dataOfManageOBJGet) {
                return office
            }
            
            return nil
            
        } catch {
            print("Failed")
            return nil
        }
        
        
    }
    
}
