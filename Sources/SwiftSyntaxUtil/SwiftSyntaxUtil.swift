
import Foundation
import SwiftSyntax

public extension Syntax {

    func has(ancestor: Syntax) -> Bool {
        if let parent = parent {
            return (parent == ancestor) || parent.has(ancestor: ancestor) == true
        }
        return false
    }

    func has(ancestorType: Syntax.Type) -> Bool {
        if let parent = parent {
            return (type(of: parent) == ancestorType) || parent.has(ancestorType: ancestorType) == true
        }
        return false
    }

    func has(ancestorTypes: [Syntax.Type]) -> Bool {
        var current = self.parent
        for ancestorType in ancestorTypes {
            if let parent = current, type(of: parent) == ancestorType {
                current = parent.parent
            } else {
                return false
            }
        }
        return true
    }
}
