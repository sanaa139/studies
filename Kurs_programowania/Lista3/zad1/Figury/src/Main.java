public class Main {

    public static void main(String[] args){

        if(args == null){
            System.exit(0);
        }

        String obiekty = args[0];

        int j = 1;
        int p;
        for(int i = 0; i < obiekty.length(); i++) {
            char figura = obiekty.charAt(i);

            switch (figura){
                case 'o' : {
                    try{
                        p = Integer.parseInt(args[j]);
                        if( p > 0) {
                            System.out.println("Kolo: obwod = " + Figury.jedenParametr.KOLO.obliczObwod(p) +
                            ", pole = " + Figury.jedenParametr.KOLO.obliczPole(p));
                        }
                        else{ System.out.println("Nie mozna utworzyc kola poniewaz podano zly parametr"); }
                    }catch (NumberFormatException e) {
                        System.out.println("Nie mozna utworzyc kola poniewaz podano zly parametr");
                    }catch(ArrayIndexOutOfBoundsException a){
                        System.out.println("Nie mozna utworzyc kola poniewaz nie podano parametru");
                    }
                    j++;
                    break;
                }
                case 'c' : {
                    int[] dane = new int[5];
                    int h = j;
                    try{
                        for (int k = 0; k <= 4; k++){
                            dane[k] = Integer.parseInt(args[h]);
                            h++;
                        }
                        if(dane[0] > 0 && dane[1] > 0 && dane[2] > 0 && dane[3] > 0 && dane[4] > 0) {
                            if(dane[0] == dane[1] && dane[0] == dane[2] && dane[0] == dane[3]){
                                if(dane[4] == 90){
                                    System.out.println("Kwadrat: obwod = " + Figury.jedenParametr.KWADRAT.obliczObwod(dane[0]) +
                                            ", pole = " + Figury.jedenParametr.KWADRAT.obliczPole(dane[0]));
                                }else if (dane[4] > 90 && dane[4] < 180){
                                    System.out.println("Romb: obwod = " + Figury.dwaParametry.ROMB.obliczObwod(dane[0], dane[4]) +
                                            ", pole = " + Figury.dwaParametry.ROMB.obliczPole(dane[0], 180 - dane[4]));
                                }else{
                                    System.out.println("Romb: obwod = " + Figury.dwaParametry.ROMB.obliczObwod(dane[0], dane[4]) +
                                            ", pole = " + Figury.dwaParametry.ROMB.obliczPole(dane[0], dane[4]));
                                }
                            }else if(dane[0] == dane[1] && dane[2] == dane[3]){
                                System.out.println("Prostokat: obwod = " + Figury.dwaParametry.PROSTOKAT.obliczObwod(dane[0], dane[2]) +
                                        ", pole = " + Figury.dwaParametry.PROSTOKAT.obliczPole(dane[0], dane[2]));
                            }
                        }else{ System.out.println("Nie mozna utworzyc czworokata poniewaz podano zly parametr"); }
                    }catch(ArrayIndexOutOfBoundsException ex){
                        System.out.println("Nie mozna utworzyc czworokata poniewaz zostala podana zbyt mala ilosc parametrow");
                    }catch(NumberFormatException e){
                        System.out.println("Nie mozna utworzyc czworokata poniewaz podano zly parametr");
                    }
                    j = j + 5;
                    break;
                }
                case 'p' : {
                    try{
                        p = Integer.parseInt(args[j]);
                        if(p > 0){
                            System.out.println("Pieciokat: obwod = " + Figury.jedenParametr.PIECIOKAT.obliczObwod(p) +
                                    ", pole = " + Figury.jedenParametr.PIECIOKAT.obliczPole(p));
                        }else{ System.out.println("Nie mozna utworzyc pieciokata poniewaz podano zly parametr"); }
                    }catch(NumberFormatException e){
                        System.out.println("Nie mozna utworzyc pieciokata poniewaz podano zly parametr");
                    }catch(ArrayIndexOutOfBoundsException a){
                        System.out.println("Nie mozna utworzyc pieciokata poniewaz nie podano parametru");
                    }
                    j++;
                    break;
                }
                case 's' : {
                    try{
                        p = Integer.parseInt(args[j]);
                        if(p > 0) {
                            System.out.println("Szesciokat: obwod = " + Figury.jedenParametr.SZESCIOKAT.obliczObwod(p) +
                                    ", pole = " + Figury.jedenParametr.SZESCIOKAT.obliczPole(p));
                        }else{ System.out.println("Nie mozna utworzyc szesciokata poniewaz podano zly parametr"); }
                    }catch(NumberFormatException e){
                        System.out.println("Nie mozna utworzyc szesciokata poniewaz podano zly parametr");
                    }catch(ArrayIndexOutOfBoundsException a){
                        System.out.println("Nie mozna utworzyc szesciokata poniewaz nie podano parametru");
                    }
                    j++;
                    break;
                }
                default :
                        System.out.println("Nie mozna utworzyc figury o znaku: " + obiekty.charAt(i));
            }
        }

    }
}