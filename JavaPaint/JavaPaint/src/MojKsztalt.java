import java.awt.Color;
import java.awt.Graphics;

/**
 * Abstrakcyjna klasa figur
 */

abstract class MojKsztalt
{
    /** Deklaracja wspolrzednych figury */

    private int x1,y1,x2,y2; //wspolrzedne figury

    /** Deklaracja koloru figury */

    private Color kolor; //kolor figury

    /**
     * Pusty konstruktor klasy MojKsztalt
     */

    public MojKsztalt() {}

    /**
     * Konstruktor klasy MojKszalt z parametrami
     * @param x1 x-owa wspolrzedna klikniecia
     * @param y1 y-owa wspolrzedna klikniecia
     * @param x2 x-owa wspolrzedna myszki
     * @param y2 y-owa wspolrzedna myszki
     * @param kolor kolor figury
     */

    public MojKsztalt(int x1, int y1, int x2, int y2, Color kolor) {
        this.x1=x1;
        this.y1=y1;
        this.x2=x2;
        this.y2=y2;
        this.kolor=kolor;
    }

    /**
     * Abstrakcyjna metoda do zwracania nazwy figury
     * @return nazwa figury
     */
    abstract String nazwaFigury();

    /**
     * Metoda przypisujaca wartosc x-owej wspolrzednej miejsca zaczecia rysowania figury
     * @param x1 x-owa wspolrzedna miejsca zaczecia rysowania figury
     */

    public void setX1(int x1) { this.x1=x1; }

    /**
     * Metoda przypisujaca wartosc y-owej wspolrzednej miejsca zaczecia rysowania figury
     * @param y1 y-owa wspolrzedna miejsca zaczecia rysowania figury
     */

    public void setY1(int y1) { this.y1=y1; }

    /**
     * Metoda przypisujaca wartosc x-owej wspolrzednej miejsca gdzie znajduje sie myszka
     * @param x2 x-owa wspolrzedna miejsca znajdowania sie myszki
     */

    public void setX2(int x2) { this.x2=x2; }

    /**
     * Metoda przypisujaca wartosc y-owej wspolrzednej miejsca gdzie znajduje sie myszka
     * @param y2 y-owa wspolrzedna miejsca znajdowania sie myszki
     */

    public void setY2(int y2) { this.y2=y2; }

    /**
     * Metoda przypisujaca figurze kolor
     * @param kolor kolor figury
     */

    public void setKolor(Color kolor) { this.kolor=kolor; }

    /**
     * Metoda zwracajaca x-owa spolrzedna miejsca zaczecia rysowania figury
     * @return x-owa wspolrzedna miejsca zaczecia rysowania figury
     */

    public int getX1() { return x1; }

    /**
     * Metoda zwracajaca y-owa spolrzedna miejsca zaczecia rysowania figury
     * @return y-owa wspolrzedna miejsca zaczecia rysowania figury
     */

    public int getY1() { return y1; }

    /**
     * Metoda zwracajaca x-owa spolrzedna myszki
     * @return x-owa wspolrzedna myszki
     */

    public int getX2() { return x2; }

    /**
     * Metoda zwracajaca y-owa wspolrzedna myszki
     * @return y-owa wspolrzedna myszki
     */

    public int getY2() { return y2; }

    /**
     * Metoda zwracajaca kolor figury
     * @return kolor figury
     */

    public Color getKolor() { return kolor; }

    /**
     * Metoda zwracajaca maximum z x-owej wspolrzednej zaczecia rysowania figury i x-owej wspolrzednej myszki
     * @return maximum z x-owej wspolrzednej zaczecia rysowania figury i x-owej wspolrzednej myszki
     */

    public int getMaxX1X2() { return Math.max(getX1(), getX2()); }

    /**
     * Metoda zwracajaca minimum z x-owej wspolrzednej zaczecia rysowania figury i x-owej wspolrzednej myszki
     * @return minimum z x-owej wspolrzednej zaczecia rysowania figury i x-owej wspolrzednej myszki
     */

    public int getMinX1X2() { return Math.min(getX1(), getX2()); }

    /**
     * Metoda zwracajaca maximum z y-owej wspolrzednej zaczecia rysowania figury i y-owej wspolrzednej myszki
     * @return maximum z y-owej wspolrzednej zaczecia rysowania figury i y-owej wspolrzednej myszki
     */

    public int getMaxY1Y2() { return Math.max(getY1(), getY2()); }

    /**
     * Metoda zwracajaca minimum z y-owej wspolrzednej zaczecia rysowania figury i y-owej wspolrzednej myszki
     * @return minimum z y-owej wspolrzednej zaczecia rysowania figury i y-owej wspolrzednej myszki
     */

    public int getMinY1Y2() { return Math.min(getY1(), getY2()); }

    /**
     * Metoda zmieniajace wspolrzedne x-owe obydwu wierzcholkow
     * @param x liczba o ktora wspolrzedne x-owe obydwu wierzcholkow maja byc zmienione
     */

    public void addX(int x) {
        x1 += x;
        x2 += x;
    }

    /**
     * Metoda zmieniajaca wspolrzedne y-owe obydwu wierzcholkow
     * @param y liczba o ktora wspolrzedne y-owe obydwu wiercholkow maja byc zmionione
     */

    public void addY(int y) {
        y1 += y;
        y2 += y;
    }

    /**
     * Metoda abstrakcyjna do sprawdzenia czy mysz znajduje sie w figurze
     * @param x x-owa wspolrzedna myszy
     * @param y y-owa wspolrzedna myszy
     * @return True jesli wspolrzedne myszki zawieraja sie w figurze, false jesli sie nie zawieraja
     */

    abstract boolean czyZawiera(int x, int y);

    /**
     * Metoda abstrakcyjna zmieniajaca wielkosc figury
     * @param amount liczba o ktora figura ma zostac zwiekszona/zmniejszona
     */

    abstract public void zmianaWielkosci(int amount);

    /**
     * Metoda abstrakcyjna rysujaca figure
     * @param g grafika
     */

    abstract public void draw( Graphics g );

}