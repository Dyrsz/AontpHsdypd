PFont font1;
Gasto gasto1 = new Gasto(1,1,2016, "Material oficina", 34.61, 'a'); 
Gasto gasto2 = new Gasto(31,12,2021, "Gasóleo", 60, 'a'); 
boolean[] menE = new boolean[8];  // Para menE == 0, menE[4] sin utilizar el último. Para menE == 2, menE[8].
byte menInd;

void setup() {
  size(600,250);
  font1 = createFont("Arial",16,true);
  
}

void draw() {
  background(0);
  fill(0);
  if (menInd == 0) {
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
  } else if (menInd == 2) {
    stroke(110);
    rect(35, 45, 530, 140);
    rect(345, 202, 100, 30);
    rect(465, 202, 100, 30);
    line(40, 115, 560, 115);
    noStroke();
    fill(250);
    textFont(font1,21);
    text("Añadir gasto nuevo",105,30);
    textFont(font1,17);
    text("Concepto:", 45, 70);
    text("Clase:", 445, 70);
    text("Fecha:", 345, 100);
    text("Base:", 45, 100);
    text("Tipo IVA:", 45, 140);
    text("IVA:", 190, 140);
    text("Total:", 345, 140);
    text("Capítulo:", 45, 170);
    text("Volver", 370, 223);
    text("Introducir", 480, 223);
    stroke(110);
    fill(150, 0, 150, 70);
    if (130 <= mouseX && mouseX <= 430 && 51 <= mouseY && mouseY <= 78) {
      rect(130, 51, 300, 27);
      menE[0] = true;
    } else {
      menE[0] = false;
    } if (500 <= mouseX && mouseX <= 550 && 51 <= mouseY && mouseY <= 78) {
      rect(500, 51, 50, 27);
      menE[1] = true;
    } else {
      menE[1] = false;
    } if (95 <= mouseX && mouseX <= 330 && 82 <= mouseY && mouseY <= 109) {
      rect(95, 82, 235, 27);
      menE[2] = true;
    } else {
      menE[2] = false;
    } if (404 <= mouseX && mouseX <= 550 && 82 <= mouseY && mouseY <= 109) {
      rect(404, 82, 146, 27);
      menE[3] = true;
    } else {
      menE[3] = false;
    } if (345 <= mouseX && mouseX <= 445 && 202 <= mouseY && mouseY <= 232) {
      rect(345, 202, 100, 30);
      menE[6] = true;
    } else {
      menE[6] = false;
    } if (465 <= mouseX && mouseX <= 565 && 202 <= mouseY && mouseY <= 232) {
      rect(465, 202, 100, 30);
      menE[7] = true;
    } else {
      menE[7] = false;
    }    
    fill(100, 80, 100, 70);
    if (118 <= mouseX && mouseX <= 178 && 120 <= mouseY && mouseY <= 147) {
      rect(118, 120, 60, 27);
      menE[4] = true;
    } else {
      menE[4] = false;
    } if (118 <= mouseX && mouseX <= 550 && 152 <= mouseY && mouseY <= 179) {
      rect(118, 152, 432, 27);
      menE[5] = true;
    } else {
      menE[5] = false;
    }
  }
}

void mouseClicked() { 
  if (menInd == 0) {
    if (menE[0]) {
      // Ver Gastos.
    } else if (menE[1]) {
      menInd = 2; 
    } else if (menE[2]) {
      // Producir pdf (Menú para elegir).
    } else if (menE[3]) {
      // Nuevo libro de gastos (Otro menú). Esta parte la dejo para el final.
    }
  } else if (menInd == 2) {
    if (menE[0]) {
      // Concepto. Abrir Menú.
    } else if (menE[1]) {
      // Clase del concepto. Otro menú, también. 
    } else if (menE[2]) {
      // Base. Editor.
    } else if (menE[3]) {
      // Fecha. Menú.
    } else if (menE[4]) {
      // Tipo IVA. Menú.
    } else if (menE[5]) {
      // Capítulo. Menú.
    } else if (menE[6]) {
      menInd = 0;
      menE[6] = false;
    } else if (menE[7]) {
      // Introducir: Verifica los datos de todos los apartados y añade el gasto.
    }
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