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

    override func tearDown() {
        imageCacheLoader?.clearCache()
        imageCacheLoader = nil
    }

    func testImageAlreadyCached() async {
        do {
            _ = try await imageCacheLoader?.loadImage(from: "https://d3jbb8n5wk0qxi.cloudfront.net/photos/535dfe4e-5d61-4db6-ba8f-7a27b1214f5d/large.jpg")
            let image = try await imageCacheLoader?.loadImage(from: "https://d3jbb8n5wk0qxi.cloudfront.net/photos/535dfe4e-5d61-4db6-ba8f-7a27b1214f5d/large.jpg")
            XCTAssertNotNil(image)
        } catch {
            XCTFail("Error: \(error)")
        }
    }

    func testAddNewImageBadURL() async {
        do {
            _ = try await imageCacheLoader?.loadImage(from: Endpoints.badURL)
        } catch let error as URLError where error.code == .badURL {
            XCTAssert(true)
        } catch let error {
            XCTFail("Unexpected error: \(error.localizedDescription)")
        }
    }

    func testAddNewImageInvalidURL() async {
        do {
            _ = try await imageCacheLoader?.loadImage(from: Endpoints.invalidURL)
        } catch let error as URLError where error.code == .unsupportedURL {
            XCTAssert(true)
        } catch let error {
            XCTFail("Unexpected error: \(error.localizedDescription)")
        }
    }

    func testCannotParseResponseData() async {
        do {
            _ = try await imageCacheLoader?.loadImage(from: Endpoints.validData)
        } catch let error as URLError where error.code == .cannotParseResponse {
            XCTAssert(true)
        } catch let error {
            XCTFail("Unexpected error: \(error.localizedDescription)")
        }
    }

    func testSuccessfullyLoadedImage() async throws {
        let image = try await imageCacheLoader?.loadImage(from: "https://d3jbb8n5wk0qxi.cloudfront.net/photos/535dfe4e-5d61-4db6-ba8f-7a27b1214f5d/large.jpg")
        XCTAssertNotNil(image)
    }
}
