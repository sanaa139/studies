#include <iostream>
#include <fstream>
#include <vector>
#include <map>
#include <cmath>

double entropy(std::ifstream* input_file){
    char byte = 0;
    std::map<char, int> letterCount;
    int size = 0;
    
    while(input_file -> get(byte)){
        size++;
        ++letterCount[(byte)];
    }

    double sum = 0;

    for(std::map<char, int>::iterator it = letterCount.begin(); it != letterCount.end(); it++){
        sum += (it->second)/(double)size * log2((it->second)/(double)size);
    }

    double answer = -1 * sum;

    input_file -> clear();
    input_file -> seekg(0, std::ios::beg);

    if(answer == 0){
        return 0;
    }else return answer;
}

double conditionalEntropy(std::ifstream* input_file){
    char byte = 0;
    std::map<char, int> letterCount;
    std::map<std::string, int> letterCountDouble;
    int size = 0;
    
    std::string doubleChar = "aa";
    char previous = 0;
    while(input_file -> get(byte)){
        ++letterCount[(byte)];
        
        doubleChar[0] = previous;
        doubleChar[1] = byte;
        ++letterCountDouble[doubleChar];

        previous = byte;
        size++;
    }

    double sum = 0;
    for(std::map<std::string, int>::iterator it = letterCountDouble.begin(); it != letterCountDouble.end(); it++){ 
        if(letterCount[it->first[0]] != 0){
            sum += (it->second)/(double)size *( log2(it->second/(double)size) - log2(letterCount[it->first[0]]/(double)size));
        }
    }

    input_file -> clear();
    input_file -> seekg(0, std::ios::beg);

    if(sum == 0){
        return 0;
    }else return -1 * sum;
}

int main(int argc, char* argv[]){
    std::ifstream input_file(argv[1]);
    if(!input_file.is_open()){
        std::cerr << "Could not open the file - '"
             << argv[1] << "'" << std::endl;
        return EXIT_FAILURE;
    }

    double entropy1 = entropy(&input_file);
    std::cout << "Entropy := " << entropy1 << std::endl;
    
    double conditionalEntropy1 = conditionalEntropy(&input_file);
    std::cout << "Conditional entropy := " << conditionalEntropy1 << std::endl;

    double difference = conditionalEntropy1- entropy1;
    if(difference < 0){
        difference = difference * (-1);
    }
    std::cout << "Difference := " << difference <<std::endl;

    input_file.close();

    return EXIT_SUCCESS;
}