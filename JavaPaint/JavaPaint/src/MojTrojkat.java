import java.awt.Color;
import java.awt.Graphics;

/** Klasa tworzaca trojkat */

public class MojTrojkat extends MojKsztalt {

    /** Pusty konstruktor klasy MojTrojkat */

    public MojTrojkat() {}

    /**
     * Konstruktor klasy MojTrojkat z parametrami
     * @param x1 x-owa wspolrzedna klikniecia
     * @param y1 y-owa wspolrzedna klikniecia
     * @param x2 x-owa wspolrzedna myszki
     * @param y2 y-owa wspolrzedna myszki
     * @param kolor kolor trojkata
     */

    public MojTrojkat( int x1, int y1, int x2, int y2, Color kolor ) {
        super(x1, y1, x2, y2, kolor);
    }

    /**
     * Metoda zwracajaca nazwe figury
     * @return nazwa figury
     */

    @Override
    String nazwaFigury(){ return "Trojkat"; }

    /**
     * Metoda sprawdzajaca czy wspolrzedne myszki zawieraja sie w trojkacie
     * @param x x-owa wspolrzedna myszy
     * @param y y-owa wspolrzedna myszy
     * @return True jesli wspolrzedne myszki zawieraja sie w trojkacie, false jesli sie nie zawieraja
     */

    @Override
    public boolean czyZawiera(int x, int y) {
        return (x > getMinX1X2() && x < getMaxX1X2() && y > getMinY1Y2() && y < getMaxY1Y2());
    }

    /**
     * Metoda zmieniajaca wielkosc trojkata
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
     * Metoda rysujaca trojkat
     * @param g grafika
     */

    @Override
    public void draw( Graphics g ) {

        //Wartosci x-owe wierzcholkow, odpowiednio: wierzcholek dolny, wierzcholek dolny, wierzcholek gorny
        //znajdujacy sie w polowie dlugosci podstawy
        int[] wartosciX = { getMaxX1X2(), getMinX1X2(), ( getMaxX1X2() + getMinX1X2() ) / 2 };

        //Wartosci y-owe wierzcholkow, odpowiednio: wierzcholek dolny, wierzcholek dolny, wierzcholek gorny
        int[] wartosciY = { getMaxY1Y2(), getMaxY1Y2(), getMaxY1Y2() - (int)((getMaxX1X2() - getMinX1X2()) * Math.sqrt(3))/2 };

        g.setColor( getKolor() ); //Ustawia kolor figury
        g.fillPolygon( wartosciX, wartosciY, 3 ); //Rysuje wypelniony trojkat

    }
}