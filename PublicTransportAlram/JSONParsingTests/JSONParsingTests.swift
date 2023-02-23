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

    func test_파일명을ErrorMessageJSON주었을때_dataAsset을실행하면_status는200이다() {
        // Given
        let fileName = "ErrorMessageJSON"
        
        // When
        let result = JSONDecoder.decodeAsset(
            name: fileName,
            to: errorMessage.self
        )?.status
        
        // Then
        XCTAssertEqual(result, 200)
    }
    
    func test_파일명을RealtimeArrivalListJSON주었을때_dataAsset을실행하면_statnNm은단대오거리이다() {
        // Given
        let fileName = "RealtimeArrivalListJSON"
        
        // When
        let result = JSONDecoder.decodeAsset(
            name: fileName,
            to: realtimeArrivalList.self
        )?.statnNm
        
        // Then
        XCTAssertEqual(result, "단대오거리")
    }
    
    func test_파일명을SubwayJSON를주었을때_dataAsset을실행하면_realtimeArrivalList첫번째배열의subwayList은1008이다() {
        // Given
        let fileName = "SubwayJSON"

        // When
        let result = JSONDecoder.decodeAsset(
            name: fileName,
            to: Subway.self
        )?.realtimeArrivalList.first?.subwayList

        // Then
        XCTAssertEqual(result, "1008")
    }
}
