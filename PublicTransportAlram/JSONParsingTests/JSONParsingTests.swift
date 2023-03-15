//
//  JSONParsingTests.swift
//  JSONParsingTests
//
//  Created by yonggeun Kim on 2023/02/23.
//

import XCTest
@testable import PublicTransportAlram

final class JSONParsingTests: XCTestCase {
    
    override func setUpWithError() throws {
        try super.setUpWithError()
    }

    override func tearDownWithError() throws {
        try super.tearDownWithError()
    }

    func test_파일명을DriveInfoJSON주었을때_dataAsset을실행하면_startName는시청이다() {
        // Given
        let fileName = "DriveInfoJSON"
        
        // When
        let result = JSONDecoder.decodeAsset(
            name: fileName,
            to: DriveInfo.self
        )?.startName
        
        // Then
        XCTAssertEqual(result, "시청")
    }
    
    func test_파일명을ExChangeInfoJSON주었을때_dataAsset을실행하면_fastTrain은1이다() {
        // Given
        let fileName = "ExChangeInfoJSON"
        
        // When
        let result = JSONDecoder.decodeAsset(
            name: fileName,
            to: ExChangeInfo.self
        )?.fastTrain
        
        // Then
        XCTAssertEqual(result, 1)
    }
    
    func test_파일명을StationsJSON를주었을때_dataAsset을실행하면_endSID은202이다() {
        // Given
        let fileName = "StationsJSON"

        // When
        let result = JSONDecoder.decodeAsset(
            name: fileName,
            to: Stations.self
        )?.endSID

        // Then
        XCTAssertEqual(result, 202)
    }
    
    func test_파일명을SearchResultJSON를주었을때_dataAsset을실행하면_globalEndName은강남이다() {
        // Given
        let fileName = "SearchResultJSON"

        // When
        let result = JSONDecoder.decodeAsset(
            name: fileName,
            to: SearchResult.self
        )?.globalEndName

        // Then
        XCTAssertEqual(result, "강남")
    }

    func test_파일명을SubwayRouteSearchJSON를주었을때_dataAsset을실행하면_result의fare은1350이다() {
        // Given
        let fileName = "SubwayRouteSearchJSON"

        // When
        let result = JSONDecoder.decodeAsset(
            name: fileName,
            to: SubwayRouteSearch.self
        )?.result.fare

        // Then
        XCTAssertEqual(result, 1350)
    }
    
    func test_파일명을StationInfoJSON를주었을때_dataAsset을실행하면_stations의첫번째name은녹양이다() {
        // Given
        let fileName = "StationInfoJSON"

        // When
        let result = JSONDecoder.decodeAsset(
            name: fileName,
            to: StationInfo.self
        )?.stations.first?.name

        // Then
        XCTAssertEqual(result, "녹양")
    }
    
    func test_파일명을POISearchJSON를주었을때_dataAsset을실행하면_stations의첫번째name은녹양이다() {
        // Given
        let fileName = "POISearchJSON"

        // When
        let result = JSONDecoder.decodeAsset(
            name: fileName,
            to: PublicTransitPOI.self
        )?.result.station.first?.stationName

        // Then
        XCTAssertEqual(result, "단대오거리")
    }
}
