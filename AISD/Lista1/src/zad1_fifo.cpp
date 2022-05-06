#include <iostream>

struct node{
    int data;
    node* next;
};

class fifo{
public:
    fifo()= default;
    ~fifo();

    void push(int value){
        node *newNode = new node;
        newNode->data = value;
        newNode->next = nullptr;

        if(head == nullptr){
            head = newNode;
            tail = newNode;
        }else{
            struct node *lastNode = tail;
            lastNode->next = newNode;
            tail = lastNode->next;
            newNode->next = nullptr;
        }
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
    node *tail = nullptr;
};


int main(){
    fifo* queue = new fifo;

    int numberOfElements = 100;

    for (int i = 0; i < numberOfElements; i++){
        queue->push(i);
        if(!queue->isEmpty()){
            std::cout << "Dodawany element FIFO: " << queue->getElement(i) << std::endl;
        }
    }

    if(!queue->isEmpty()){
        for (int i = 0; i < numberOfElements; i++) {
            std::cout << "Usuwany element FIFO: " << queue->pop() << std::endl;
        }
    }
    return 0;
}

