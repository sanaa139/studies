#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <sys/types.h>
#include <stdbool.h>
#include <time.h>
#include <math.h>

#define NYT_NODE -1	
#define INTERNAL_NODE -2
#define MAX_NODES 1000

int sizeOfFile = 0;
int sizeOfCompFile = 0;
double sumOfAverageNumOfApp = 0;
unsigned char bits[8];
size_t lenOfBin = 0;

//Struktura nodea
typedef struct node tree_node;
struct node {
  int freq;
  int character;
  int order;
  tree_node* left;
  tree_node* right;
  tree_node* parent;
};

double calculateAverageNumOfAppearances(FILE* file, tree_node** tree_array){
    unsigned char byte = 0; 
    int size = 0; 
    double bytes[256] = {0}; 
    double sum = 0;

    byte = fgetc(file);
    while(!feof(file)){
        bytes[(int)byte]++;
        size++;
        byte = fgetc(file);
    }
    
    for(int i = 0; i < 256; i++){
        bytes[i]  = bytes[i] / sizeOfFile;
    }

    tree_node* tree_root = NULL;
    tree_root = tree_array[0];

    int arrayOfAverageNumOfAppearances[256];
    for(int i = 0; i < 256; i++){
        arrayOfAverageNumOfAppearances[i] = 0;
    }

    int temp = 0;

    for(int i = 0; i < 256; i++){
        int c = i;
        for(int j = 0; j < MAX_NODES; j++){
            if(tree_array[j] == NULL){
                break;
            }
            if(c == tree_array[j]->character){
                while(tree_root->character != c){
                    if(tree_root->left->character == c){
                        temp++;
                        tree_root = tree_root->left;
                    }else if(tree_root->right->character == c){
                        temp++;
                        tree_root = tree_root->right;
                    }else{
                        if(tree_root->left->character == INTERNAL_NODE){
                            temp++;
                            tree_root = tree_root->left;
                        }else{
                            temp++;
                            tree_root = tree_root->right;
                        }
                    }
                }
                tree_root = tree_array[0];
            }
        }
        arrayOfAverageNumOfAppearances[i] = temp;
        temp = 0;
    }

    double resultArray[256];
    for(int i = 0; i < 256; i++){
        resultArray[i] = bytes[i] * arrayOfAverageNumOfAppearances[i];
        sum = sum + resultArray[i];
    }
    fseek(file, 0, SEEK_SET);
    fclose(file);
    return sum;
}

double averageNumOfAppearances(char file_name[], tree_node** tree_array){
    FILE* file = fopen(file_name, "rb");
    return calculateAverageNumOfAppearances(file, tree_array);
}

double Log2(double n){  
    // log(n)/log(2) to log2.  
    return log(n)/log(2);  
}  

double calculate_entropy(FILE* file){
    unsigned char byte = 0; 
    int size = 0; 
    int bytes[256] = {0}; 
    double sum = 0;

    byte = fgetc(file);
    while(!feof(file)){
        bytes[(int)byte]++;
        size++;
        byte = fgetc(file);
    }
    
    for(int i = 0; i < 256; i++){
        if (bytes[i] != 0){
            sum += bytes[i] * Log2(bytes[i]);
        }
    } 
    fseek(file, 0, SEEK_SET);
    fclose(file);
    return Log2(size) - (sum/(double)size);
}

double entropy(char file_name[]){
    FILE* file = fopen(file_name, "rb");
    return calculate_entropy(file);
}

bool firstInput(tree_node** tree_array, int c){
  for(int i = 0; i < MAX_NODES; i++){
    if(tree_array[i] == NULL){
        break;
    }else if(tree_array[i]->character == c){
        return false;
    }
  }
  return true;
}

unsigned char convertToDec(unsigned char n[], int length){
    unsigned char result = 0;
    int power = 0;

    for(int i = length - 1; i >= 0; i--){
        result += pow(2,power) * (n[i] - 48);
        power++;
    }

    return result;
}

