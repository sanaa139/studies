import sys

def computePrefixFunction(pattern, m):
    LPS = [0] * m
    j = 0;
    i = 1;
    LPS[0] = 0;
    while i < m:
        if pattern[i] == pattern[j]:
            LPS[i] = j + 1
            i = i + 1
            j = j + 1
        elif j != 0:
            j = LPS[j - 1]
        else:
            LPS[i] = 0
            i = i + 1
    return LPS
        

def KmpAlgorithm(pattern, file):
    m = len(pattern)

    LPS = computePrefixFunction(pattern, m)

    i = 0
    j = 0
    
    f = open(file, "r", encoding="utf-8")
    text = f.read()
    while(i < len(text)):
        if text[i] == pattern[j]: 
            j = j + 1
            i = i + 1
        else:
            if j != 0:
                j = LPS[j - 1]
            else:
                i = i + 1
        
        if j == m:
            print(str(i - j) + ",", end = " ")
            j = LPS[j-1]
                
def main():
    KmpAlgorithm(sys.argv[1], sys.argv[2])

if __name__ == "__main__":
    main()