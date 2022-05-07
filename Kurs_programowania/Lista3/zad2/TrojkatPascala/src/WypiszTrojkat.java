public class WypiszTrojkat{
    int ileRzedow, rzad;
    WypiszTrojkat(int rzad, int ileRzedow){
        this.ileRzedow = ileRzedow;
        this.rzad = rzad;
    }

    public String stworzWiersz(){
        double maxDlugoscLiczby = Math.pow(2, ileRzedow);
        String temp = Double.toString(maxDlugoscLiczby);
        int maksymalnaDlugosc = temp.length();
        String liczby = "";
        for(int j = 0; j <= rzad; j++){
            long liczba = obliczLiczbe(rzad, j);
            if(j < rzad){
                liczby = liczby + liczba + spacje(liczba, maksymalnaDlugosc);
            }
            else if(j == rzad){
                liczby = liczby + liczba;
            }
        }
        return liczby;
    }

    private String spacje(final Long liczba, final int maksymalnaDlugosc){
        String spacje = "";
        for (int i = 0; i < maksymalnaDlugosc - liczba.toString().length(); i++){
            spacje = spacje + " ";
        }
        return spacje;
    }

    public long obliczLiczbe(int rzad, int j){
        //ze wzoru n!/(k!*(n-k)!)
        return silnia(rzad) / (silnia(j) * silnia(rzad - j));
    }

    public long silnia(int n){
        long x = 1;
        for(int i = 2; i <= n; i++){
            x = x * i;
        }
        return x;
    }
}