void writeBit(int bitToWrite, FILE* file){
    bits[lenOfBin] = bitToWrite;
    lenOfBin++;
    unsigned char decNumber = 0;
    if(lenOfBin == 8){
        decNumber = convertToDec(bits, lenOfBin);
        putc(decNumber, file);
        memset(bits, 0, lenOfBin);
        lenOfBin = 0;
    }
}

void calculateFixedCode(int c, FILE* out_file, int lengthOfBinaryNum){
    for (int i = lengthOfBinaryNum - 1; i >= 0; i--){
        char bitCharacter = (c & (1 << i)) ? '1' : '0';
        writeBit(bitCharacter, out_file);
    }
}

void encodeCharacter(int c, FILE* out_file, bool isItFirstCharacter, tree_node** tree_array, int numberOfNodes){
    // m = 256 <- maksymalna liczba znaków
    // m = 2^e + r, gdzie 0 <= r <= 2^r
    // m = 256 + 0 = 2^8 + 0 ---> e = 8, r = 0
    int e = 8;
    int r = 0;
    int k = c;
    int left_arm = 48; // <-- cyfra 0
    int right_arm = 49; // <-- cyfra 1
    tree_node* tree_root = NULL;
    int temp = 0;
    //Jesli jest to znak, który nie występuje w drzewie to przechodzimy po drzewie
    // od góry w dół w poszukiwaniu NYT nodea
    if(isItFirstCharacter == true){
        //Przechodzimy po drzewie od góry wypisując 0 jeśli przechodzimy po lewej stronie,
        //1 jeśli po prawej
        tree_root = tree_array[0];
        while(tree_root->character != NYT_NODE){
            if(tree_root->left->character == NYT_NODE){
                writeBit(left_arm, out_file);
                tree_root = tree_root->left;
            }else if(tree_root->right->character == NYT_NODE){
                writeBit(right_arm, out_file);
                tree_root = tree_root->right;
            }else{
                if(tree_root->left->character == INTERNAL_NODE){
                    writeBit(left_arm, out_file);
                    tree_root = tree_root->left;
                }else{
                    writeBit(right_arm, out_file);
                    tree_root = tree_root->right;
                }
            }
        }
        //Wypisujemy fixed code znaku (zamieniamy znak na binarną liczbę) i łączymy z ścieżką
        if(k >= 1 && k <= 2*r){
            calculateFixedCode(k - 1, out_file, e + 1);
        }else{
            calculateFixedCode(k-r-1, out_file, e);
        }
    }else{
        //Jeśli znak występuje już w drzewie to przechodzimy po drzewie szukając nodea z poszukiwanym znakiem

        //Przechodzimy po drzewie od góry wypisując 0 jeśli przechodzimy po lewej stronie,
        //1 jeśli po prawej
        tree_root = tree_array[0];
        while(tree_root->character != c){
            if(tree_root->left->character == c){
                writeBit(left_arm, out_file);
                tree_root = tree_root->left;
            }else if(tree_root->right->character == c){
                writeBit(right_arm, out_file);
                tree_root = tree_root->right;
            }else{
                if(tree_root->left->character == INTERNAL_NODE){
                    writeBit(left_arm, out_file);
                    tree_root = tree_root->left;
                }else{
                    writeBit(right_arm, out_file);
                    tree_root = tree_root->right;
                }
            }
        }
    }   
}

void swapNodes(tree_node** tree_array, int numberOfNodes, tree_node* updatedNode){
    tree_node* temp_node = malloc(sizeof(tree_node));
    tree_node* temp_node2 = malloc(sizeof(tree_node));
    
    for(int i = 0; i < numberOfNodes - 2; i++){
          if(tree_array[i]->left == NULL || tree_array[i]->right == NULL){
              break;
          }
          if(tree_array[i]->left->freq >= tree_array[i]->right->freq){
            tree_array[i]->left->order = tree_array[i]->left->order-1;
            tree_array[i]->right->order = tree_array[i]->right->order+1;
            temp_node = tree_array[i]->left;
            temp_node2 = tree_array[i]->right;
            tree_array[i]->right = temp_node;
            tree_array[i]->left = temp_node2;
            tree_array[temp_node->order] = temp_node;
            tree_array[temp_node2->order] = temp_node2;
          }
    }
}

