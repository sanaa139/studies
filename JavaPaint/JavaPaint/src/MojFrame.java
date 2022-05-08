import javax.swing.*;
import javax.swing.border.Border;
import javax.swing.filechooser.FileNameExtensionFilter;
import java.awt.*;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.io.*;

/** Klasa tworzaca okno */

public class MojFrame extends JFrame implements ActionListener{

    /** Deklaracja przestrzeni do rysowania figur */
    private final MojPanel panel;

    /** Deklaracja dialogu do stworzenia okna z informacjami */
    private JDialog dialog1;

    /** Deklaracja dialogu do stworzenia okna z informacjami */
    private JDialog dialog2;

    /** Deklaracja fileChooser do wczytania/zapisania pliku */
    private JFileChooser fileChooser;

    /** Deklaracja zmiennej przevhowujacej plik */
    private File plik;

    /** Konstruktor klasy tworzacej okno */

    public MojFrame() {
        super("Odjechany paint!");
        panel = new MojPanel();

        stworzMenu();

        setSize( 1000, 700 );
        setLayout( new GridLayout(1,1 ) );
        setDefaultCloseOperation( JFrame.EXIT_ON_CLOSE );
        setResizable(true);
        setVisible( true );
        setLocationRelativeTo(null);

        add( panel );
    }

    /** Metoda tworzaca menu i jego elementy */

    private void stworzMenu(){
        JMenuBar mojeMenu = new JMenuBar();
        JMenu menu1 = new JMenu("Opcje");
        JMenu menu2 = new JMenu("Rysuj");
        JMenu info = new JMenu("Info");
        mojeMenu.add(menu1);
        mojeMenu.add(menu2);
        mojeMenu.add(info);

        JMenuItem wyjdz = new JMenuItem("Wyjdz");
        wyjdz.addActionListener(this);

        JMenuItem wyczysc = new JMenuItem("Wyczysc");
        wyczysc.addActionListener(this);

        JMenuItem zapisz = new JMenuItem("Zapisz");
        zapisz.addActionListener(this::zapisz);

        JMenuItem wczytaj = new JMenuItem("Wczytaj");
        wczytaj.addActionListener(this::wczytaj);

        JMenuItem i1 = new JMenuItem("Kolo");
        i1.addActionListener(this);
        JMenuItem i2 = new JMenuItem("Prostokat");
        i2.addActionListener(this);
        JMenuItem i3 = new JMenuItem("Trojkat");
        i3.addActionListener(this);

        JMenuItem i4 = new JMenuItem("Informacje");
        i4.addActionListener(this:: informacje);
        JMenuItem i5 = new JMenuItem("Instrukcja");
        i5.addActionListener(this:: instrukcja);

        menu1.add(wyczysc);
        menu1.add(wyjdz);
        menu1.add(zapisz);
        menu1.add(wczytaj);
        menu2.add(i1);
        menu2.add(i2);
        menu2.add(i3);
        info.add(i4);
        info.add(i5);

        setJMenuBar(mojeMenu);

    }

    /**
     * Metoda tworzaca okno po kliknieciu w przycisk "informacje" w menu
     * @param e przechwycenie klikniecia w przycisk
     */

    public void informacje(ActionEvent e) {
        dialog1 = new JDialog(this, "informacje", false);
        dialog1.setSize(300, 220);
        dialog1.setLayout(null);

        JTextArea textArea = new JTextArea("Nazwa programu: Odjechany paint!\nPrzeznaczenie programu: Rysowanie figur\n" +
                "Autor: Sandra Szwed");
        textArea.setBounds(10,10, 265,100);
        Border border = BorderFactory.createLineBorder(Color.BLACK);
        textArea.setBorder(BorderFactory.createCompoundBorder(border,
                BorderFactory.createEmptyBorder(10, 10, 10, 10)));
        textArea.setEditable(false);

        dialog1.add(textArea);

        JButton przyciskOK = new JButton("ok");
        przyciskOK.setBounds(120,120,50,50);
        dialog1.add(przyciskOK);
        przyciskOK.addActionListener(this:: okPrzyciskInformacje);
        przyciskOK.setFocusable(false);

        dialog1.setResizable(false);
        dialog1.setVisible(true);
        dialog1.setLocationRelativeTo(null);
    }

