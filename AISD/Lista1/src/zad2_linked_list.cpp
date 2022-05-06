#include <iostream>
#include <chrono>

struct node{
    int data;
    node* next;
};

class linkedList{
public:
    linkedList()= default;
    ~linkedList();

    void push_back(int value){
        node* newNode = new node;
        newNode->data = value;
        newNode->next = nullptr;

        if(head == nullptr){
            head = newNode;
        }else{
            node *lastNode = head;
            while(lastNode->next != nullptr){
                lastNode = lastNode->next;
            }
            lastNode->next = newNode;
            }
    }
    int printList(){
        if(head == nullptr){
            printf("Pusta lista\n");
            return 0;
        }
        node *temp = head;

        while(temp != nullptr){
            printf("%d->", temp->data);
            temp = temp->next;
        }
        printf("NULL\n");
        return 0;
    }
    bool isEmpty(){
        if(head == nullptr){
            return true;
        }else return false;
    }
    int getElement(int n){
        struct node *temp = head;

        for(int i = 0; i < n+1; i++){
            if( i == n ) {
                break;
            }
            temp = temp->next;
        }
        return temp->data;
    }
    void merge(linkedList* list2){

        if(head == nullptr){
            head = list2->head;
        }
        else{
            node* temp = head;
            while (temp->next != nullptr) {
                temp = temp->next;
            }
            temp->next = list2->head;
        }
    }
    void measureTime(int n, bool random){
        if(!isEmpty()){
            auto start = std::chrono::high_resolution_clock::now();
            for(int i = 0; i < 100000; i++){
                getElement(n);
            }
            auto finish = std::chrono::high_resolution_clock::now();
            auto elapsed = std::chrono::duration_cast<std::chrono::microseconds>(finish - start);
            if(!random){
                std::cout << "Dla elementu " << n << " zajelo mi to: " << elapsed.count() << std::endl;
            }else{
                std::cout << "Dla elementu losowego" << " zajelo mi to: " << elapsed.count() << std::endl;
            }
        }
    }
    
private:
    node *head = nullptr;
};

int main() {
    auto *list = new linkedList;

    int numberOfElements = 1000;
    for(int i = 0; i < numberOfElements; i++){
        list->push_back(i);
    }

    list->measureTime(0, false);
    list->measureTime(25, false);
    list->measureTime(50, false);
    list->measureTime(100, false);
    list->measureTime(999, false);

    list->measureTime(rand() % numberOfElements, true);

    auto *list2 = new linkedList;
    auto *list3 = new linkedList;

    int j = 10;
    for(int i = 0; i < 10; i++){
        list2->push_back(i);
        list3->push_back(j);
        j++;
    }

    std::cout << "\nLista pierwsza: " << std::endl;
    list2->printList();

    std::cout << "Lista druga: " << std::endl;
    list3->printList();

    list2->merge(list3);

    std::cout << "Listy po polaczeniu: " << std::endl;
    list2->printList();

    return 0;
}