void increaseFrequency(tree_node** tree_array, int numberOfNodes){
    for(int i = numberOfNodes-1; i >= 0; i--){
        if(tree_array[i]->character == INTERNAL_NODE){
            tree_array[i]->freq = tree_array[i]->left->freq + tree_array[i]->right->freq;
        }
    }
}

void printTree(tree_node** tree_array, int numberOfNodes){
    printf("Sprawdzamy stan drzewa.\n");
    for(int i = 0; i < numberOfNodes; i++){
        printf("%d (%d) ", tree_array[i]->character, tree_array[i]->freq);
    }
    printf("\n");
}

void actualizeTree(tree_node** tree_array, tree_node* updatedNode, bool isInTheTree, int numberOfNodes){
    if(isInTheTree == true){
        updatedNode->freq++;
    }
    increaseFrequency(tree_array, numberOfNodes);
    
    swapNodes(tree_array, numberOfNodes, updatedNode);
}

void encode(char file_name[]){
    char compressed_file_name[100] = "compressed_files/COMP_";
    strcat(compressed_file_name, file_name);
    FILE* in_file = fopen(file_name, "rb");
    FILE* out_file = fopen(compressed_file_name, "wb");

    fseek(in_file, 0L, SEEK_END);
    sizeOfFile = ftell(in_file);
    fseek(in_file, 0L, SEEK_SET);
    fprintf(out_file, "%d", sizeOfFile);

    int numberOfNodes = 0;

    tree_node* tree_array[MAX_NODES];

    for (int i = 0; i < MAX_NODES; i++){
      tree_array[i] = NULL;
    }

    tree_node* tree_root = NULL;
    
    //tworzymy NYT node
    tree_node* NYT_node = malloc(sizeof(tree_node));
    NYT_node->freq = 0;
    NYT_node->character = NYT_NODE;
    NYT_node->order = 0;
    NYT_node->left = NULL;
    NYT_node->right = NULL;
    NYT_node->parent = NULL;
    numberOfNodes++;

    //NYT node jest obecnie rootem
    //dodajemy NYT node do tablicy drzewa
    tree_root = NYT_node;
    tree_array[0] = NYT_node;	

    int c = fgetc(in_file);
    while (!feof(in_file)){
        //jeżeli znak pojawia się pierwszy raz
        if (firstInput(tree_array, c)){
            //kodujemy znak
            encodeCharacter(c, out_file, true, tree_array, numberOfNodes);
            
            //NYT node przesuwamy poziom niżej na lewo
            NYT_node->order = NYT_node->order + 2;

            //tworzymy node dla nowego znaku
            tree_node* external_node = malloc(sizeof(tree_node));
            
            external_node->freq = 1;
            external_node->character = c;
            external_node->order = NYT_node->order - 1; //na prawo od NYT nodea
            external_node->left = NULL;
            external_node->right = NULL;
            numberOfNodes++;

            //nowy node, który będzie rodzicem NYT (zastępuje on miejsce NYT nodea)
            tree_node* internal_node = malloc(sizeof(tree_node));
            
            internal_node->left = NYT_node;
            internal_node->right = external_node;
            internal_node->freq = internal_node->left->freq + internal_node->right->freq;
            internal_node->character = INTERNAL_NODE;
            internal_node->order = NYT_node->order - 2; //poziom wyżej jako rodzic NYT nodea
            internal_node->parent = NYT_node->parent;  //jako że zastępuje NYT nodea to ma ojca NYT nodea
            numberOfNodes++;

            if(NYT_node->parent!=NULL){
                NYT_node->parent->left = internal_node;
            }
            
            //          internal node
            //          |           |
            //      NYT node      external node

            external_node->parent = internal_node;
            NYT_node->parent = internal_node;

            NYT_node->left = NULL;
            NYT_node->right = NULL;

            tree_array[internal_node->order] = internal_node;
            tree_array[external_node->order] = external_node;
            tree_array[NYT_node->order] = NYT_node;
            actualizeTree(tree_array, internal_node, false, numberOfNodes);
          
        }else{
            //Wczytywany znak znajduje się już w drzewie
        
            //kodujemy znak
            encodeCharacter(c, out_file, false, tree_array, numberOfNodes);
            tree_node* external_node = NULL;
            //Szukamy znaku w tablicy drzewa
            for (int i = 0; i < numberOfNodes; i++){
                if (tree_array[i]->character == c){
                    external_node = tree_array[i];
                    break;
                }
            }
            actualizeTree(tree_array, external_node, true, numberOfNodes);
        }
        c = fgetc(in_file);
    }
    unsigned long ileDopisano = 8 - lenOfBin;
    while(lenOfBin != 0){
        writeBit('0', out_file);
    }
    sumOfAverageNumOfApp = averageNumOfAppearances(file_name, tree_array);

    fseek(out_file, 0L, SEEK_END);
    sizeOfCompFile = ftell(out_file);
    fseek(out_file, 0L, SEEK_SET);

    for(int i = 0; i < MAX_NODES; i++){
        if (tree_array[i] == NULL){
            break;
        }
        free(tree_array[i]);
    }
    fclose(in_file);
    fclose(out_file);
}

