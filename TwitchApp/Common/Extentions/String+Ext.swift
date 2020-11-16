//
//  String+Ext.swift
//  TwitchApp
//
//  Created by Kabdolla on 11/16/20.
//

import Foundation

extension String {
    func chunked(by length: Int) -> [String] {
        stride(from: 0, to: self.count, by: length).map {
            let start = self.index(self.startIndex, offsetBy: $0)
            let end = self.index(start, offsetBy: length, limitedBy: self.endIndex) ?? self.endIndex
            return String(self[start..<end])
        }
    }

    var isBlank: Bool { trimmingCharacters(in: .whitespacesAndNewlines).isEmpty }
    var isNotBlank: Bool { !isBlank }

    func fromHexadecimalToBytes() -> Foundation.Data? {
        let stringBytes = split(separator: " ")
        let stringBytesFiltered = stringBytes.map { String($0) }.filter { !$0.isBlank }
        let bytes = stringBytesFiltered.map { $0.toByte() }

        guard bytes.allSatisfy({ $0 != nil }) else { return nil }

        let notNilBytes = bytes.map { $0! }

        return Foundation.Data(notNilBytes)
    }

    func toByte() -> UInt8? {
        guard count == 2 else { return nil }

        return UInt8(self, radix: 16)
    }

    // Copied from https://stackoverflow.com/a/30404532/1737960
    func range(from nsRange: NSRange) -> Range<String.Index>? {
        guard
                let from16 = utf16.index(utf16.startIndex, offsetBy: nsRange.location, limitedBy: utf16.endIndex),
                let to16 = utf16.index(utf16.startIndex,
                        offsetBy: nsRange.location + nsRange.length,
                        limitedBy: utf16.endIndex),
                let from = from16.samePosition(in: self),
                let to = to16.samePosition(in: self)
                else { return nil }
        return from ..< to
    }
}

extension Optional where Wrapped == String {
    var isBlank: Bool {
        if let unwrapped = self {
            return unwrapped.isBlank
        } else {
            return true
        }
    }

    var isNilOrEmpty: Bool { self?.isEmpty ?? true }
    var isNilOrBlank: Bool { self?.isBlank ?? true }
}
