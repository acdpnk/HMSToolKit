//
//  WatchTransferableTests.swift
//  HMSToolKit
//
//  Created by chrifpa on 15-09-08.
//  Copyright © 2015 Hackmops. All rights reserved.
//

import XCTest
@testable import HMSToolKit

class WatchTransferableTests: XCTestCase {

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testUnArchiving() {
        let square = Square(width: 4, height: 3, color: "red")
        let data = square.watchTransferableArchive()
        let _unarchived = Square(data: data)

        guard let unarchived = _unarchived else {
            XCTFail("could not unarchive Square from \(data)")
            return
        }
        XCTAssertEqual(square.width, unarchived.width)
        XCTAssertEqual(square.height, unarchived.height)
        XCTAssertEqual(square.color, unarchived.color)

        let brokenSquare = Square(data: NSData())
        XCTAssertNil(brokenSquare, "Initialized \(brokenSquare) with empty NSData object, should be nil")

        let wrongWidthTypeData = NSMutableData()
        let archiver = NSKeyedArchiver(forWritingWithMutableData: wrongWidthTypeData)
        archiver.encodeObject("Fnord", forKey: "width")
        archiver.finishEncoding()
        let wrongWidthTypeSquare = Square(data: wrongWidthTypeData)
        XCTAssertNil(wrongWidthTypeSquare, "Initialized \(wrongWidthTypeSquare) with faulty NSData object, should be nil")
    }
}

// Example struct for testing
public
struct Square {
    let width: Int
    let height: Int
    let color: String
}

extension Square: WatchTransferable {
    public func watchTransferableArchive() -> NSData {
        let data = NSMutableData()
        let archiver = NSKeyedArchiver(forWritingWithMutableData: data)
        archiver.encodeObject(width, forKey: "width")
        archiver.encodeObject(height, forKey: "height")
        archiver.encodeObject(color, forKey: "color")
        archiver.finishEncoding()
        return data as NSData
    }

    public init?(data: NSData) {
        let unarchiver = NSKeyedUnarchiver(forReadingWithData: data)
        guard let width = unarchiver.decodeObjectForKey("width") as? Int, height = unarchiver.decodeObjectForKey("height") as? Int, color = unarchiver.decodeObjectForKey("color") as? String else {
            return nil
        }
        self.width = width
        self.height = height
        self.color = color
    }
}