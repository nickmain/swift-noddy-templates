//
//  main.swift
//  NoddyTemplates
//
//  Created by Nick Main on 8/9/16.
//  Copyright © 2016 Nick Main. All rights reserved.
//

import Foundation

class TemplateBase {
    var foo: [String]

    init(foo: [String]) {
        self.foo = foo
    }
}

let t = TestTemplate(foo: ["aaaaaa", "bbbbbbb", "ccccccc"])

t.process(writer: TemplateOutputPrinter())

let sourcePath = ProcessInfo.processInfo.arguments[1] //SOURCE_ROOT is passed in as first arg

TemplateGenerator.generate(templatePath: "\(sourcePath)/NoddyTemplates/example/test-template.txt",
                           codeFile: "\(sourcePath)/NoddyTemplates/generated/TestTemplate.swift",
                           className: "TestTemplate",
                           baseClassName: "TemplateBase")
