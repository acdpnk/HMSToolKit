//
//  WatchTransferable.swift
//  HMSToolKit
//
//  Created by chrifpa on 15-09-08.
//  Copyright © 2015 Hackmops. All rights reserved.
//

// This is basically an NSCoding replacement for Swift structs.
// See WatchTransferableTests.swift for an example on how to use it.

// HINT
// When in doubt use encodeObject:forKey: and decodeObject:forKey:
// The other archiving/unarchiving methods (e.g. encodeInteger:forKey:)
// allow you to skip casting and checking for nil, but when you try to
// decode such a thing with the wrong method you'll get a RUNTIME(!)
// crash.

protocol WatchTransferable {
    func watchTransferableArchive() -> NSData
    init?(data: NSData)
}