    /**
     * Metoda tworzaca okno po kliknieciu w przycisk "instrukcja" w menu
     * @param e przechwycenie klikniecia w przycisk
     */

    public void instrukcja(ActionEvent e) {
        dialog2 = new JDialog(this, "instrukcja", false);
        dialog2.setSize(300, 250);
        dialog2.setLayout(null);

        JTextArea textArea = new JTextArea("Aby narysowac figurę wybierz jedna z figur dostepnych po nacisnieciu w przycisk \"Rysuj\".\n" +
                "Mozesz wybrac kolor figury klikajac na nia prawym przyciskiem myszy.\n" +
                "Żeby zmienic polozenie figury, kliknij na nia i sprobuj ja przeciagnac, a zeby zmienic jej wielkosc uzyc scrolla myszki.");
        textArea.setBounds(10,10, 265,130);
        Border border = BorderFactory.createLineBorder(Color.BLACK);
        textArea.setBorder(BorderFactory.createCompoundBorder(border, BorderFactory.createEmptyBorder(10, 10, 10, 10)));
        textArea.setLineWrap(true);
        textArea.setWrapStyleWord(true);
        textArea.setEditable(false);

        dialog2.add(textArea);

        JButton przyciskOK2 = new JButton("ok");
        przyciskOK2.setBounds(120,150,50,50);
        dialog2.add(przyciskOK2);
        przyciskOK2.addActionListener(this:: okPrzyciskInstrukcja);
        przyciskOK2.setFocusable(false);

        dialog2.setResizable(false);
        dialog2.setVisible(true);
        dialog2.setLocationRelativeTo(null);
    }

    /**
     * Metoda obslugujaca przycisk "ok" zawierajacy sie w oknie z informacjami
     * @param e przechwycenie klikniecia w przycisk
     */

    public void okPrzyciskInformacje(ActionEvent e){
        //Zamyka okno z informacjami
        dialog1.setVisible(false);
    }

    /**
     * Metoda obslugujaca przycisk "ok" zawierajacy sie w oknie z instrukcja
     * @param e przechwycenie klikniecia w przycisk
     */

    public void okPrzyciskInstrukcja(ActionEvent e){
        //Zamyka okno z instrukcja
        dialog2.setVisible(false);
    }

    /**
     * Metoda obslugujaca przycisk "Zapisz" zapisujaca informacje o figurach do pliku tekstowego
     * @param e przechwycenie klikniecia w przycisk
     */

    public void zapisz(ActionEvent e) {
        fileChooser = new JFileChooser();
        fileChooser.setSize(400,300);
        fileChooser.setSelectedFile(new File("mojplik.txt"));
        fileChooser.setFileFilter(new FileNameExtensionFilter("Plik tekstowy","txt"));

        int wyborUzytkownika = fileChooser.showSaveDialog(this);

        if (wyborUzytkownika == JFileChooser.APPROVE_OPTION) {
            plik = fileChooser.getSelectedFile();
            String nazwaPliku = plik.getAbsolutePath();
            //Jezeli nazwa pliku nie bedzie zawierala rozszerzenia .txt to zostanie ono dodane
            if(!nazwaPliku.endsWith(".txt") ) {
                plik = new File(nazwaPliku + ".txt");
            }
            PrintWriter zapis;
            //Proba zapisania informacji o figurach do pliku tekstowego
            try {
                zapis = new PrintWriter(plik);
                for (int i = 0; i <= panel.figury.size() - 1; i++) {
                    zapis.println(panel.figury.get(i).nazwaFigury());
                    zapis.println(panel.figury.get(i).getX1());
                    zapis.println(panel.figury.get(i).getY1());
                    zapis.println(panel.figury.get(i).getX2());
                    zapis.println(panel.figury.get(i).getY2());
                    zapis.println(panel.figury.get(i).getKolor().getRed());
                    zapis.println(panel.figury.get(i).getKolor().getGreen());
                    zapis.println(panel.figury.get(i).getKolor().getBlue());
                }
                zapis.close();
            } catch (FileNotFoundException ex) {
                ex.printStackTrace();
            }
        }
    }

