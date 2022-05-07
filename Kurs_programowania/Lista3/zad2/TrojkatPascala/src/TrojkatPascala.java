import java.awt.*;
import java.awt.event.WindowAdapter;
import java.awt.event.WindowEvent;

//zamykanie okna
class MyWindowAdapter extends WindowAdapter{
    public void windowClosing (WindowEvent e) { System.exit (0); }
}

public class TrojkatPascala{

    public static void main(String[] args){

        //okno
        Frame okno = new Frame("Trojkat Pascala");
        okno.addWindowListener(new MyWindowAdapter());
        okno.setResizable(false);
        okno.setVisible(true);
        okno.setBackground(Color.PINK);

        Panel panel = new Panel(new GridBagLayout());
        GridBagConstraints gbc = new GridBagConstraints();
        gbc.gridx = 0;
        gbc.gridy = 0;
        okno.add(panel);

        Label wiersz;

        int ileRzedow;
        try{
            ileRzedow = Integer.parseInt(args[0]);
            if(ileRzedow < 1 || ileRzedow > 21 ){
                wiersz = new Label("Nie mozna utworzyc trojkata", Label.CENTER);
                wiersz.setFont(new Font("Verdana", Font.PLAIN, 16));
                panel.add(wiersz, gbc);
            }else{
                for(int k = 0; k < ileRzedow; k++){
                    wiersz = new Label((new WypiszTrojkat(k, ileRzedow)).stworzWiersz(), Label.CENTER);
                    wiersz.setFont(new Font("Verdana", Font.PLAIN, 16));
                    panel.add(wiersz, gbc);
                    gbc.gridy++;
                }
            }
        }catch (ArrayIndexOutOfBoundsException e){
            wiersz = new Label("Brak danych na wejscie, nie mozna utworzyc trojkata", Label.CENTER);
            wiersz.setFont(new Font("Verdana", Font.PLAIN, 16));
            panel.add(wiersz, gbc);
        }catch(NumberFormatException a){
            wiersz = new Label("Nie mozna utworzyc trojkata", Label.CENTER);
            wiersz.setFont(new Font("Verdana", Font.PLAIN, 16));
            panel.add(wiersz, gbc);
        }

        okno.pack();
        okno.setLocationRelativeTo(null);
    }
}