#include <iostream>
#include <chrono>

struct node{
    int data;
    node* next;
    node* prev;
};

class circularDoublyLinkedList{
public:
    circularDoublyLinkedList()= default;
    ~circularDoublyLinkedList();

    void push_back(int value){
        node* newNode = new node;
        newNode->data = value;
        newNode->next = head;
        newNode->prev = head;

        if(head == nullptr){
            head = newNode;
            newNode->next = head;
            newNode->prev = head;
        }else{
            node *lastNode = head;
            node *tempNode = head;
            while(lastNode->next != head){
                lastNode = lastNode->next;
            }
            lastNode->next = newNode;
            newNode->prev = lastNode;
            newNode->next = head;
            tempNode->prev= newNode;
        }
    }
    int printList(){
        if(head == nullptr){
            printf("Pusta lista\n");
            return 0;
        }

        struct node *temp = head;

        while(temp->next != head){
            printf("%d->", temp->data);
            temp = temp->next;
        }
        if(temp->next == head){
            printf("%d->", temp->data);
        }
        printf("...\n");
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
            if(i == n) {
                break;
            }
            temp = temp->next;
        }
        return temp->data;
    }
    void merge(circularDoublyLinkedList* list2){
        node* M;
        node* M2;
        node* L;
        node* L2;

        if(head == nullptr){
            head = list2->head;
        }else if(list2->head != nullptr){
            M = head;
            M2 = list2->head;
            L = head->prev;
            L2 = list2->head->prev;

            L->next = M2;
            M2->prev = L;
            L2->next = M;
            M->prev = L2;
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
            if(!random) {
                std::cout << "Dla elementu " << n << " zajelo mi to: " << elapsed.count() << std::endl;
            }else{
                std::cout << "Dla elementu losowego" << " zajelo mi to: " << elapsed.count() << std::endl;
            }
        }
    }
    
private:
    node *head = nullptr;
};

int main(){
    auto* list = new circularDoublyLinkedList;

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

    auto* list2 = new circularDoublyLinkedList;
    auto* list3 = new circularDoublyLinkedList;

    int j = 10;
    for(int i = 0; i < 10; i++){
        list2->push_back(i);
        list3->push_back(j);
        j++;
    }

    std::cout << "\nLista pierwsza: " << std::endl;
    list2->printList();

    std::cout << "Lista druga: " << std::endl;
    list3-> printList();

    list2->merge(list3);

    std::cout << "Listy po polaczeniu: " << std::endl;
    list2->printList();

    return 0;
}

