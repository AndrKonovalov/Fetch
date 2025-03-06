//
//  NetworkManagerTests.swift
//  FetchHomeAssignmentTests
//
//  Created by Andrei Konovalov on 05.03.2025.
//

import Foundation
import XCTest

@testable import FetchHomeAssignment

final class NetworkManagerTests: XCTestCase {

    var networkManager: NetworkManager?

    override func setUp() {
        networkManager = NetworkManager.shared
    }

    override func tearDown() {
        networkManager = nil
    }

    func testInvalidURL() async {
        do {
            _ = try await networkManager?.loadRecipes(from: Endpoints.invalidURL)
        } catch let error as URLError where error.code == .unsupportedURL {
            XCTAssert(true)
        } catch let error {
            XCTFail("Unexpected error: \(error.localizedDescription)")
        }
    }

    func testBadURL() async {
        do {
            _ = try await networkManager?.loadRecipes(from: Endpoints.badURL)
        } catch let error as URLError where error.code == .badURL {
            XCTAssert(true)
        } catch let error {
            XCTFail("Unexpected error: \(error.localizedDescription)")
        }
    }

    func testAccessMailformedData() async {
        do {
            _ = try await networkManager?.loadRecipes(from: Endpoints.mailformedData)
        } catch DecodingError.keyNotFound(_, _) {
            XCTAssert(true)
        } catch let error {
            XCTFail("Unexpected error: \(error.localizedDescription)")
        }
    }

    func testAccessEmptyData() async {
        do {
            _ = try await networkManager?.loadRecipes(from: Endpoints.emptyData)
        } catch DecodingError.valueNotFound(_, _) {
            XCTAssert(true)
        } catch let error {
            XCTFail("Unexpected error: \(error.localizedDescription)")
        }
    }

    func testURLWrongAddress() async {
        do {
            _ = try await networkManager?.loadRecipes(from: Endpoints.accessDeniedURL)
        } catch DecodingError.dataCorrupted(_) {
            XCTAssert(true)
        } catch let error {
            XCTFail("Unexpected error: \(error.localizedDescription)")
        }
    }

    func testFetchValidData() async throws {
        let recipes = try await networkManager?.loadRecipes(from: Endpoints.validData)
        XCTAssertNotNil(recipes)
    }
}
