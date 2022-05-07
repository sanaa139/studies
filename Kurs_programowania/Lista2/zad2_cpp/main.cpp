#include <iostream>
#include <cmath>
#include <string>

using namespace std;

class Figura{
public:
    virtual double obliczPole() = 0;
    virtual double obliczObwod() = 0;
};

class Czworokat :public Figura{
};

class Kolo :public Figura{
private:
    int promien;
public:
    explicit Kolo(int promien){
        this->promien = promien;
    }

    double obliczObwod() override{
        return 2 * M_PI * promien;
    }

    double obliczPole() override{
        return M_PI * promien * promien;
    }
};

class Pieciokat :public Figura{
private:
    int bok;
public:
    explicit Pieciokat(int bok){
        this->bok = bok;
    }

    double obliczObwod() override{
        return 5 * bok;
    }

    double obliczPole() override{
        return ((sqrt(25 + 10 * sqrt(5))) * bok * bok) / 4;
    }
};

class Szesciokat :public Figura{
private:
    int bok;
public:
    explicit Szesciokat(int bok){
        this->bok = bok;
    }

    double obliczObwod() override{
        return 6 * bok;
    }

    double obliczPole() override{
        return (3 * sqrt(3) * bok * bok) / 2;
    }
};

class Kwadrat :public Czworokat{
private:
    int bok;
public:
    explicit Kwadrat (int bok){
        this->bok = bok;
    }

    double obliczObwod() override{
        return 4 * bok;
    }

    double obliczPole() override{
        return bok * bok;
    }
};

class Prostokat :public Czworokat{
private:
    int bok1, bok2, bok3, bok4;
public:
    Prostokat(int bok1, int bok2, int bok3, int bok4){
        this->bok1 = bok1;
        this->bok2 = bok2;
        this->bok3 = bok3;
        this->bok4 = bok4;
    }

    double obliczObwod() override{
        return bok1 + bok2 + bok3 + bok4;
    }

    double obliczPole() override{
        if( bok1 == bok2 || bok1 == bok4){
            return bok1 * bok3;
        }
        else{
            return bok1 * bok2;
        }
    }
};

class Romb :public Czworokat{
private:
    int bok, kat;
public:
    Romb(int bok, int kat){
        this->bok = bok;
        this->kat = kat;
    }

    double obliczObwod() override{
        return 4 * bok;
    }

    double obliczPole() override{
        return bok * bok * sin(kat * M_PI / 180);
    }
};


int main(int argc, char* args[]){
    if(argc == 1){
        cout<<"Nie podano argumentow";
        exit(0);
    }

    string obiekty = args[1];
    Figura* figury[obiekty.length()];
    string nazwy[obiekty.length()];

    int nrFig = 0;
    int j = 2;
    int p;
    for(int i = 0; i < obiekty.length(); i++){

        char figura = obiekty[i];

        switch(figura){
            case 'o': {
                try {
                    p = stoi(args[j]);
                    if(p > 0){
                        nazwy[nrFig] = "--KOLO--";
                        figury[nrFig] = new Kolo(p);
                        nrFig++;
                    }
                    else{ cout << "Nie mozna utworzyc kola poniewaz podano zly parametr" << endl; }
                } catch(invalid_argument &ex){ cout << "Nie mozna utworzyc kola poniewaz podano zly parametr" << endl; }
                catch(out_of_range &ex){ cout << "Nie mozna utworzyc czworokata poniewaz nie podano parametru" << endl; }
                j++;
            }break;

            case 'c': {
                int dane[5];
                int h = j;
                try{
                    for(int k = 0; k <= 4; k++){
                        dane[k] = stoi(args[h]);
                        h++;
                    }
                    if(dane[0] > 0 && dane[1] > 0 && dane[2] > 0 && dane[3] > 0 && dane[4] > 0){
                        if(dane[0] == dane[1] && dane[0] == dane[2] && dane[0] == dane[3]){
                            if(dane[4] == 90){
                                nazwy[nrFig] = "--KWADRAT--";
                                figury[nrFig] = new Kwadrat(dane[0]);
                                nrFig++;
                            }else if(dane[4] > 90 && dane[4] < 180){
                                nazwy[nrFig] = "--ROMB--";
                                figury[nrFig] = new Romb(dane[0], 180 - dane[4]);
                                nrFig++;
                            }else{
                                nazwy[nrFig] = "--ROMB--";
                                figury[nrFig] = new Romb(dane[0], dane[4]);
                                nrFig++;
                            }
                        } else if(((dane[0] == dane[1] && dane[2] == dane[3]) ||
                                    (dane[0] == dane[2] && dane[1] == dane[3]) ||
                                    (dane[0] == dane[3] && dane[1] == dane[2])) && dane[4] == 90){
                            nazwy[nrFig] = "--PROSTOKAT--";
                            figury[nrFig] = new Prostokat(dane[0], dane[1], dane[2], dane[3]);
                            nrFig++;
                        }
                    }
                    else{ cout << "Nie mozna utworzyc czworokata poniewaz podano zly parametr" << endl; }
                } catch(invalid_argument &ex){ cout << "Nie mozna utworzyc czworokata poniewaz podano zly parametr" << endl;
                } catch(out_of_range &ex){ cout << "Nie mozna utworzyc czworokata poniewaz zostala podana zbyt mala ilosc parametrow" << endl;}
                j = j + 5;
            } break;

            case 'p':{
                try{
                    p = stoi(args[j]);
                    if(p > 0){
                        nazwy[nrFig] = "--PIECIOKAT--";
                        figury[nrFig] = new Pieciokat(p);
                        nrFig++;
                    }
                    else{ cout << "Nie mozna utworzyc pieciokata poniewaz podano zly parametr" << endl;}
                } catch(invalid_argument &ex){ cout << "Nie mozna utworzyc pieciokata poniewaz podano zly parametr" << endl;
                }catch(out_of_range &ex){ cout << "Nie mozna utworzyc pieciokata poniewaz nie podano parametru" << endl; }
                j++;
            } break;

            case 's':{
                try{
                    p = stoi(args[j]);
                    if(p > 0){
                        nazwy[nrFig] = "--SZESCIOKAT--";
                        figury[nrFig] = new Szesciokat(p);
                        nrFig++;
                    }
                    else { cout << "Nie mozna utworzyc szesciokata poniewaz podano zly parametr" << endl; }
                }
                catch(invalid_argument &ex){ cout << "Nie mozna utworzyc szesciokata poniewaz podano zly parametr" << endl; }
                catch(out_of_range &ex){ cout << "Nie mozna utworzyc szesciokata poniewaz nie podano parametru" << endl; }
                j++;
            }break;

            default:{
                cout << "Nie mozna utworzyc figury o znaku: "<< obiekty[i] << endl;
            }
        }
    }

    for(int m = 0; m < nrFig; m++){
        cout << nazwy[m] << endl;
        cout << "Obwod: " << figury[m]->obliczObwod() << " , pole: "<< figury[m]->obliczPole() << "\n\n";
    }
}