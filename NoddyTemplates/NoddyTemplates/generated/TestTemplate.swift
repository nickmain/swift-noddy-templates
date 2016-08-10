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