void decode(char file_name[]){
    char compressed_file_name[100] = "compressed_files/COMP_";
    strcat(compressed_file_name, file_name);
    FILE* in_file = fopen(compressed_file_name, "rb");
    char decompressed_file_name[100] = "decompressed_files/DECOMP_";
    strcat(decompressed_file_name, file_name);
    FILE* out_file = fopen(decompressed_file_name, "wb");
    size_t size;
    fscanf(in_file, "%zu", &size);

    int numberOfNodes = 0;

    tree_node* tree_array[MAX_NODES];	

    for (int i = 0; i < MAX_NODES; i++)
      tree_array[i] = NULL;

    tree_node* tree_root = NULL;	

    tree_node* NYT_node = malloc(sizeof(tree_node));
  
    NYT_node->freq = 0;
    NYT_node->character = NYT_NODE;
    NYT_node->order = 0;
    NYT_node->left = NULL;
    NYT_node->right = NULL;
    NYT_node->parent = NULL;
    numberOfNodes++;
    
    tree_root = NYT_node;
    tree_array[0] = NYT_node;	

    bool isItNYTnode = true;
    int e = 8;
    int r = 0;
    int lengthOfBin = 0;

    unsigned char bin[MAX_NODES];
    int c;
    int temp = 1;
    int character = 0;
    int odKiedy = 0;
    int doKiedy = 8;

    unsigned char* arrayOfBits = malloc(500000000);
    c = fgetc(in_file);
    while(!feof(in_file)){
        for (int i = 8 - 1; i >= 0; i--){
            char bitCharacter = (c & (1 << i)) ? '1' : '0';
            bits[i] = bitCharacter;
        }
        int i = 7;
        for(int j = odKiedy; j < doKiedy; j++){
            arrayOfBits[j] = bits[i];
            i--;
        }
        odKiedy = odKiedy + 8;
        doKiedy = doKiedy + 8;
        c = fgetc(in_file);
    }
    int ilosc_zdekodowanych = 0;
    int m = 0;

    while(ilosc_zdekodowanych < size){
        while(tree_root->left != NULL && tree_root->right != NULL){
            if(c == 49){
                tree_root = tree_root->right;
            }else if(c == 48){
                tree_root = tree_root->left;
            }
            else{
                return;
            }
            if(tree_root->left == NULL && tree_root->right == NULL){
                break;
            }
            c = arrayOfBits[m];
            m++;
        }
        temp = 0;
        if(tree_root->character == NYT_NODE){
            isItNYTnode = true;
        }else{
            isItNYTnode = false;
        }
        if(isItNYTnode == true){
            for(int i = 0; i < e; i++){
                bin[i] = arrayOfBits[m];
                m++;
            }
            temp = convertToDec(bin, e);
           
            //Jesli temp < r to wczytaj jeszcze jeden bit
            if(temp < r){
                bin[lengthOfBin] = arrayOfBits[m];
                m++;
                lengthOfBin = lengthOfBin + 1;
                temp = convertToDec(bin, lengthOfBin);
            }else{
                temp = temp + r;
            }
            character = temp + 1;
            putc(character, out_file);
            ilosc_zdekodowanych++;
        }else{
            character = tree_root->character;
            putc(character, out_file);
            ilosc_zdekodowanych++;
        }
        temp = 0;
        memset(bin, 0, lengthOfBin);
        lengthOfBin = 0;
        
        if(firstInput(tree_array, character)){
            NYT_node->order = NYT_node->order + 2;

            tree_node* external_node = malloc(sizeof(tree_node));
            
            external_node->freq = 1;
            external_node->character = character;
            external_node->order = NYT_node->order - 1;
            external_node->left = NULL;
            external_node->right = NULL;
            numberOfNodes++;

            // create a new inner node
            tree_node* internal_node = malloc(sizeof(tree_node));
            
            internal_node->freq = NYT_node->freq + external_node->freq;
            internal_node->character = INTERNAL_NODE;
            internal_node->order = NYT_node->order - 2; // replaces ZERO
            internal_node->left = NYT_node;
            internal_node->right = external_node;
            internal_node->parent = NYT_node->parent; // parent of the previous ZERO node
            numberOfNodes++;

            if (NYT_node->parent != NULL){
                NYT_node->parent->left = internal_node;
            }

            external_node->parent = internal_node;
            NYT_node->parent = internal_node;

            tree_array[internal_node->order] = internal_node;
            tree_array[external_node->order] = external_node;
            tree_array[NYT_node->order] = NYT_node;

            actualizeTree(tree_array, internal_node, false, numberOfNodes);
        }else{
            tree_node* external_node = NULL;
            //Szukamy znaku w tablicy drzewa
            for (int i = 0; i < MAX_NODES; i++){
                if (tree_array[i]->character == character){
                    external_node = tree_array[i];
                    break;
                }
            }
            actualizeTree(tree_array, external_node, true, numberOfNodes);
        }
        tree_root = tree_array[0];
        c = arrayOfBits[m];
        m++;
    }

    for (int i = 0; i < MAX_NODES; i++){
        if (tree_array[i] == NULL){
            break;
        }
        free(tree_array[i]);
    }

    fclose(in_file);
    fclose(out_file);
}

int main(int argc, char **argv){
    clock_t start, end;
    double cpu_time_used;

    start = clock();
    encode(argv[1]);
    end = clock();
    cpu_time_used = ((double) (end - start)) / CLOCKS_PER_SEC;
    printf("\n");
    printf("%s %f\n\n", "Czas kompresji:", cpu_time_used);

    printf("%s %f\n", "Średnia długość kodowania:", sumOfAverageNumOfApp);
    printf("%s %f\n", "Entropia kodowanego tekstu:", entropy(argv[1]));
    printf("%s %f\n", "Stopień kompresji:", (double) sizeOfCompFile / (double) sizeOfFile);
   
    start = clock();
    decode(argv[1]);  
    end = clock();
    cpu_time_used = ((double) (end - start)) / CLOCKS_PER_SEC;
    printf("%s %f\n\n", "Czas dekompresji:", cpu_time_used);

    return (0);
}
