import java.awt.Color;
import java.awt.Graphics;

/** Klasa tworzaca prostokat */

public class MojProstokat extends MojKsztalt {

    /** Pusty konstruktor klasy MojProstokat */

    public MojProstokat() {}

    /**
     * Konstruktor klasy MojProstokat z parametrami
     * @param x1 x-owa wspolrzedna klikniecia
     * @param y1 y-owa wspolrzedna klikniecia
     * @param x2 x-owa wspolrzedna myszki
     * @param y2 y-owa wspolrzedna myszki
     * @param kolor kolor prostokata
     */

    public MojProstokat(int x1, int y1, int x2, int y2, Color kolor) {
        super(x1, y1, x2, y2, kolor);
    }

    /**
     * Metoda zwracajaca nazwe figury
     * @return nazwa figury
     */

    @Override
    String nazwaFigury(){ return "Prostokat"; }

    /**
     * Metoda sprawdzajaca czy wspolrzedne myszki zawieraja sie w prostokacie
     * @param x x-owa wspolrzedna myszy
     * @param y y-owa wspolrzedna myszy
     * @return True jesli wspolrzedne myszki zawieraja sie w prostokacie, false jesli sie nie zawieraja
     */

    @Override
    boolean czyZawiera(int x, int y) {
        return ( x > getMinX1X2() && x < getMaxX1X2() && y > getMinY1Y2() && y < getMaxY1Y2() );
    }

    /**
     * Metoda zmieniajaca wielkosc prostokata
     * @param amount liczba o ktora figura ma zostac zwiekszona/zmniejszona
     */

    @Override
    public void zmianaWielkosci(int amount) {
        if(getX1() > getX2()) {
            setX1(getX1() + amount);
        }
        if(getX1() < getX2()) {
            setX2(getX2() + amount);
        }
        if(getY1() > getY2()) {
            setY1(getY1() + amount);
        }
        if(getY1() < getY2()) {
            setY2(getY2() + amount);
        }
    }

    /**
     * Metoda rysujaca prostokat
     * @param g grafika
     */

    @Override
    public void draw( Graphics g)  {
        g.setColor( getKolor() ); //Ustawia kolor prostokata
        g.fillRect( getMinX1X2(), getMinY1Y2(), Math.abs(getX1() - getX2()), Math.abs(getY1()-getY2()) ); //Rysuje prostokat

    }
}