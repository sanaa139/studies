#include <iostream>
#include <sstream>

using namespace std;

/**
 * Klasa elementu drzewa
 * @param <T> typ obiektu
 */
template<typename T> class ElementDrzewa{

public:
    /** Deklaracja elementu drzewa */
    T element;

    /** Deklaracja lewego dziecka elementu */
    ElementDrzewa<T> *lewy;

    /** Deklaracja prawego dziecka elementu */
    ElementDrzewa<T> *prawy;

    /**
    * Konstruktor klasy ElementDrzewa
    * @param element element
    */
    explicit ElementDrzewa(T element){
        this->element = element;
        lewy = nullptr;
        prawy = nullptr;
    }
};

/**
 * Klasa drzewa
 * @param <T> typ obiektu
 */

template<typename T> class Drzewo {
    /** Deklaracja zmiennej przechowujacej korzen */
    ElementDrzewa<T> *korzen;

    /** Konstruktor klasy Drzewo */
public: Drzewo(){ korzen = nullptr; }

    /** Metoda wywolujaca metode dodajaca element do drzewa
     * @param element element ktory chcemy dodac
     */
    void insert(T element){
        korzen = ins(element, korzen);
    }

    /** Metoda wywolujaca metode usuwajaca element
     * @param element element ktory chcemy usunac
     */
    void deleteEle (T element){
        korzen = deleteElement(korzen, element);
    }

    /**
     * Metoda wywolujaca metode przeszukujaca drzewo
     * @param element element ktory chcemy sprawdzic czy znajduje sie w drzewie
     * @return prawda lub falsz
     */
    bool search(T element){ return isElem(element,korzen); }

    /** Prywatna metoda dodajaca element do drzewa
     * @param element element ktory chcemy dodac
     * @param korzen korzen
     * @return korzen
     */
    ElementDrzewa<T> *ins(T element, ElementDrzewa<T> *korzen ){
        //Jesli korzen jest pusty to niech element stanie sie korzeniem
        if(korzen == nullptr){ return new ElementDrzewa<T>(element); }

        //Jesli prawda to sprawdz po lewej stronie korzenia i sprawdz jeszcze raz gdzie umiescic element
        if(element < korzen->element){
            korzen->lewy = ins(element, korzen->lewy);
        }
            //Jesli prawda to sprawdz po prawej stronie korzenia i sprawdz jeszcze raz gdzie umiescic element
        else if(element > korzen->element){
            korzen->prawy = ins(element, korzen->prawy);
        }

        return korzen;
    }

    /** Metoda wywolujaca metode wyswietlajaca drzewo */
    void print(){
        print_sub("", korzen, false, false);
    };

    /**
     * Prywatna metoda wyswietlajaca drzewo
     * @param prefix zawiera odpowiednie znaki do wyswietlenia drzewa
     * @param korzen korzen
     * @param czyLewy sprawdzenie czy element jest po lewej stronie
     * @param czyMaPraweRodzenstwo sprawdzenie czy ma prawe rodzenstwo
     */
private: void print_sub(string prefix, ElementDrzewa<T> *korzen, bool czyLewy,  bool czyMaPraweRodzenstwo){

        if(korzen != nullptr){
            cout<<prefix;

            //jesli element jest mniejszy to wyswietla sie wyzej i ma przed sob¹ " | "
            //jesli element jest wiekszy to wyswietla sie nizej i ma przed soba " \ "
            cout << (czyLewy ? "|--" : "\\--" );
            cout << "(" << korzen->element << ")" << endl;

            if(czyMaPraweRodzenstwo){
                prefix = prefix + "|   ";
            }else{
                prefix = prefix + "    ";
            }

            print_sub(prefix, korzen->lewy, true, korzen->prawy != nullptr);
            print_sub(prefix, korzen->prawy, false, false);
        }
    }


    /** Prywatna metoda usuwaja element
     * @param korzen korzen
     * @param element element ktory chcemy usunac
     */
private: ElementDrzewa<T> *deleteElement(ElementDrzewa<T> *korzen, T element){
        //Jesli drzewo jest puste
        if(!korzen){ return korzen; }

        //Jesli drzewo nie jest puste to sprawdzaj dalej

        //Jesli jest po lewej stronie
        if(element < korzen->element){
            korzen->lewy = deleteElement(korzen->lewy, element);
        }
            //Jesli jest po prawej stronie
        else if(element > korzen->element){
            korzen->prawy = deleteElement(korzen->prawy, element);
        }
            //Jesli natrafimy na element
        else{
            // Korzen z 1 dzieckiem lub 0

            //Jesli lewy element jest pusty to niech prawy element zastapi usuwany element
            if(korzen->lewy == nullptr){
                return korzen->prawy;
            }
                //Jesli prawy element jest pusty to niech lewy element zastapi usuwany element
            else if(korzen->prawy == nullptr){
                return korzen->lewy;
            }

            // Korzen z dwoma dziecmi

            // Bierzemy najmniejszy element w galezi wychodzacej z prawego dziecka usuwanego elementu
            // i przypisujemy usuwanemu elementowi jego wartosc
            korzen->element = najmniejszyElement(korzen->prawy);

            // Usuwamy ten element
            korzen->prawy = deleteElement(korzen->prawy, korzen->element);
        }
        return korzen;
    }

    /**
     * Prywatna metoda zwracajaca najmniejszy element w galezi
     * @param korzen korzen
     * @return najmniejszy element w galezi
     */
private: T najmniejszyElement(ElementDrzewa<T> *korzen){
        T najmniejszy = korzen->element;
        while(korzen->lewy != nullptr){
            najmniejszy = korzen->lewy->element;
            korzen = korzen->lewy;
        }
        return najmniejszy;
    }

    /**
     * Prywatna metoda przeszukujaca drzewo
     * @param element element ktory chcemy sprawdzic czy znajduje sie w drzewie
     * @param korzen korzen
     * @return prawda lub falsz
     */
private: bool isElem(T element, ElementDrzewa<T> *korzen){
        if(korzen == nullptr) return false; //jesli drzewo jest puste to element nie nalezy do drzewa
        if(element == korzen->element) return true; //zwroc prawda jesli element nalezy do drzewa
        if(element < korzen->element) //jesli prawda to sprawdz czy element nalezy do lewej strony od korzenia
            return isElem(element, korzen->lewy);
        else
            return isElem(element, korzen->prawy); //jesli nie nalezy do lewej strony to sprawdz po prawej stronie
    }

};


