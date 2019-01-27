//
//  OfficeDetailItem.swift
//  FinanceOffice
//
//  Created by sumeet mourya on 01/26/2019.
//  Copyright © 2019 Developer. All rights reserved.
//

import Foundation
import CoreData


struct OfficeDetailItemDM: Decodable {
    
    let idOfOffice: String?
    let nameOfOffice: String?
    let zipCodeOfOffice: Int?
    let cityOfOffice: String?
    let addressOfOffice: String?
    let telephoneNumberOfOffice: String?
    let faxNumberOfOffice: String?
    let openingTimeOfOffice: String?
    let imageURLOfOffice: String?
    
    
    enum CodingKeys: String, CodingKey {
        
        case DisId
        case DisNameLang
        case DisPlz
        case DisOrt
        case DisStrasse
        case DisTel
        case DisFax
        case DisOeffnung
        case DisFotoUrl
        
        func getKeyOfData() -> String {
            
            switch self {
            case .DisId:
                return "idOfOffice"
            case .DisNameLang:
                return "nameOfOffice"
            case .DisPlz:
                return "zipCodeOfOffice"
            case .DisOrt:
                return "cityOfOffice"
            case .DisStrasse:
                return "addressOfOffice"
            case .DisTel:
                return "telephoneNumberOfOffice"
            case .DisFax:
                return "faxNumberOfOffice"
            case .DisOeffnung:
                return "openingTimeOfOffice"
            case .DisFotoUrl:
                return "imageURLOfOffice"
            }
        }
        
    }
    
    init(from decoder: Decoder) throws {
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.idOfOffice = try? container.decode(String.self, forKey: .DisId)
        self.nameOfOffice = try? container.decode(String.self, forKey: .DisNameLang)
        if let zipCodeValue = try? container.decode(String.self, forKey: .DisPlz) {
            self.zipCodeOfOffice = Int(zipCodeValue)
        } else {
            self.zipCodeOfOffice = nil
        }
        self.cityOfOffice = try? container.decode(String.self, forKey: .DisOrt)
        self.addressOfOffice = try? container.decode(String.self, forKey: .DisStrasse)
        self.telephoneNumberOfOffice = try? container.decode(String.self, forKey: .DisTel)
        self.faxNumberOfOffice = try? container.decode(String.self, forKey: .DisFax)
        self.openingTimeOfOffice = try? container.decode(String.self, forKey: .DisOeffnung)
        self.imageURLOfOffice = try? container.decode(String.self, forKey: .DisFotoUrl)

    }
    
    init(from mngObj: NSManagedObject) throws {
        
        self.idOfOffice = mngObj.value(forKey: CodingKeys.DisId.getKeyOfData()) as? String
        self.nameOfOffice = mngObj.value(forKey: CodingKeys.DisNameLang.getKeyOfData()) as? String
        if let zipCodeValue = mngObj.value(forKey: CodingKeys.DisPlz.getKeyOfData()) as? Int {
            self.zipCodeOfOffice = zipCodeValue
        } else {
            self.zipCodeOfOffice = nil
        }
        self.cityOfOffice = mngObj.value(forKey: CodingKeys.DisOrt.getKeyOfData()) as? String
        self.addressOfOffice = mngObj.value(forKey: CodingKeys.DisStrasse.getKeyOfData()) as? String
        self.telephoneNumberOfOffice = mngObj.value(forKey: CodingKeys.DisTel.getKeyOfData()) as? String
        self.faxNumberOfOffice = mngObj.value(forKey: CodingKeys.DisFax.getKeyOfData()) as? String
        self.openingTimeOfOffice = mngObj.value(forKey: CodingKeys.DisOeffnung.getKeyOfData()) as? String
        self.imageURLOfOffice = mngObj.value(forKey: CodingKeys.DisFotoUrl.getKeyOfData()) as? String

    }
}
