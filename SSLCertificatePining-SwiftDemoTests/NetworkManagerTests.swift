//
//  SSLCertificatePining_SwiftDemoTests.swift
//  SSLCertificatePining-SwiftDemoTests
//
//  Created by Gourav on 14/07/25.
//

import XCTest
@testable import SSLCertificatePining_SwiftDemo

final class NetworkManagerTests: XCTestCase {

    func testFetchDataURLIsValid() {
        let url = URL(string: "https://example.com")!
        let expectation = self.expectation(description: "Network fetch")
        
        NetworkManager.shared.fetchData(from: url) { data in
            // In a real-world case, you might mock the response.
            XCTAssertNil(data, "Expected nil because we don't hit real server in unit test")
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 5, handler: nil)
    }

    func testPinnedCertificateExists() {
        let certPath = Bundle.main.path(forResource: "yourserver.com", ofType: "cer")
        XCTAssertNotNil(certPath, "Pinned certificate file should exist in the bundle")
    }
}
