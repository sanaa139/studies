import javax.swing.*;
import java.awt.*;
import java.awt.event.*;
import java.util.ArrayList;

/**
 * Klasa tworzaca przestrzen do rysowania
 */

public class MojPanel extends JPanel{

    /** ArrayLista do przechowywania figur */
    ArrayList<MojKsztalt> figury = new ArrayList<>();

    /** popup menu do zmieniania koloru figury */
    private JPopupMenu popupMenu;

    /** wspolrzedne gdzie ma sie popup menu pojawic */
    private int popupX, popupY;

    /** Zmienna liczbowa przechowujaca obecny typ figury */
    private int obecnyTypFigury; //1 dla kola, 2 dla prostokata, 3 dla trojkata

    /** Zmienna przechowujaca obecna figure */
    private MojKsztalt obecnyTypFiguryObiekt;

    /** Zmienna przechowujaca obecny kolor figury */
    private Color obecnyKolor;

    /**
     * Konstruktor klasy MojPanel
     */
    public MojPanel() {
        //Tlo panelu jest biale
        setBackground(Color.WHITE);

        obecnyTypFigury = 0;
        obecnyTypFiguryObiekt = null;
        obecnyKolor = Color.BLACK;

        //Metoda odpowiedzialna za wywolanie popup menu
        pMenu();

        //Tworzenie obiektu odpowiedzialnego za obsluge myszy
        DzialanieMyszy dzialanieMyszy = new DzialanieMyszy();

        //Wywolanie metod odpowiedzialnych za dzialanie myszy
        addMouseMotionListener(dzialanieMyszy); //poruszanie mysza
        addMouseListener(dzialanieMyszy); //klikniecie mysza

        // Wywolanie metody odpowiedzialnej za dodanie zdarzen poruszania scrollem
        addMouseWheelListener(new DzialanieKolkaMyszy());
    }

    /**
     * Metoda tworzaca popup menu
     */

    private void pMenu() {
        popupMenu = new JPopupMenu();

        JMenuItem zmienKolor = new JMenuItem("Zmien kolor");
        zmienKolor.addActionListener(this::wyborKoloru);

        popupMenu.add(zmienKolor);

        addMouseListener(new DzialanieMyszyPopup());
    }

    /**
     * Metoda tworzaca colorChooser, gdzie mozna wybrac nowy kolor figury
     * @param e przechwycenie klikniecia mysza
     */

    private void wyborKoloru(ActionEvent e) {
            obecnyKolor = JColorChooser.showDialog(null, "Wybierz kolor", Color.BLACK);

            for (int i = figury.size()-1; i >= 0; i--) {
                if (figury.get(i).czyZawiera(popupX, popupY)) {
                    figury.get(i).setKolor(obecnyKolor);
                    repaint();
                    break;
                }
            }
            //Przypisanie na nowo koloru czarnego jako domyslnego koloru figury
            obecnyKolor = Color.BLACK;
    }

    /**
     * Metoda rysujaca figury
     * @param g grafika
     */
    public void paintComponent( Graphics g )
    {
        super.paintComponent( g );

        //Rysowanie figur
        for ( int i = 0; i <= figury.size()-1; i++ )
            figury.get(i).draw(g);

        if (obecnyTypFiguryObiekt != null) { obecnyTypFiguryObiekt.draw(g); } //Rysowanie obecnej figury jesli nie jest null
        repaint();
    }

    /** Metoda ustawiajaca typ figury na 0, 1 lub 2 */

    public void setObecnyTypFigury(int typ) {
        obecnyTypFigury = typ;
    }

    /**
     * Metoda czyszczaca panel z figurami
     */

    public void wyczyscPanel(){
        figury.clear();
        repaint();
    }

    /**
     * Prywatna klasa obslugujaca popup menu
     */

    private class DzialanieMyszyPopup extends MouseAdapter {

        /**
         * Metoda wywolujaca popup menu po kliknieciu w figure
         * @param e przechwycenie klikniecia
         */
        public void mouseReleased(MouseEvent e) {

                //Sprawdzenie czy wspolrzedne klikniecia zawiera ktoras z figur
                //Jesli tak to pokaz popup menu, jesli nie to nie pokazuj popup menu
                popupX = e.getX();
                popupY = e.getY();
                for (int i = figury.size() - 1; i >= 0; i--) {
                    if (figury.get(i).czyZawiera(popupX, popupY)) {
                        if (e.isPopupTrigger()) {
                            popupMenu.show(e.getComponent(), e.getX(), e.getY());
                        }
                    }
                }
            }
        }

    /** Prywatna klasa obslugujaca dzialanie myszy */

    private class DzialanieMyszy extends MouseAdapter {

        /** wspolrzedne poczatkowe figury (miejsce klikniecia) */
        private int x1, y1;

