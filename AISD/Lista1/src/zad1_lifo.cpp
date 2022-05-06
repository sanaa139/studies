#include <iostream>

struct node{
    int data;
    node* next;
};

class lifo{
public:
    lifo()= default;
    ~lifo();

    void push(int value){
        node *newNode = new node;
        newNode->data = value;
        newNode->next = head;

        head = newNode;
    }
    int pop(){
        int k = 0;
        if(head != nullptr){
            node *oldHead;
            oldHead = head;
            k = head->data;
            head = oldHead->next;
            free(oldHead);
        }
        return k;
    }
    bool isEmpty(){
        if(head == nullptr){
            return true;
        }else return false;
    }
    int getElement(int n){
        node *temp = head;

        for(int i = 0; i < n+1; i++){
            if( i == n ) {
                break;
            }
            temp = temp->next;
        }
        return temp->data;
    }
    
private:
    node *head = nullptr;
};


int main(){
    lifo* stack = new lifo;

    int numberOfElements = 100;

    for (int i = 0; i < numberOfElements; i++){
        stack->push(i);
        if(!stack->isEmpty()){
            std::cout << "Dodawany element LIFO: " << stack->getElement(0) << std::endl;
        }
    }

    if(!stack->isEmpty()){
        for (int i = 0; i < numberOfElements; i++) {
            std::cout << "Usuwany element LIFO: " << stack->pop() << std::endl;
        }
    }
    return 0;
}

