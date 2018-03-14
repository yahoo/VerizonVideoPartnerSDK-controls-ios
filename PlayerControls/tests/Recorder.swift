//  Copyright 2018, Oath Inc.
//  Licensed under the terms of the MIT License. See LICENSE.md file in project root for terms.

import XCTest

private protocol AnyRecord {
    var hook: Hook { get }
    var anyValue: Any { get }
}

private final class Hook {
    let name: String
    let cmp: (AnyRecord, AnyRecord) -> Bool
    init(name: String, cmp: @escaping (AnyRecord, AnyRecord) -> Bool) {
        self.name = name
        self.cmp = cmp
    }
}

private struct Record<T> : AnyRecord {
    let hook: Hook
    let value: T
    
    var anyValue: Any { return value }
}

final class Recorder {
    fileprivate var records = [] as [AnyRecord]
    
    fileprivate var act: (AnyRecord) -> () = { _ in }
}

extension Recorder {
    func hook<T>(_ name: String, cmp: @escaping (T, T) -> Bool) -> ((T) -> ()) {
        let hook = Hook(name: name) { t, r in
            guard let target = t as? Record<T> else {
                fatalError("Unexpected target: \(t)")
            }
            
            guard let record = r as? Record<T> else {
                fatalError("Unexpected record: \(r)")
            }
            
            return cmp(target.value, record.value)
        }
        
        return { t in
            self.act(Record(hook: hook, value: t))
        }
    }
    
    func hook<T: Equatable>(_ name: String) -> ((T) -> ()) {
        return hook(name) { $0 == $1 }
    }
    
    func hook(_ name:String) -> (() -> ()) {
        return hook(name) { _,_ in return true }
    }
    
    func hook<T: Equatable>(_ name:String) -> ((T?) -> ()) {
        return hook(name, cmp: { $0 == $1 })
    }
}


extension Recorder {
    func record(_ f: () ->()) {
        act = addRecord
        f()
        act = { _ in }
    }
    
    fileprivate func addRecord(_ record: AnyRecord) {
        records.append(record)
    }
}

extension Recorder {
    func verify(_ all: Bool = true,
                file: StaticString = #file,
                line: UInt = #line,
                f: () -> ()) {
        act = { self.verifyRecord(in: file, line, record: $0) }
        f()
        act = { _ in }
        
        if (all) {
            for record in records {
                XCTFail("Unexpected record: \"\(record.hook.name)(\(record.anyValue))\"", file: file, line: line)
            }
        }
    }
    
    func check(
        _ file: StaticString = #file,
        line: UInt = #line,
        f: () -> ())
    {
        verify(false, file: file, line: line, f: f)
    }
    
    fileprivate func verifyRecord(in file: StaticString, _ line: UInt, record: AnyRecord) {
        guard records.count > 0 else {
            XCTFail("Extra call: \"\(record.hook.name)(\(record.anyValue))\"",
                file: file, line: line)
            return
        }
        
        let target = records.removeFirst()
        
        guard target.hook === record.hook else {
            XCTFail("Wrong call. Receive \(target.hook.name). Expect \(record.hook.name)",
                file: file, line: line)
            return
        }
        
        guard target.hook.cmp(target, record) else {
            XCTFail("Wrong arguments for \(target.hook.name). Receive \(record.anyValue). Expect \(target.anyValue)",
                file: file, line: line)
            return
        }
    }
    
    func clean() {
        records = []
    }
}

