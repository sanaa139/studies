/**
 * Klasa elementu drzewa
 * @param <T> typ obiektu
 */
public class ElementDrzewa<T /*! @cond x */extends Comparable<T>/*! @endcond */> {
    /** Deklaracja elementu drzewa */
    public T element;

    /** Lewe dziecko elementu */
    public ElementDrzewa<T> lewy;

    /** Prawe dziecko elementu */
    public ElementDrzewa<T> prawy;

    /**
     * Konstruktor klasy ElementDrzewa
     * @param element element
     */
    public ElementDrzewa(T element){
        this.element = element;
        lewy = null;
        prawy = null;
    }
}