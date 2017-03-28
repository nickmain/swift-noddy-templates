//
//  main.swift
//  NoddyTemplates
//
//  Created by Nick Main on 3/28/17.
//  Copyright © 2017 Nick Main. All rights reserved.
//

import Foundation

let sourcePath = ProcessInfo.processInfo.arguments[1] //SOURCE_ROOT is passed in as first arg

TemplateGenerator.generate(templatePath: "\(sourcePath)/NoddyTemplates/example/test-template.txt",
    codeFile: "\(sourcePath)/NoddyTemplates/generated/TestTemplate.swift",
    className: "TestTemplate",
    baseClassName: "TemplateBase")
