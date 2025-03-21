//
//  ImageCacheLoaderTests.swift
//  FetchHomeAssignmentTests
//
//  Created by Andrei Konovalov on 05.03.2025.
//

import Foundation
import XCTest

@testable import FetchHomeAssignment

final class ImageCacheLoaderTests: XCTestCase {

    var imageCacheLoader: ImageCacheLoader?

    override func setUp() {
        imageCacheLoader = ImageCacheLoader()
    }

    override func tearDown() async throws  {
        await imageCacheLoader?.clearCache()
        imageCacheLoader = nil
    }

    func testImageAlreadyCached() async {
        guard let url = URL(string: Endpoints.imageURl) else {
            XCTFail("Invalid test URL string: \(Endpoints.badURL)")
            return
        }

        do {
            _ = try await imageCacheLoader?.loadImage(from: url)
            let image = try await imageCacheLoader?.loadImage(from: url)
            XCTAssertNotNil(image)
        } catch {
            XCTFail("Error: \(error)")
        }
    }

    func testAddNewImageBadURL() async {
        guard let url = URL(string: Endpoints.badURL) else {
            XCTAssert(true)
            return
        }

        do {
            _ = try await imageCacheLoader?.loadImage(from: url)
            XCTFail("Expected .badURL error, but succeeded without error.")
        } catch let error as URLError where error.code == .badURL {
            XCTAssert(true)
        } catch let error {
            XCTFail("Unexpected error: \(error.localizedDescription)")
        }
    }

    func testAddNewImageInvalidURL() async {
        guard let url = URL(string: Endpoints.invalidURL) else {
            XCTFail("Invalid test URL string: \(Endpoints.badURL)")
            return
        }
        do {
            _ = try await imageCacheLoader?.loadImage(from: url)
            XCTFail("Expected .unsupportedURL error, but succeeded without error.")
        } catch let error as URLError where error.code == .unsupportedURL {
            XCTAssert(true)
        } catch let error {
            XCTFail("Unexpected error: \(error.localizedDescription)")
        }
    }

    func testCannotParseResponseData() async {
        guard let url = URL(string: Endpoints.validData) else {
            XCTFail("Invalid test URL string: \(Endpoints.badURL)")
            return
        }
        do {
            _ = try await imageCacheLoader?.loadImage(from: url)
            XCTFail("Expected .cannotParseResponse error, but succeeded without error.")

        } catch let error as URLError where error.code == .cannotParseResponse {
            XCTAssert(true)
        } catch let error {
            XCTFail("Unexpected error: \(error.localizedDescription)")
        }
    }

    func testSuccessfullyLoadedImage() async throws {
        guard let url = URL(string: Endpoints.imageURl) else {
            XCTFail("Invalid test URL string: \(Endpoints.badURL)")
            return
        }
        let image = try await imageCacheLoader?.loadImage(from: url)
        XCTAssertNotNil(image)
    }
}
