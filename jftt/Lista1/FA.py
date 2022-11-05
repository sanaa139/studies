import sys

def getNextState(pattern, state, newCharacter):
    stringInCurrentState = pattern[0:state] + newCharacter
    
    result = 0
    for i in range(0, len(pattern) + 1):
        if stringInCurrentState.endswith(pattern[0:i]):
            result = i
    
    return result

def computeTransitionTable(pattern, alphabet):
    transitionTable = {}
    
    for state in range(0, len(pattern) + 1):
        for x in alphabet:
            transitionTable[state, x] = getNextState(pattern, state, x)
    return transitionTable
        

def getAlphabet(pattern):
    alphabet = []
    for i in range(0, len(pattern)):
        if pattern[i] not in alphabet:
            alphabet.append(pattern[i])
    return alphabet
        

def finiteAutomataMatcher(pattern, file):
    
    alphabet = getAlphabet(pattern)
    
    print(alphabet)
    
    transitionTable = computeTransitionTable(pattern, alphabet)
    
    f = open(file, "r", encoding="utf-8")
    q = 0
    c = 0
    text = f.read()
    while(c < len(text)):
        q = transitionTable.get((q, text[c]), 0)
        if q == len(pattern):
            print(c - len(pattern) + 1, end = ", ")
        c = c + 1
        
def main():
    finiteAutomataMatcher(sys.argv[1], sys.argv[2])

if __name__ == "__main__":
    main()