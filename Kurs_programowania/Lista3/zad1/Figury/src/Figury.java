interface Jeden{
    double obliczObwod(int x);
    double obliczPole(int x);
}

interface Dwa{
    double obliczObwod(int x, int y);
    double obliczPole(int x, int y);
}

public class Figury{

    public enum jedenParametr implements Jeden{
        KOLO{
            public double obliczObwod(int promien){
                return 2 * Math.PI * promien;
            }
            public double obliczPole(int promien){
                return Math.PI * promien * promien;
            }
        },

        KWADRAT{
            public double obliczObwod(int bok){
                return 4 * bok;
            }
            public double obliczPole(int bok){
                return bok * bok;
            }
        },

        PIECIOKAT{
            public double obliczObwod(int bok){
                return 5 * bok;
            }
            public double obliczPole(int bok){
                return ((Math.sqrt(25 + 10 * Math.sqrt(5))) * bok * bok) / 4;
            }
        },

        SZESCIOKAT{
            public double obliczObwod(int bok){
                return 6 * bok;
            }
            public double obliczPole(int bok){
                return (3 * Math.sqrt(3) * bok * bok) / 2;
            }
        }
    }

    public enum dwaParametry implements Dwa{
        PROSTOKAT {
            public double obliczObwod(int bok1, int bok2){
                return 2 * bok1 + 2 * bok2;
            }
            public double obliczPole(int bok1, int bok2){
                return bok1 * bok2;
            }
        },

        ROMB {
            public double obliczObwod(int bok, int kat){
                return 4 * bok;
            }
            public double obliczPole(int bok, int kat){
                return bok * bok * Math.sin(Math.toRadians(kat));
            }
        }
    }
}