//
//  FinanceOfficeTests.swift
//  FinanceOfficeTests
//
//  Created by sumeet mourya on 26/01/19.
//  Copyright © 2019 Developer. All rights reserved.
//

import XCTest

//@testable import FinanceOffice

class FinanceOfficeTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testApis() {
        self.testAPICall(withStatus: ApiStatusType.none)
        self.testAPICall(withStatus: ApiStatusType.apiSucceed)
        self.testAPICall(withStatus: ApiStatusType.apiEncodingIssue)
        self.testAPICall(withStatus: ApiStatusType.apiParsingIssue)
        self.testAPICall(withStatus: ApiStatusType.apiIssue)
    }
    
    func testPerformanceExample() {
        
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testAPICall(withStatus: ApiStatusType?) {
        
        guard withStatus != nil else {
            XCTFail("Given status type is nil")
            return
        }
        
        let apiCall = APIService()
        
        apiCall.loadDataWith(urlString: "https://service.bmf.gv.at/Finanzamtsliste.json", onSuccess: { (data, succeedCode) in
            
            XCTAssertEqual(withStatus, succeedCode, "Given status code and API called Status Code are different")
            
            let responseStrInISOLatin = String(data: data, encoding: String.Encoding.isoLatin1)
            guard let modifiedDataInUTF8Format = responseStrInISOLatin?.data(using: String.Encoding.utf8) else {
                XCTFail("Error: Data Decoding failed")
                return
            }
            
            do {
                let offices = try JSONDecoder().decode([ListOfOfficesItem].self, from: modifiedDataInUTF8Format)
                
                for officeData in offices {
                    
                    XCTAssertNotNil(officeData.idOfOffice, "office id is nil for this item")
                    XCTAssertNotNil(officeData.nameOfOffice, "Name of office id is nil for this item")
                    XCTAssertNotNil(officeData.bLZOfOffice, "Zip code of office is nil for this item")
                    XCTAssertNotNil(officeData.addressOfOffice, "Address of office is nil for this item")
                    XCTAssertNotNil(officeData.cityOfOffice, "City of office is nil for this item")
                    XCTAssertNotNil(officeData.openingTimeOfOffice, "Office opening hours are nil for this item")
                    XCTAssertNotNil(officeData.imageURLOfOffice, "Image URL of officeis nil for this item")
                    XCTAssertNotNil(officeData.faxNumberOfOffice, "Fax number of Office is nil for this item")
                    XCTAssertNotNil(officeData.latitudeOfOffice, "Latitude of Office is nil for this item")
                    XCTAssertNotNil(officeData.longitudeOfOffice, "Longitude of Office is nil for this item")
                    XCTAssertNotNil(officeData.telephoneNumberOfOffice, "Telephone number of Office is nil for this item")
                    
                }
                
            } catch let error as NSError {
                XCTFail("Error: Data Decoding failed with \(error)")
            }
            
        }) { (error, errorCode) in
            XCTAssertEqual(withStatus, errorCode, "Given status code and API called Status Code are different")
        }
        
        waitForExpectations(timeout: 300, handler: nil)
        
    }
    
}

