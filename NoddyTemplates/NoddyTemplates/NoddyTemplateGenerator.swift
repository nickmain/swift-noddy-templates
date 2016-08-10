//
//  NoddyTemplateGenerator.swift
//  NoddyTemplates
//
//  Created by Nick Main on 8/9/16.
//  Copyright © 2016 Nick Main. All rights reserved.
//

import Foundation

// Generate a Swift source file from a template
class TemplateGenerator {

    let output: TemplateOutput
    var indentLevel = 0

    init(output: TemplateOutput) {
        self.output = output
    }

    // Write the start of the template class and process func body
    func writePreamble(className: String, baseClassName: String?) {
        output.start()
        output.writeLine("// *** THIS SOURCE IS GENERATED - DO NOT EDIT ***")
        output.writeLine("")

        if let baseName = baseClassName {
            output.writeLine("class \(className): \(baseName), NoddyTemplate {")
        } else {
            output.writeLine("class \(className): NoddyTemplate {")
        }

        output.writeLine("    func process(writer: TemplateOutput) {")
        output.writeLine("        writer.start()")
    }

    // Write the end of the template class and process func body
    func writePostamble() {
        output.writeLine("    }")
        output.writeLine("}")
        output.end()
    }

    // Write a template text output line
    func writeTextLine(text: String) {
        let escaped = text.replacingOccurrences(of: "\\(", with: "@@@(") //temp to protect '\(...)'
            .replacingOccurrences(of: "\\", with: "\\\\")
            .replacingOccurrences(of: "\"", with: "\\\"")
            .replacingOccurrences(of: "@@@(", with: "\\(") //restore '\(...)'
        output.writeLine("        \(getIndent())writer.writeLine(\"\(escaped)\")")
    }

    // Write a template code line
    func writeCodeLine(code: String) {
        if code.hasPrefix("}") && indentLevel > 0 {
            indentLevel -= 1
        }

        output.writeLine("        \(getIndent())\(code)")

        if code.hasSuffix("{") {
            indentLevel += 1
        }
    }

    func getIndent() -> String {
        var indent = ""
        for _ in 0..<indentLevel {
            indent = indent.appending("    ")
        }
        return indent
    }

    // Handle a template line of either code or text
    func processTemplateLine(line: String) {
        var trimmed = line.trimmingCharacters(in: CharacterSet.whitespaces)
        if trimmed.hasPrefix("`") {
            trimmed.remove(at: trimmed.startIndex)
            writeCodeLine(code: trimmed)
        } else {
            writeTextLine(text: line)
        }
    }

    // Process the body of a template
    func process(templateText: String) {
        templateText.enumerateLines {(line: String, stop: inout Bool) in
            self.processTemplateLine(line: line)
        }
    }

    // Process the body of a template from a file
    func process(templateFile: String) {
        do {
            let text = try String(contentsOfFile: templateFile)
            process(templateText: text)
        } catch {
            print("Could not process template file \(templateFile) - \(error)")
        }
    }

    // Generate Swift code file from a template
    static func generate(templatePath: String, codeFile: String, className: String, baseClassName: String? ) {
        let translator = TemplateGenerator(output: TemplateFileWriter(filepath: codeFile))
        translator.writePreamble(className: className, baseClassName: baseClassName)
        translator.process(templateFile: templatePath)
        translator.writePostamble();
    }
}
