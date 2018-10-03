//
//  DiffProessor.swift
//  LNProvider
//
//  Created by John Holdsworth on 03/04/2017.
//  Copyright © 2017 John Holdsworth. All rights reserved.
//

import Foundation
import UIKit

class ExperimentalDiff {
    
    let regex = try! NSRegularExpression(pattern: "^(?:(?:@@ -\\d+,\\d+ \\+(\\d+),\\d+ @@)|([-+\\s])(.*))", options: [])
    
    let unifiedDiff: String
    
    init(unifiedDiff: String) {
        self.unifiedDiff = unifiedDiff
    }
    
    func parse() -> NSAttributedString {
        let attributed = NSMutableAttributedString()
        let insertedAttributes: [NSAttributedString.Key: Any] = [
            NSAttributedString.Key.font: UIFont.monospacedDigitSystemFont(ofSize: 12, weight: .regular),
            NSAttributedString.Key.foregroundColor : UIColor.black,
            NSAttributedString.Key.backgroundColor : UIColor.green
        ]
        let deletedAttributes: [NSAttributedString.Key: Any] = [
            NSAttributedString.Key.font: UIFont.monospacedDigitSystemFont(ofSize: 12, weight: .regular),
            NSAttributedString.Key.foregroundColor : UIColor.black,
            NSAttributedString.Key.backgroundColor : UIColor.red
        ]
        let unchangedAttributes: [NSAttributedString.Key: Any] = [
            NSAttributedString.Key.font: UIFont.monospacedDigitSystemFont(ofSize: 12, weight: .regular),
            NSAttributedString.Key.foregroundColor : UIColor.black
        ]
        unifiedDiff.enumerateLines { line, _ in
            // Skip headers
            guard !line.starts(with: "+++"), !line.starts(with: "---") else { return }
            // Find delta and
            switch self.delta(line: line) {
            case .start:
                break
            case .insert(let text):
                attributed.append(NSAttributedString(string: "\(text)\n", attributes: insertedAttributes))
            case .delete(let text):
                attributed.append(NSAttributedString(string: "\(text)\n", attributes: deletedAttributes))
            case .unchanged(let text):
                attributed.append(NSAttributedString(string: "\(text)\n", attributes: unchangedAttributes))
            case .other:
                break
            }
        }
        return attributed
    }
    
    enum Delta {
        case start(lineno: Int)
        case delete(text: String)
        case insert(text: String)
        case unchanged(text: String)
        case other
    }
    
    func delta(line: String) -> Delta {
        if let match = regex.firstMatch(in: line, options: [], range: NSMakeRange(0, line.utf16.count)) {
            if let lineno = match.group(1, in: line) {
                return .start(lineno: Int(lineno) ?? -1)
            } else if let delta = match.group(2, in: line), let text = match.group(3, in: line) {
                switch delta {
                case "-": return .delete(text: text)
                case "+": return .insert(text: text)
                case " ": return .unchanged(text: text)
                default: fatalError("Unexpected group 2 character: \(delta)")
                }
            }
        }
        return .other
    }
}

extension NSTextCheckingResult {
    
    func group(_ group: Int, in string: String) -> String? {
        if range(at: group).location != NSNotFound {
            return string[range(at: group)]
        }
        return nil
    }
    
}

extension String {
    
    public subscript(i: Int) -> String {
        return self[i ..< i + 1]
    }
    
    public subscript(range: NSRange) -> String {
        return Range(range, in: self).flatMap { String(self[$0]) } ?? "??"
    }
    
    public subscript(r: Range<Int>) -> String {
        return self[NSMakeRange(r.lowerBound, r.upperBound - r.upperBound)]
    }
    
}
