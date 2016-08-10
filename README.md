##Minimal Templates for Swift

Translates template files to Swift classes that emit the template text.

Templates can include Swift source lines that are copied to the generated templates classes.

No Pods. No dependencies.

##Example
The template:
```
The quick brown fox jumps over the lazy dog
    `for a in foo {
    Hey diddle diddle the \(a) and the fiddle
    and the dish ran away with the spoon
    `}

Wee Willie Winkie runs through the town,
Up stairs and down stairs in his night-gown,
Tapping at the window, crying at the lock,
Are the children in their bed, for it's past ten o'clock?

""""\\""\"
```
generates the following Swift class:
```
// *** THIS SOURCE IS GENERATED - DO NOT EDIT ***

class TestTemplate: TemplateBase, NoddyTemplate {
    func process(writer: TemplateOutput) {
        writer.start()
        writer.writeLine("The quick brown fox jumps over the lazy dog")
        for a in foo {
            writer.writeLine("    Hey diddle diddle the \(a) and the fiddle")
            writer.writeLine("    and the dish ran away with the spoon")
        }
        writer.writeLine("")
        writer.writeLine("Wee Willie Winkie runs through the town,")
        writer.writeLine("Up stairs and down stairs in his night-gown,")
        writer.writeLine("Tapping at the window, crying at the lock,")
        writer.writeLine("Are the children in their bed, for it's past ten o'clock?")
        writer.writeLine("")
        writer.writeLine("\"\"\"\"\\\\\"\"\\\"")
    }
}

```
where the class name `TestTemplate` and the superclass `TemplateBase` are arguments of the template generator call.

`foo` is a member of the superclass.

The template can be used as so:
```
class TemplateBase {
    var foo: [String]

    init(foo: [String]) {
        self.foo = foo
    }
}

let t = TestTemplate(foo: ["aaaaaa", "bbbbbbb", "ccccccc"])

t.process(writer: TemplateOutputPrinter())
```
to emit the text:
```
The quick brown fox jumps over the lazy dog
    Hey diddle diddle the aaaaaa and the fiddle
    and the dish ran away with the spoon
    Hey diddle diddle the bbbbbbb and the fiddle
    and the dish ran away with the spoon
    Hey diddle diddle the ccccccc and the fiddle
    and the dish ran away with the spoon

Wee Willie Winkie runs through the town,
Up stairs and down stairs in his night-gown,
Tapping at the window, crying at the lock,
Are the children in their bed, for it's past ten o'clock?

""""\\""\"
```

"Noddy" (British) = "Mickey Mouse" (USA), as in "trivial": https://en.wikipedia.org/wiki/Noddy_(character)#Derivative_uses  
