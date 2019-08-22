import XCTest
@testable import SwiftSyntaxUtil
import SwiftSyntax

final class SwiftSyntaxUtilTests: XCTestCase {
    func testItHasAncestor() throws {

        let funcDeclNoAnc = FunctionDeclSyntax { (_) in
        }

        let sourceDecl = SourceFileSyntax { (b) in
            b.addStatement(CodeBlockItemSyntax({ (b) in
                b.useItem(FunctionDeclSyntax({ (b) in
                    b.useBody(CodeBlockSyntax({ (b) in
                        b.addStatement(CodeBlockItemSyntax({ (b) in
                            b.useItem(VariableDeclSyntax({ (b) in
                                b.addAttribute(AttributeSyntax({ (b) in
                                }))
                            }))
                        }))
                    }))
                }))
            }))
        }

        let sourceCodeListDecl = sourceDecl.statements
        let sourceCodeItemDecl = sourceCodeListDecl.first(where: {_ in true})!
        let funcDeclAnc = sourceCodeItemDecl.item as! FunctionDeclSyntax
        let funcCodeBlockDecl = funcDeclAnc.body!
        let funcCodeListDecl = funcCodeBlockDecl.statements
        let funcCodeItemDecl = funcCodeListDecl.first(where: {_ in true})!
        let varDecl = funcCodeItemDecl.item as! VariableDeclSyntax
        let attrListDecl = varDecl.attributes!
        let attrDecl = attrListDecl.first(where: {_ in true})!

        var current: Syntax? = attrDecl
        while let currentParent = current?.parent {
            NSLog("\(type(of: currentParent))")
            current = currentParent
        }

        XCTAssertFalse(funcDeclNoAnc.has(ancestor: funcDeclNoAnc))
        XCTAssertFalse(funcDeclNoAnc.has(ancestorType: FunctionDeclSyntax.self))

        XCTAssertFalse(attrDecl.has(ancestor: attrDecl))
        XCTAssertFalse(sourceDecl.has(ancestor: sourceDecl))
        XCTAssertTrue(attrDecl.has(ancestor: varDecl))
        XCTAssertTrue(attrDecl.has(ancestor: sourceDecl))

        XCTAssertFalse(attrDecl.has(ancestorType: AttributeSyntax.self))
        XCTAssertFalse(sourceDecl.has(ancestorType: SourceFileSyntax.self))
        XCTAssertTrue(attrDecl.has(ancestorType: VariableDeclSyntax.self))
        XCTAssertTrue(attrDecl.has(ancestorType: SourceFileSyntax.self))

        XCTAssertFalse(attrDecl.has(ancestorTypes: [AttributeSyntax.self]))
        XCTAssertFalse(sourceDecl.has(ancestorTypes: [SourceFileSyntax.self]))
        XCTAssertFalse(attrDecl.has(ancestorTypes: [SourceFileSyntax.self]))
        XCTAssertFalse(attrDecl.has(ancestorTypes: [
            AttributeListSyntax.self,
            VariableDeclSyntax.self,
            VariableDeclSyntax.self]))
        XCTAssertTrue(attrDecl.has(ancestorTypes: [AttributeListSyntax.self]))
        XCTAssertTrue(attrDecl.has(ancestorTypes: [
            AttributeListSyntax.self,
            VariableDeclSyntax.self]))
        XCTAssertTrue(attrDecl.has(ancestorTypes: [
            AttributeListSyntax.self,
            VariableDeclSyntax.self,
            CodeBlockItemSyntax.self,
            CodeBlockItemListSyntax.self,
            CodeBlockSyntax.self,
            FunctionDeclSyntax.self,
            CodeBlockItemSyntax.self,
            CodeBlockItemListSyntax.self,
            SourceFileSyntax.self
            ]))
    }

    static var allTests = [
        ("testItHasAncestor", testItHasAncestor),
    ]
}
