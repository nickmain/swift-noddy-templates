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