int main(){
    int wybor;
    cout<<"Wybierz opcje wpisujac odpowiednia cyfre:"<<endl;
    cout<<"1. Utworz drzewo dla napisow"<<endl;
    cout<<"2. Utwor drzewo dla liczb calkowitych"<<endl;
    cout<<"3. Utworz drzewo dla liczb niecalkowitych"<<endl;
    cout<<"Wpisz cokolwiek innego zeby wyjsc"<<endl;
    cin>>wybor;
    int wybor2;
    cout<<endl;

    if(wybor == 1){
        Drzewo<string> s;
        cout << "Wpisz dane oddzielone spacjami jakie beda w drzewie:" << endl;
        string linia;
        cin.ignore();
        getline(cin, linia);
        cout<<endl;

        string strs;

        stringstream ssin(linia);
        while(ssin.good()){
            ssin >> strs;
            try{
                if(strs.empty()){
                    cout<<"NIE PODANO ELEMENTOW";
                    exit(0);
                }
                size_t found = strs.find_first_not_of("abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ");
                if(found == std::string::npos){
                    s.insert(strs);
                }
            }catch(exception & a){}
        }
        strs = "";

        s.print();
        cout<<endl;

        while(true){
            cout << "Wybierz opcje:" << endl;
            cout << "1. Dodaj element" << endl;
            cout << "2. Usun element" << endl;
            cout << "3. Sprawdz czy element znajduje sie w drzewie" << endl;
            cout << "Wpisz cokolwiek innego zeby wyjsc" << endl;
            cin >> wybor2;
            if(wybor2 == 1){
                cout << "Wpisz elementy odzielone spacjami jakie chcesz dodac" << endl;
                cin.ignore();
                getline(cin, linia);
                cout<<endl;

                if(!linia.empty()){
                    stringstream doDodania1(linia);
                    while(doDodania1.good()){
                        doDodania1 >> strs;
                        try{
                            size_t found = strs.find_first_not_of("abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ");
                            if(found==std::string::npos){
                                s.insert(strs);
                            }
                        }catch(exception &a){}
                    }
                }
                strs = "";

                s.print();
                cout<<endl;
            }
            else if(wybor2 == 2){
                cout << "Wpisz elementy odzielone spacjami jakie chcesz usunac" << endl;
                cin.ignore();
                getline(cin, linia);
                cout<<endl;

                if(!linia.empty()){
                    stringstream doUsuniecia1(linia);
                    while(doUsuniecia1.good()){
                        doUsuniecia1 >> strs;
                        try{
                            if(!strs.empty()){
                                size_t found = strs.find_first_not_of("abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ");
                                //if (found==std::string::npos){
                                    s.deleteEle(strs);
                                //}
                            }
                        }catch (exception &a) {}
                    }
                }
                strs = "";

                s.print();
                cout<<endl;
            }
            else if( wybor2 == 3 ) {
                cout << "Wpisz elementy oddzielone spacjami jakie chcesz sprawdzic czy sa w drzewie" << endl;
                cin.ignore();
                getline(cin, linia);
                cout<<endl;

                if(!linia.empty()){
                    stringstream doSprawdzenia1(linia);
                    while(doSprawdzenia1.good()){
                        doSprawdzenia1 >> strs;
                        try{
                            if(!strs.empty()){
                                size_t found = strs.find_first_not_of("abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ");
                                if(found==std::string::npos){
                                    cout << strs << " - ";
                                    if(s.search(strs)){
                                        cout << " jest w drzewie" << endl;
                                    }else{
                                        cout << " nie ma w drzewie" << endl;
                                    }
                                }
                            }
                        }catch(exception &a){}
                    }
                }
                strs = "";
                cout<<endl;
            }
            else { exit(0);}
        }
    }
    else if(wybor == 2){
        Drzewo<int> i;
        cout<<"Wpisz dane oddzielone spacjami jakie beda w drzewie:"<<endl;
        string linia;
        cin.ignore();
        getline(cin, linia);
        cout<<endl;

        string strs;

        stringstream ssin(linia);
        while(ssin.good()){
            ssin >> strs;
            try{
                if(strs.empty()){
                    cout<<"NIE PODANO ELEMENTOW";
                    exit(0);
                }
                size_t found = strs.find_first_not_of("-0123456789");
                if(found==std::string::npos){
                    i.insert(stoi(strs));
                }
            }catch(exception &a){}
        }
        strs = "";

        i.print();
        cout<<endl;

        while(true) {
            cout << "Wybierz opcje:" << endl;
            cout << "1. Dodaj element" << endl;
            cout << "2. Usun element" << endl;
            cout << "3. Sprawdz czy element znajduje sie w drzewie" << endl;
            cout << "Wpisz cokolwiek innego zeby wyjsc" << endl;
            cin >> wybor2;
            if(wybor2 == 1){
                cout << "Wpisz elementy odzielone spacjami jakie chcesz dodac" << endl;
                cin.ignore();
                getline(cin, linia);
                cout<<endl;

                if(!linia.empty()){
                    stringstream doDodania2(linia);
                    while (doDodania2.good()) {
                        doDodania2 >> strs;
                        try{
                            size_t found = strs.find_first_not_of("-0123456789");
                            if(found==std::string::npos){
                                i.insert(stoi(strs));
                            }
                        }catch(exception &a){}
                    }
                }
                strs = "";

                i.print();
                cout<<endl;
            }
            else if(wybor2 == 2){
                cout << "Wpisz elementy odzielone spacjami jakie chcesz usunac" << endl;
                cin.ignore();
                getline(cin, linia);
                cout<<endl;

                if(!(linia.empty())){

                    stringstream doUsuniecia2(linia);
                    while(doUsuniecia2.good()){
                        doUsuniecia2 >> strs;
                        try{
                            size_t found = strs.find_first_not_of("-0123456789");
                            if(found==std::string::npos){
                                i.deleteEle(stoi(strs));
                            }
                        }catch(exception &a){}
                    }
                }

                strs = "";

                i.print();
                cout<<endl;
            }
            else if(wybor2 == 3){
                cout << "Wpisz elementy oddzielone spacjami jakie chcesz sprawdzic czy sa w drzewie:" << endl;
                cin.ignore();
                getline(cin, linia);
                cout<<endl;

                if (!linia.empty()){
                    stringstream doSprawdzenia2(linia);
                    int temp;
                    while(doSprawdzenia2.good()){
                        doSprawdzenia2 >> strs;
                        try{
                            size_t found = strs.find_first_not_of("-0123456789");
                            if(found==std::string::npos){
                                temp = stoi(strs);
                                cout << temp << " - ";
                                if(i.search(temp)){
                                    cout << " jest w drzewie"<<endl;
                                }else{
                                    cout << " nie ma w drzewie"<<endl;
                                }
                            }

                        }catch(exception &a) {}
                    }
                }
                strs = "";
                cout<<endl;
            }
            else{ exit(0); }
        }
    }
    else if(wybor == 3){
        Drzewo<double> d;
        cout<<"Wpisz dane oddzielone spacjami jakie beda w drzewie:"<<endl;
        string linia;
        cin.ignore();
        getline(cin, linia);
        cout<<endl;

        string strs;

        stringstream ssin(linia);
        while(ssin.good()){
            ssin >> strs;
            try{
                if(strs.empty()){
                    cout<<"NIE PODANO ELEMENTOW";
                    exit(0);
                }
                size_t found = strs.find_first_not_of("-0123456789.");
                if(found==std::string::npos){
                    d.insert(stod(strs));
                }
            }catch(exception &a){}
        }
        strs = "";

        d.print();
        cout<<endl;

        while(true){
            cout<<"Wybierz opcje:"<<endl;
            cout<<"1. Dodaj element"<<endl;
            cout<<"2. Usun element"<<endl;
            cout<<"3. Sprawdz czy element znajduje sie w drzewie"<<endl;
            cout<<"Wpisz cokolwiek innego zeby wyjsc"<<endl;
            cin>>wybor2;
            if(wybor2 == 1){
                cout<<"Wpisz elementy odzielone spacjami jakie chcesz dodac"<<endl;
                cin.ignore();
                getline(cin, linia);
                cout<<endl;

                if (!linia.empty()){
                    stringstream doDodania3(linia);
                    while(doDodania3.good()){
                        doDodania3 >> strs;
                        try{
                            size_t found = strs.find_first_not_of("-0123456789.");
                            if(found==std::string::npos){
                                d.insert(stod(strs));
                            }
                        }catch(exception &a){}
                    }
                }
                strs = "";
                d.print();
                cout<<endl;
            }
            else if(wybor2 == 2){
                cout<<"Wpisz elementy odzielone spacjami jakie chcesz usunac"<<endl;
                cin.ignore();
                getline(cin, linia);
                cout<<endl;

                if(!linia.empty()){
                    stringstream doUsuniecia3(linia);
                    while(doUsuniecia3.good()){
                        doUsuniecia3 >> strs;
                        try{
                            size_t found = strs.find_first_not_of("-0123456789.");
                            if(found==std::string::npos){
                                d.deleteEle(stod(strs));
                            }
                        }catch(exception &a) {}
                    }
                }
                strs = "";

                d.print();
                cout<<endl;
            }
            else if(wybor2 == 3){
                cout<<"Wpisz elementy oddzielone spacjami jakie chcesz sprawdzic czy sa w drzewie"<<endl;
                cin.ignore();
                getline(cin, linia);
                cout<<endl;

                if(!linia.empty()){
                    stringstream doSprawdzenia3(linia);
                    double temp;
                    while(doSprawdzenia3.good()){
                        doSprawdzenia3 >> strs;
                        try{
                            size_t found = strs.find_first_not_of("-0123456789.");
                            if(found==std::string::npos){
                                temp = stod(strs);
                                cout<<temp<<endl;
                                cout<<temp<<" - ";
                                if(d.search(temp)){
                                    cout<<" jest w drzewie"<<endl;
                                }else{
                                    cout<<" nie ma w drzewie"<<endl;
                                }
                            }
                        }catch(exception &a){}
                    }
                }
                strs = "";
                cout<<endl;
            }
            else { exit(0); }
        }
    }
    else exit(0);
}