#provide two functions used by CatchKey.py 
#Get the woeds in string
def getWord(s):
    words = []
    isWord = 0
    for c in s:
        if c in " \r\n\t": # whitespace
            isWord = 0
        elif not isWord:
            words = words + [c]
            isWord = 1
        else:
            words[-1] = words[-1] + c
    return words