    /**
     * Metoda obslugujaca przycisk "Wczytaj" wczytujaca plik tekstowy z informacjami o figurach i dodajaca je do panelu
     * @param e przechwycenie klikniecia w przycisk
     */

    public void wczytaj(ActionEvent e) {
        fileChooser = new JFileChooser();
        fileChooser.setSize(400,300);

        FileNameExtensionFilter typPliku = new FileNameExtensionFilter("Pliki tekstowe", "txt", "text");
        fileChooser.setFileFilter(typPliku);

        int wyborUzytkownika = fileChooser.showOpenDialog(null);

        if(wyborUzytkownika == JFileChooser.APPROVE_OPTION) {
            plik = fileChooser.getSelectedFile();
            String nazwaPliku = plik.getAbsolutePath();
            if (nazwaPliku.endsWith(".txt")) {
                try {
                    BufferedReader bufferedReader = new BufferedReader(new FileReader(plik));
                    String obecnaLinia;
                    MojKsztalt figura = new MojeKolo();
                    int k = 0, r = 0, g = 0, b = 0;
                    while ((obecnaLinia = bufferedReader.readLine()) != null) {
                        switch (k) {
                            case 0 : {
                                if (obecnaLinia.equals("Kolo")) {
                                    figura = new MojeKolo();
                                    panel.figury.add(figura);
                                }
                                if (obecnaLinia.equals("Prostokat")) {
                                    figura = new MojProstokat();
                                    panel.figury.add(figura);
                                }
                                if (obecnaLinia.equals("Trojkat")) {
                                    figura = new MojTrojkat();
                                    panel.figury.add(figura);
                                }
                                break;
                            }
                            case 1 : {
                                figura.setX1(Integer.parseInt(obecnaLinia));
                                break;
                            }
                            case 2 : {
                                figura.setY1(Integer.parseInt(obecnaLinia));
                                break;
                            }
                            case 3 : {
                                figura.setX2(Integer.parseInt(obecnaLinia));
                                break;
                            }
                            case 4 : {
                                figura.setY2(Integer.parseInt(obecnaLinia));
                                break;
                            }
                            case 5 : {
                                r = Integer.parseInt(obecnaLinia);
                                break;
                            }
                            case 6 : {
                                g = Integer.parseInt(obecnaLinia);
                                break;
                            }
                            case 7 : {
                                b = Integer.parseInt(obecnaLinia);
                                break;
                            }
                        }
                        k++;
                        if (k == 8) {
                            figura.setKolor(new Color(r,g,b));
                            k = 0;
                        }
                    }
                    panel.repaint();
                } catch (Exception ex) {
                    ex.printStackTrace();
                }
            }
        }
    }

    /**
     * Metoda obslugujaca przyciski "Wyjdz" i "Wyczysc" oraz przyciski odpowiedzialne za wybranie figury ktora chce sie narysowac
     * @param e przechwycenie klikniecia w przycisk
     */

    public void actionPerformed( ActionEvent e ) {
        switch (e.getActionCommand()) {
            case "Wyjdz" : {
                System.exit(0);
            }
            case "Wyczysc" : {
                panel.wyczyscPanel();
                break;
            }
            case "Kolo" : {
                panel.setObecnyTypFigury(1);
                break;
            }
            case "Prostokat" : {
                panel.setObecnyTypFigury(2);
                break;
            }
            case "Trojkat" : {
                panel.setObecnyTypFigury(3);
                break;
            }
        }
    }

}
