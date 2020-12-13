//
//  ServiceHelperTests.swift
//  NyTimesNewsAppTests
//
//  Created by Admin on 12/14/20.
//

import XCTest

@testable import NyTimesNewsApp

class ServiceHelperTests: XCTestCase {

    func testCancelRequest() {
        // giving a "previous" session
        ServiceHelper.shared.fetchArticles { (_) in
            // ignore call
        }
        // Expected to task nil after cancel
        ServiceHelper.shared.cancelFetchArticles()
        XCTAssertNil(ServiceHelper.shared.task, "Expected task nil")
    }

}
