class OutputFile(object):

    def __init__(self, outputName, xml = None):
        self.xml = xml
        self.file = open(outputName, 'w')
        if (self.xml):
            self.file.write('<' + self.xml + '>\n')

    def close(self):
        if (self.xml):
            self.file.write('</' + self.xml + '>\n')
        self.file.close()

    def write(self, string):
        self.file.write(string)

    def writeLine(self, string):
        self.file.write(string + '\n')

    def writeXML(self, tag, value):
        self.file.write('<' + tag + '> ')
        self.file.write(self._XMLEsc(value))
        self.file.write(' </' + tag + '>\n')

    def _XMLEsc(self, line):
        line = line.replace('&', '&amp;')
        line = line.replace('<', '&lt;')
        line = line.replace('>', '&gt;')
        line = line.replace('"', '&quot;')
        return line
