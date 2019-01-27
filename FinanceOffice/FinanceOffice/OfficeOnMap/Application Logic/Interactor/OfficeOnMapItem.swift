//
//  OfficeOnMapItem.swift
//  FinanceOffice
//
//  Created by sumeet mourya on 01/26/2019.
//  Copyright © 2019 Developer. All rights reserved.
//

import Foundation
import CoreData

struct OfficeOnMapItemDM: Decodable {
    
    let nameOfOffice: String?
    let zipCodeOfOffice: Int?
    let cityOfOffice: String?
    let addressOfOffice: String?
    let latitudeOfOffice: Double?
    let longitudeOfOffice: Double?
    
    
    enum CodingKeys: String, CodingKey {
        
        case DisNameLang
        case DisPlz
        case DisOrt
        case DisStrasse
        case DisLatitude
        case DisLongitude
        
        func getKeyOfData() -> String {
            
            switch self {
            case .DisNameLang:
                return "nameOfOffice"
            case .DisPlz:
                return "zipCodeOfOffice"
            case .DisOrt:
                return "cityOfOffice"
            case .DisStrasse:
                return "addressOfOffice"
            case .DisLatitude:
                return "latitudeOfOffice"
            case .DisLongitude:
                return "longitudeOfOffice"
            }
        }
        
    }
    
    init(from decoder: Decoder) throws {
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.nameOfOffice = try? container.decode(String.self, forKey: .DisNameLang)
        if let zipCodeValue = try? container.decode(String.self, forKey: .DisPlz) {
            self.zipCodeOfOffice = Int(zipCodeValue)
        } else {
            self.zipCodeOfOffice = nil
        }
        self.cityOfOffice = try? container.decode(String.self, forKey: .DisOrt)
        self.addressOfOffice = try? container.decode(String.self, forKey: .DisStrasse)
        if let latitudeValue = try? container.decode(String.self, forKey: .DisLatitude) {
            self.latitudeOfOffice = Double(latitudeValue)
        } else {
            self.latitudeOfOffice = nil
        }
        if let longitudeValue = try? container.decode(String.self, forKey: .DisLongitude) {
            self.longitudeOfOffice = Double(longitudeValue)
        } else {
            self.longitudeOfOffice = nil
        }
    }
    
    init(from mngObj: NSManagedObject) throws {
        
        self.nameOfOffice = mngObj.value(forKey: CodingKeys.DisNameLang.getKeyOfData()) as? String
        if let zipCodeValue = mngObj.value(forKey: CodingKeys.DisPlz.getKeyOfData()) as? Int {
            self.zipCodeOfOffice = zipCodeValue
        } else {
            self.zipCodeOfOffice = nil
        }
        self.cityOfOffice = mngObj.value(forKey: CodingKeys.DisOrt.getKeyOfData()) as? String
        self.addressOfOffice = mngObj.value(forKey: CodingKeys.DisStrasse.getKeyOfData()) as? String
        if let latitudeValue = mngObj.value(forKey: CodingKeys.DisLatitude.getKeyOfData()) as? Double {
            self.latitudeOfOffice = latitudeValue
        } else {
            self.latitudeOfOffice = nil
        }
        if let longitudeValue = mngObj.value(forKey: CodingKeys.DisLongitude.getKeyOfData()) as? Double {
            self.longitudeOfOffice = longitudeValue
        } else {
            self.longitudeOfOffice = nil
        }
    }
}
