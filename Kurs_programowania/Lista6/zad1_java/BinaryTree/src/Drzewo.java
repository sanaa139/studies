/**
 * Klasa drzewa
 * @param <T> typ obiektu
 */

public class Drzewo<T /*! @cond x */extends Comparable<T>/*! @endcond */> {
    /** Zmienna przechowujaca korzen */
    private ElementDrzewa<T> korzen;

    /** Konstruktor klasy Drzewo */
    public Drzewo(){ korzen = null; }

    /** Metoda wywolujaca metode dodajaca element do drzewa
     * @param element element ktory chcemy dodac
     */
    public void insert(T element){
        korzen = ins(element, korzen);
    }

    /** Prywatna metoda dodajaca element do drzewa
     * @param element element ktory chcemy dodac
     * @param korzen korzen
     * @return korzen
     */
    private ElementDrzewa<T> ins(T element, ElementDrzewa<T> korzen){
        //Jesli korzen jest pusty to niech element stanie sie korzeniem
        if(korzen==null) { return new ElementDrzewa<>(element); }

        //Jesli element jest po lewej stronie od korzenia to sprawdzaj dalej gdzie dokladnie umiescic element
        if( element.compareTo(korzen.element) < 0){
            korzen.lewy = ins(element, korzen.lewy);
        }
        //Jesli element jest po prawej stronie od korzenia to sprawdzaj dalej gdzie dokladnie umiescic element
        else if(element.compareTo(korzen.element) > 0){
            korzen.prawy = ins(element, korzen.prawy);
        }
        return korzen;
    }

    /** Metoda wywolujaca metode usuwajaca element
     * @param element element ktory chcemy usunac
     */
    void delete(T element){ korzen = deleteElement(korzen, element);}

    /** Prywatna metoda usuwaja element
     * @param korzen korzen
     * @param element element ktory chcemy usunac
     */
    private ElementDrzewa<T> deleteElement(ElementDrzewa<T> korzen, T element){
        //Jesli drzewo jest puste
        if(korzen == null){ return korzen; }

        //Jesli drzewo nie jest puste to sprawdzaj dalej

        //Jesli element jest po lewej stronie
        if(element.compareTo(korzen.element) < 0){
            korzen.lewy = deleteElement(korzen.lewy, element);
        }
        //Jesli element jest po prawej stronie
        else if(element.compareTo(korzen.element) > 0){
            korzen.prawy = deleteElement(korzen.prawy, element);
        }
        //Jesli natrafimy na element
        else{
            // Korzen z 1 dzieckiem lub 0

            //Jesli lewy element jest pusty to niech prawy element zastapi usuwany element
            if(korzen.lewy == null){
                return korzen.prawy;
            }
            //Jesli prawy element jest pusty to niech lewy element zastapi usuwany element
            else if(korzen.prawy == null){
                return korzen.lewy;
            }

            // Korzen z dwoma dziecmi

            // Bierzemy najmniejszy element w galezi wychodzacej z prawego dziecka usuwanego elementu
            // i przypisujemy usuwanemu elementowi jego wartosc
            korzen.element = najmniejszyElement( korzen.prawy );

            // Usuwamy ten element
            korzen.prawy = deleteElement( korzen.prawy, korzen.element );
        }
        return korzen;
    }

    /**
     * Prywatna metoda zwracajaca najmniejszy element w galezi
     * @param korzen korzen
     * @return najmniejszy element w galezi
     */
    private T najmniejszyElement(ElementDrzewa<T> korzen){
        T najmniejszy = korzen.element;
        while(korzen.lewy != null ){
            najmniejszy = korzen.lewy.element;
            korzen = korzen.lewy;
        }
        return najmniejszy;
    }

    /**
     * Metoda wywolujaca metode przeszukujaca drzewo
     * @param element element ktory chcemy sprawdzic czy znajduje sie w drzewie
     * @return prawda lub falsz
     */
    public boolean search(T element) { return isElem(element,korzen); }

    /**
     * Prywatna metoda przeszukujaca drzewo
     * @param element element ktory chcemy sprawdzic czy znajduje sie w drzewie
     * @param korzen korzen
     * @return prawda lub falsz
     */
    private boolean isElem(T element, ElementDrzewa<T> korzen){
        if(korzen==null) return false; //jesli drzewo jest puste to element nie nalezy do drzewa
        if(element.compareTo(korzen.element)==0) return true; //zwroc prawda jesli element nalezy do drzewa
        if(element.compareTo(korzen.element)<0) //jesli prawda to sprawdz czy element nalezy do lewej strony od korzenia
            return isElem(element, korzen.lewy);
        else
            return isElem(element, korzen.prawy); //jesli nie nalezy do lewej strony to sprawdz po prawej stronie
    }


    /** Metoda wywolujaca metode wyswietlajaca drzewo */
    void print(){
        print_sub("", korzen, false, false);
    }

    /**
     * Prywatna metoda wyswietlajaca drzewo
     * @param prefix zawiera odpowiednie znaki do wyswietlenia drzewa
     * @param korzen korzen
     * @param czyLewy sprawdzenie czy element jest po lewej stronie
     * @param czyMaPraweRodzenstwo sprawdzenie czy ma prawe rodzenstwo
     */
    private void print_sub(String prefix, ElementDrzewa<T> korzen, boolean czyLewy, boolean czyMaPraweRodzenstwo){
        if(korzen != null){
            System.out.print(prefix);
            // element jest mniejszy to wyswietla sie wyzej i ma przed sobą " | "
            //jesli element jest wiekszy to wyswietla sie nizej i ma przed soba " \ "
            System.out.print(czyLewy ? "|--" : "\\--" );
            System.out.println("(" + korzen.element + ")");

            if(czyMaPraweRodzenstwo){
                prefix = prefix + "│   ";
            }else{
                prefix = prefix + "    ";
            }

            print_sub(prefix, korzen.lewy, true,  korzen.prawy != null);
            print_sub(prefix, korzen.prawy, false, false);
        }
    }
}