//
//  NoddyTemplates.swift
//  NoddyTemplates
//
//  Created by Nick Main on 8/9/16.
//  Copyright © 2016 Nick Main. All rights reserved.
//

import Foundation

// Implemented by receivers of template output
protocol TemplateOutput {
    func start()
    func writeLine(_ text: String)
    func end()
}

// Template output that just prints
class TemplateOutputPrinter: TemplateOutput {
    func start() {}
    func end() {}

    func writeLine(_ text: String) {
        print(text)
    }
}

// Template output to a file
class TemplateFileWriter: TemplateOutput {
    var fileHandle: FileHandle?
    let filepath: String
    static let NEWLINE = "\n".data(using: String.Encoding.utf8)!

    init(filepath: String) {
        self.filepath = filepath
    }

    func start() {
        if fileHandle != nil { return }

        if !FileManager.default.fileExists(atPath: filepath) {
            FileManager.default.createFile(atPath: filepath, contents: nil, attributes: nil)
        }

        fileHandle = FileHandle(forWritingAtPath: filepath)
    }

    func end() {
        guard let file = fileHandle else { return }
        file.closeFile()
        fileHandle = nil
    }

    func writeLine(_ text: String) {
        guard let file = fileHandle else { return }
        let data = text.data(using: String.Encoding.utf8)!
        file.write(data)
        file.write(TemplateFileWriter.NEWLINE)
    }

    deinit {
        end()
    }
}

// Implemented by generated templates
protocol NoddyTemplate {
    func process(writer: TemplateOutput)
}