        /** Zmienna pomocniczna sluzaca do sprawdzenia kazdego elementu tablicy z figurami */
        private int k;

        /** zmienna przechowujaca informacje ktora figura jest obecnie aktywna */
        boolean c = false;

        /**
         * Metoda obslugujaca nacisniecie myszy
         * Tworzy ona odpowiednie obiekty dla figur i przekazuje im wspolrzedne myszy
         * @param e przechwycenie myszy
         */

        public void mousePressed(MouseEvent e) {
            x1 = e.getX();
            y1 = e.getY();
            //1 dla kola, 2 dla prostokata, 3 dla trojkata
            switch (obecnyTypFigury) {
                //tutaj sa przekazywane parametry odpowiednio: x1, y1, x2, y2, kolor figury
                //x1 i y1 reprezentuja miejsce klikniecia
                //x2 i y2 reprezentuja miejsce myszki, gdy bedzie przesuwana
                //x1 = x2 i y1 = y2 poniewaz są przy kliknieciu w tym samym miejscu
                case 1 : {
                    obecnyTypFiguryObiekt = new MojeKolo(x1, y1, x1, y1, obecnyKolor);
                    break;
                }
                case 2 : {
                    obecnyTypFiguryObiekt = new MojProstokat(x1, y1, x1, y1, obecnyKolor);
                    break;
                }
                case 3 : {
                    obecnyTypFiguryObiekt = new MojTrojkat(x1, y1, x1, y1, obecnyKolor);
                    break;
                }
            }

            if( obecnyTypFigury == 0 ){
                for (k = figury.size()-1; k >= 0; k--) {
                    if (figury.get(k).czyZawiera(e.getX(), e.getY())) {
                        c = true;
                        break;
                    }
                    else { c = false; }
                }
            }
        }

        /**
         * Metoda obslugujaca przesuwanie myszka po przytrzymaniu klikniecia
         * Przypisuje ona do x2 i y2 wspolrzedne myszy, nastepnie wywoluje metode repaint() do narysowania panelu
         * @param e przechwycenie poruszania mysza
         */

        public void mouseDragged(MouseEvent e) {
            if (obecnyTypFigury == 1 || obecnyTypFigury == 2 || obecnyTypFigury == 3) {
                obecnyTypFiguryObiekt.setX2(e.getX());
                obecnyTypFiguryObiekt.setY2(e.getY());
                repaint();
            } else if (obecnyTypFigury == 0) {
                doMove(e); //Przesuwanie figury
            }
        }

        /**
         * Metoda obslugujaca przesuwanie figury
         * @param e przechwycanie przesuwania myszy
         */
        public void doMove(MouseEvent e) {

            int dx;
            int dy;

                if(c) {
                        dx = e.getX() - x1;
                        dy = e.getY() - y1;

                        figury.get(k).addX(dx);
                        figury.get(k).addY(dy);
                        repaint();

                        x1 += dx;
                        y1 += dy;
                }
        }

        /**
         * Metoda obslugujaca puszczenie myszy
         * Przypisuje ona x2 i y2 wspolrzedne myszy, a nastepnie wywoluje metode repaint() do narysowania panelu
         * @param e przechwycenie myszy
         */

        public void mouseReleased(MouseEvent e) {
            if( obecnyTypFigury == 1 || obecnyTypFigury == 2 || obecnyTypFigury == 3) {
                obecnyTypFiguryObiekt.setX2(e.getX());
                obecnyTypFiguryObiekt.setY2(e.getY());

                figury.add(obecnyTypFiguryObiekt); //Dodanie obecnej figury do tablicy przechowujacej figury
                obecnyTypFigury = 0;
                obecnyTypFiguryObiekt = null; //Ustawienie obecnej figury na null bo juz zostala narysowana
                repaint();
                c = false; //Figura juz nie jest aktywna
            }
        }

    }

    /** Prywatna klasa obslugujaca kolko myszy */

    private class DzialanieKolkaMyszy implements MouseWheelListener {

        /**
         * Metoda zmieniajaca wielkosc figury
         * @param e przechwycenie myszki
         */

        @Override
        public void mouseWheelMoved(MouseWheelEvent e) {

            int x = e.getX();
            int y = e.getY();

            if( obecnyTypFigury == 0 ) {
                if (e.getScrollType() == MouseWheelEvent.WHEEL_UNIT_SCROLL) {

                    int k;
                    boolean c = false; //Czy figura jest aktywna
                    for (k = figury.size() - 1; k >= 0; k--) {
                        if (figury.get(k).czyZawiera(x, y)) {
                            c = true;
                            break;
                        }
                    }

                    //Jesli aktywna to zmien jej wielkosc
                    if(c){
                        int amount = e.getWheelRotation() * 4;
                        figury.get(k).zmianaWielkosci(amount);
                        repaint();
                        c = false;
                    }
                }
            }
        }
    }
}