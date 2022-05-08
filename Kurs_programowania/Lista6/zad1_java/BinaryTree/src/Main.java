import java.util.Arrays;
import java.util.InputMismatchException;
import java.util.Scanner;

/**
 * Glowna klasa programu
 * @author Sandra Szwed
 */

public class Main {

    /**
     * Metoda sprawdzajaca czy w Stringu znajduja sie jedynie znaki alfabetu
     * @param str string
     * @return prawda jesli sie znajduja, falsz jest sie nie znajduja
     */
    public static boolean isStringOnlyAlphabet(String str) {
        return ((str != null)
                && (!str.equals(""))
                && (str.matches("^[a-zA-Z]*$")));
    }

    /**
     * Glowna metoda testujaca program
     * @param args argumenty
     */
    public static void main(String[] args){

        Scanner scan = new Scanner(System.in);
        System.out.println("Wybierz opcje wpisujac odpowiednia cyfre:");
        System.out.println("1. Utworz drzewo dla napisow");
        System.out.println("2. Utwor drzewo dla liczb calkowitych");
        System.out.println("3. Utworz drzewo dla liczb niecalkowitych");
        System.out.println("Wpisz cokolwiek innego żeby wyjsc");
        try {
            int wybor = scan.nextInt(); // wybor ktorejs z powyzszych opcji
            int wybor2;

            switch(wybor){
                case 1 : {
                    //Drzewo dla napisow
                    Drzewo<String> s = new Drzewo<>();
                    System.out.println("Wpisz dane oddzielone spacjami jakie beda w drzewie:");
                    String linia;
                    Scanner in = new Scanner(System.in);
                    linia = in.nextLine();
                    if (linia.equals("")) {
                        System.out.println("NIE PODANO ELEMENTOW");
                        System.exit(0);
                    }

                    String[] strs = linia.trim().split("\\s+");

                    for (String str : strs) {
                        if (isStringOnlyAlphabet(str)) {
                            s.insert(str);
                        }
                    }
                    Arrays.fill(strs, null);
                    System.out.println();
                    s.print(); // wypisanie drzewa
                    System.out.println();

                    while(true){
                        System.out.println("Wybierz opcje:");
                        System.out.println("1. Dodaj element");
                        System.out.println("2. Usun element");
                        System.out.println("3. Sprawdz czy element znajduje sie w drzewie");
                        System.out.println("Wpisz cokolwiek innego żeby wyjsc");
                        wybor2 = scan.nextInt();
                        switch(wybor2){
                            case 1 : {
                                System.out.println("Wpisz elementy odzielone spacjami jakie chcesz dodac");
                                linia = in.nextLine();
                                if (!linia.equals("")) {

                                    strs = linia.trim().split("\\s+");

                                    for(String str : strs){
                                        if(isStringOnlyAlphabet(str)){
                                            s.insert(str);
                                        }
                                    }
                                    Arrays.fill(strs, null);
                                }
                                System.out.println();
                                s.print();
                                System.out.println();
                                break;
                            }
                            case 2 : {
                                System.out.println("Wpisz elementy odzielone spacjami jakie chcesz usunac");
                                linia = in.nextLine();

                                if(!linia.equals("")){

                                    strs = linia.trim().split("\\s+");

                                    for(String str : strs){
                                        if (isStringOnlyAlphabet(str)){
                                            s.delete(str);
                                        }
                                    }
                                    Arrays.fill(strs, null);
                                }
                                System.out.println();
                                s.print();
                                System.out.println();
                                break;
                            }
                            case 3 : {
                                System.out.println("Wpisz elementy oddzielone spacjami jakie chcesz sprawdzic czy sa w drzewie");
                                linia = in.nextLine();
                                if(!linia.equals("")){

                                    strs = linia.trim().split("\\s+");

                                    for(String str : strs){
                                        if (isStringOnlyAlphabet(str)) {
                                            System.out.print(str + " - ");
                                            if(s.search(str)){
                                                System.out.println("jest w drzewie");
                                            }else{
                                                System.out.println("nie ma w drzewie");
                                            }
                                        }
                                    }
                                    Arrays.fill(strs, null);
                                }
                                System.out.println();
                                break;
                            }
                            default : System.exit(0);
                        }
                    }
                }
                case 2 : {
                    //Drzewo dla liczb calkowitych
                    Drzewo<Integer> i = new Drzewo<>();
                    System.out.println("Wpisz dane oddzielone spacjami jakie beda w drzewie:");
                    String linia;
                    Scanner in = new Scanner(System.in);
                    linia = in.nextLine();

                    if(linia.equals("")){
                        System.out.println("NIE PODANO ELEMENTOW");
                        System.exit(0);
                    }

                    String[] strs = linia.trim().split("\\s+");

                    for(String str : strs){
                        try{
                            i.insert(Integer.parseInt(str));
                        }catch(NumberFormatException ignored) {}
                    }
                    Arrays.fill(strs, null);
                    System.out.println();
                    i.print();
                    System.out.println();

                    while(true){
                        System.out.println("Wybierz opcje:");
                        System.out.println("1. Dodaj element");
                        System.out.println("2. Usun element");
                        System.out.println("3. Sprawdz czy element znajduje sie w drzewie");
                        System.out.println("Wpisz cokolwiek innego żeby wyjsc");

                        wybor2 = scan.nextInt();

                        switch(wybor2){
                            case 1 : {
                                System.out.println("Wpisz elementy odzielone spacjami jakie chcesz dodac");
                                linia = in.nextLine();
                                if(!linia.equals("")){

                                    strs = linia.trim().split("\\s+");

                                    for(String str : strs){
                                        try{
                                            i.insert(Integer.parseInt(str));
                                        }catch (NumberFormatException ignored){}
                                    }
                                    Arrays.fill(strs, null);
                                }
                                System.out.println();
                                i.print();
                                System.out.println();
                                break;
                            }
                            case 2 : {
                                System.out.println("Wpisz elementy odzielone spacjami jakie chcesz usunac");
                                linia = in.nextLine();

                                if(!linia.equals("")){

                                    strs = linia.trim().split("\\s+");

                                    for(String str : strs){
                                        try{
                                            i.delete(Integer.parseInt(str));
                                        }catch(NumberFormatException ignored){}
                                    }
                                    Arrays.fill(strs, null);
                                }
                                System.out.println();
                                i.print();
                                System.out.println();
                                break;
                            }
                            case 3 : {
                                System.out.println("Wpisz elementy oddzielone spacjami jakie chcesz sprawdzic czy sa w drzewie");
                                linia = in.nextLine();
                                if(!linia.equals("")){

                                    strs = linia.trim().split("\\s+");

                                    int temp;
                                    for(String str : strs){
                                        try{
                                            temp = Integer.parseInt(str);
                                            System.out.print(temp + " - ");
                                            if(i.search(temp)){
                                                System.out.println("jest w drzewie");
                                            }else{
                                                System.out.println("nie ma w drzewie");
                                            }

                                        }catch(NumberFormatException ignored){}
                                    }
                                    Arrays.fill(strs, null);
                                }
                                System.out.println();
                                break;
                            }
                            default : System.exit(0);
                        }
                    }
                }
                case 3 : {
                    //Drzewo dla liczb niecalkowitych
                    Drzewo<Double> d = new Drzewo<>();
                    System.out.println("Wpisz dane oddzielone spacjami jakie beda w drzewie:");
                    String linia;
                    Scanner in = new Scanner(System.in);
                    linia = in.nextLine();
                    if(linia.equals("")){
                        System.out.println("NIE PODANO ELEMENTOW");
                        System.exit(0);
                    }

                    String[] strs = linia.trim().split("\\s+");

                    for (String str : strs){
                        try{
                            d.insert(Double.parseDouble(str));
                        }catch(NumberFormatException ignored){
                        }
                    }
                    Arrays.fill(strs, null);
                    System.out.println();
                    d.print();
                    System.out.println();

                    while(true){
                        System.out.println("Wybierz opcje:");
                        System.out.println("1. Dodaj element");
                        System.out.println("2. Usun element");
                        System.out.println("3. Sprawdz czy element znajduje sie w drzewie");
                        System.out.println("Wpisz cokolwiek innego żeby wyjsc");
                        wybor2 = scan.nextInt();
                        switch(wybor2){
                            case 1 : {
                                System.out.println("Wpisz elementy odzielone spacjami jakie chcesz dodac");
                                linia = in.nextLine();

                                if(!linia.equals("")){

                                    strs = linia.trim().split("\\s+");

                                    for(String str : strs){
                                        try{
                                            d.insert(Double.parseDouble(str));
                                        }catch(NumberFormatException ignored){}
                                    }
                                    Arrays.fill(strs, null);
                                }
                                System.out.println();
                                d.print();
                                System.out.println();
                                break;
                            }
                            case 2 : {
                                System.out.println("Wpisz elementy odzielone spacjami jakie chcesz usunac");
                                linia = in.nextLine();

                                if(!linia.equals("")){

                                    strs = linia.trim().split("\\s+");

                                    for (String str : strs) {
                                        try {
                                            d.delete(Double.parseDouble(str));
                                        } catch (NumberFormatException ignored){}
                                    }
                                    Arrays.fill(strs, null);
                                }
                                System.out.println();
                                d.print();
                                System.out.println();
                                break;
                            }
                            case 3 : {
                                System.out.println("Wpisz elementy oddzielone spacjami jakie chcesz sprawdzic czy sa w drzewie");
                                linia = in.nextLine();

                                if(!linia.equals("")){

                                    strs = linia.trim().split("\\s+");

                                    double temp;
                                    for(String str : strs){
                                        try{
                                            temp = Double.parseDouble(str);
                                            System.out.print(temp + " - ");
                                            if(d.search(temp)){
                                                System.out.println("jest w drzewie");
                                            }else{
                                                System.out.println("nie ma w drzewie");
                                            }
                                        }catch(NumberFormatException ignored){}
                                    }
                                    Arrays.fill(strs, null);
                                }
                                System.out.println();
                                break;
                            }
                            default : System.exit(0);
                        }
                    }
                }
                default : System.exit(0);
            }
        }catch(InputMismatchException a){ System.exit(0); }
    }
}