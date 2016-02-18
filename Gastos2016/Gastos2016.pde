PFont font1;
Gasto gasto1 = new Gasto(1,1,2016, "Material oficina", 34.61, 'a'); 
Gasto gasto2 = new Gasto(31,12,2021, "Gasóleo", 60, 'a'); 
boolean[] menE = new boolean[4];  // El último elemento no lo manejo aún.

void setup() {
  size(600,250);
  font1 = createFont("Arial",16,true);
  
}

void draw() {
  background(0);
  fill(0);

  stroke(110);
  fill(150, 0, 150, 70);
  for (byte i = 0; i < 3; i++) {
    if (42 <= mouseX && mouseX <= 250 && (58+40*i) <= mouseY && mouseY <= (90+40*i)) {
      rect(42, (58+40*i), 208, 32);
      menE[i] = true;
    } else {
      menE[i] = false;
    }
  }
  noStroke();
  fill(250);
  textFont(font1,21);
  text("Asistente de Libro de gastos",155,30);
  textFont(font1,18);
  text("Ver lista de gastos", 50, 80);
  text("Añadir gasto", 50, 120);
  text("Producir para imprimir", 50, 160);
  text("Nuevo libro de gastos", 50, 200);
  if (42 <= mouseX && mouseX <= 250 && (58+40*3) <= mouseY && mouseY <= (90+40*3)) {
    fill(150, 0, 150, 70);
    textFont(font1,21);
    text("No disponible", 250, 200);
  }
  
}

class Gasto {
  int fD;
  int fM;
  int fY = 2016;
  String conc;
  float base;
  char sConc;
  String ID;
  /*
  float tIVA;
  float IVA;
  float total;
  String capit;
  */
  Gasto(int tfD, int tfM, int tfY, String tconc, float tbase, char tsConc) {
    fD = tfD;
    fM = tfM;
    fY = tfY;
    conc = tconc;
    int tbaseI = round(tbase*100);      // La base tiene dos decimales.
    base = tbaseI/100.0;
    sConc = tsConc;
    // Construyo la ID:
      // Year:  
        //if (fY < 2016 || fY > 2100) Error;
    String ID1 = str(fY - 2015);
    if (ID1.length() == 1) ID1 = "0" + ID1;
      // Month:
        //if (fM < 1 || fY > 12) Error;
    String ID2 = " ";
    if (fM < 11) {
      ID2 = str(fM-1);
    } else {
      if (fM == 11) ID2 = "A";
      if (fM == 12) ID2 = "B";
    }
      // Day:
        //if (fM == 1 || fM == 3 || fM == 5 || fM == 7 || fM == 8 || fM == 10 || fM == 12) if (fD < 1 || fD > 31) Error;
        //if (fM == 4 || fM == 6 || fM == 9 || fM == 11) if (fD < 1 || fD > 30) Error;
        //if (fM == 2 && fY%4 == 0) if (fD < 1 || fD > 29) Error;
        //if (fM == 2 && fY%4 != 0) if (fD < 1 || fD > 28) Error;
    String ID3 = str(char(fD+47));
      // Concepto, sConcepto:
    String ID4 = str(conc.charAt(0)) + str(conc.charAt(conc.length()-1));
    String ID5 = str(sConc);
      // Base:
    String ID6s1 = str(base);
    String ID6s = str(ID6s1.length());
        //if(ID6s > 10) Error;
    int ID6i = int(base);
    String ID6 = ID6s + str(str(ID6i%10).charAt(0));
      // Reserva. De momento no lo toco.
    String ID7 = "0";
    ID = ID1 + ID2 + ID3 + ID4 + ID5 + ID6 + ID7;    //  '_' Para separar IDs en una misma fila. (No es necesario)
  }
}