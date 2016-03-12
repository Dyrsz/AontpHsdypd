PFont font1;
Gasto gasto1 = new Gasto(1,1,2016, "Material oficina", 40, 'A'); 
Gasto gasto2 = new Gasto(1,1,2016, "Gasóleo", 33.06, 'A'); 
boolean[] menE = new boolean[200];  // Para menE == 0, menE[4] sin utilizar el último. Para menE == 2, menE[9].
byte menInd;
boolean cargaCorrecta = false;
String[] DatosBdD;
String[][] GastosBdD = new String[2000][9];  // Con 2000 me sobra. Es un parche, pero no es necesario complicarlo.
int numGastos = 0;
int numConcDistintos = 0;
String[] concBdD = new String[2000];  // Vector de conceptos distintos ordenados por frecuencias.
int[] concFBdD = new int[2000];       // Vector de las frecuencias del vector anterior.
float scrllBarAC = 0;
float scrllBarMap = 0;
boolean scrllBajo = false;            // Verdadero cuando la scrollbar está debajo del todo.
String[] ANGasto = new String[9];
String ANTotal = "";
String ANIVA = "";
String textEdit = "";                 // Variable del texto que se introduce.
boolean tild;                         // Variables de editor de texto.    
boolean umlaut;
char letter;
char[] ch1;

/*
  - Para el próximo día, cierro el apartado de Capítulo.

  R1. Poner la excepción de los conceptos que se muestran seguín textWidth. (Esto lo dejo para cuando pueda introducir conceptos, para dejarlo más cómodo).
  R2. Si hay un carácter de diferencia con el resto de conceptos, siendo un concepto nuevo, da la opción de: ¿Quiere decir...? Supongo. Tengo que pensarlo.

  Extra1. Puedo hacer una función para los menús en draw. Se sirve de la variable índice (menInd).
  Extra2. Puedo hacer una función para los botones. Rect, texto, y variable de salida si están activos.
  Extra3. Puedo hacer una función para las scrollbars. Esta es más complicada: Una que marque la máscara y tape lo de fuera, luego el contenido, y los tres botones y los mapeos.
  Extra4. Puede que tuviera que hacer una función para extraer y ordenar por fecuencias más abstracta.
*/

void setup() {
  size(600,250);
  font1 = createFont("Arial",16,true);
  carga();
  if (numGastos != 0 && cargaCorrecta) ConceptosPorFrecuencia();
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
    //text(GastosBdD[0][3], 250,50);  // Aquí para mirar IDs.
    //text(int('\''), 250,50);
    /*
    for (int n = 0; n < numConcDistintos; n++) {    // Aquí para mirar el vector de los conceptos ordenados.
      text(concBdD[n] + "; " + concFBdD[n], 250,50+25*n);
    }
    */
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
  } else if (menInd == 2 || menInd == 20 || menInd == 21 || menInd == 22 || menInd == 23 || menInd == 24 || menInd == 50) {
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
    text("Volver", 370, 223);
    text("Introducir", 480, 223);
    if (menInd == 2 || menInd == 24) {
      if (menInd == 2) {
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
          menE[7] = true;
        } else {
          menE[7] = false;
        } if (465 <= mouseX && mouseX <= 565 && 202 <= mouseY && mouseY <= 232) {
          rect(465, 202, 100, 30);
          menE[8] = true;
        } else {
          menE[8] = false;
        }    
        fill(100, 80, 100, 70);
        if (118 <= mouseX && mouseX <= 550 && 152 <= mouseY && mouseY <= 179) {
          rect(118, 152, 432, 27);
          menE[6] = true;
        } else {
          menE[6] = false;
        }
      }
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
      if (!ANGasto[3].equals("")) text(ANGasto[3], 140, 70);
      if (menInd == 2) if (!ANGasto[4].equals("")) text(ANGasto[4], 100, 100);
      if (!ANGasto[5].equals("")) text(ANGasto[5], 520, 70);
      if (!ANGasto[6].equals("")) text(ANGasto[6], 130, 140);
      if (!ANTotal.equals("")) text(ANTotal, 395, 140);
      if (!ANIVA.equals("")) text(ANIVA, 230, 140);
      if (menInd == 24) {
        if (menE[0]) {
          text("Base", 150, 223);
        } if (menE[1]) {
          text("IVA incluido", 150, 223);
        } if (menE[2]) {
          text("Base/3", 150, 223);
        } if (menE[3]) {
          text("IVA incluido/3", 150, 223);
        }
        text(textEdit, 100, 100);
        stroke(110);
        if (millis()%1500 > 500) line(102 + textWidth(textEdit), 82, 102 + textWidth(textEdit), 102);
        fill(0);
        rect(290, 80, 39, 30);
        fill(150, 0, 150, 70);
        if (290 <= mouseX && mouseX <= 329 && 80 <= mouseY && mouseY <= 110) {
          rect(290, 80, 39, 30);
          menE[4] = true;
        } else {
          menE[4] = false;
        }
        noStroke();
        fill(250);
        textFont(font1,19);
        text("->", 300, 103);
      }
    } else if (menInd == 20 || menInd == 50) {
      stroke(110);
      fill(0);
      rect(135, 40, 440, 200);
      pushMatrix();  // Esto va dentro de una scrollbar. Tengo que redibujo para hacer algo tipo máscara.
      translate(0,scrllBarAC);
      if (numConcDistintos != 0) {
        if (numConcDistintos%2 == 0) {
          for (int n = 0; n < numConcDistintos/2; n++) {
            stroke(110);
            fill(0);
            rect(150, 50+40*n, 200, 30);
            rect(150+210, 50+40*n, 200, 30);
            stroke(110);
            fill(150, 0, 150, 70);
            if (150 <= mouseX && mouseX <= 350 && 50+40*n + scrllBarAC <= mouseY && mouseY <= 80+40*n + scrllBarAC && 40 < mouseY && mouseY < 195) {
              rect(150, 50+40*n, 200, 30);
              menE[2*n+5] = true;
            } else {
              menE[2*n+5] = false;
            } if (360 <= mouseX && mouseX <= 560 && 50+40*n + scrllBarAC <= mouseY && mouseY <= 80+40*n + scrllBarAC && 40 < mouseY && mouseY < 195) {
              rect(150+210, 50+40*n, 200, 30);
              menE[2*n+6] = true;
            } else {
              menE[2*n+6] = false;
            }
            noStroke();
            fill(250);
            textFont(font1,19);
            text(concBdD[2*n], 160, 72+40*n);    // If textWidth(concBdD[]) >= 180, cambio concBdD para ponerle puntos suspensivos.
            text(concBdD[2*n+1], 160+210, 72+40*n);
          }
        } else {
          for (int n = 0; n < numConcDistintos/2 + 1; n++) {
            stroke(110);
            fill(0);
            rect(150, 50+40*n, 200, 30);
            if (n != numConcDistintos/2) rect(150+210, 50+40*n, 200, 30);
            stroke(110);
            fill(150, 0, 150, 70);
            if (150 <= mouseX && mouseX <= 350 && 50+40*n + scrllBarAC <= mouseY && mouseY <= 80+40*n + scrllBarAC && 40 < mouseY && mouseY < 195) {
              rect(150, 50+40*n, 200, 30);
              menE[2*n+5] = true;
            } else {
              menE[2*n+5] = false;
            } if (n != numConcDistintos/2) if (360 <= mouseX && mouseX <= 560 && 50+40*n + scrllBarAC<= mouseY && mouseY <= 80+40*n + scrllBarAC && 40 < mouseY && mouseY < 195) {
              rect(150+210, 50+40*n, 200, 30);
              menE[2*n+6] = true;
            } else {
              menE[2*n+6] = false;
            }
            noStroke();
            fill(250);
            textFont(font1,19);
            text(concBdD[2*n], 160, 72+40*n);
            if (n != numConcDistintos/2) text(concBdD[2*n+1], 160+210, 72+40*n);
          }
        }
      }
      popMatrix();
      noStroke();
      fill(0);
      rect(0, 0, width, 40);
      rect(130, 196, width, 200);
      stroke(110);
      line(135, 40, 575, 40);
      line(135, 80, 135, 240);
      line(575, 80, 575, 240);
      line(135, 240, 575, 240);
      noStroke();
      fill(250);
      textFont(font1,21);
      text("Añadir gasto nuevo",105,30);
      textFont(font1,17);
      text("Concepto:", 45, 70);
      text("Base:", 45, 100);
      text("Tipo IVA:", 45, 140);
      text("Capítulo:", 45, 170);
      stroke(110);
      fill(0);
      line(140, 196, 565, 196);
      rect(465, 202, 100, 30);
      rect(144, 202, 270, 30);
      stroke(110);
      fill(150, 0, 150, 70);
      if (465 <= mouseX && mouseX <= 565 && 202 <= mouseY && mouseY <= 232) {
        rect(465, 202, 100, 30);
        menE[0] = true;
      } else {
        menE[0] = false;
      } if (menInd == 20) if (144 <= mouseX && mouseX <= 414 && 202 <= mouseY && mouseY <= 232) {
        rect(144, 202, 270, 30);
        menE[1] = true;
      } else {
        menE[1] = false;
      }
      noStroke();
      fill(250);
      textFont(font1,19);
      text("Volver", 487, 225);
      if (menInd == 20) {
        text("Añadir nuevo concepto", 176, 225);
      } else if (menInd == 50) {
        text(textEdit, 155, 225);
        stroke(110);
        if (millis()%1500 > 500) line(157 + textWidth(textEdit), 207, 157 + textWidth(textEdit), 227);
        fill(0);
        rect(420, 202, 39, 30);
        fill(150, 0, 150, 70);
        if (420 <= mouseX && mouseX <= 459 && 202 <= mouseY && mouseY <= 232) {
          rect(420, 202, 39, 30);
          menE[1] = true;
        } else {
          menE[1] = false;
        }
        noStroke();
        fill(250);
        textFont(font1,19);
        text("->", 430, 225);
      }
      noStroke();  // scrollbar
      fill(250);
      if (numConcDistintos > 6) {
        if (scrllBarAC != 0) {
          if (568 <= mouseX && mouseX <= 582 && 50 <= mouseY && mouseY <= 60) {
            triangle(566, 62, 584, 62, 575, 48);
            menE[2] = true;
          } else {
            triangle(568, 60, 582, 60, 575, 50);
            menE[2] = false;
          }
        } else {
          menE[2] = false; 
        }
        if (!scrllBajo) {
          if (568 <= mouseX && mouseX <= 582 && 180 <= mouseY && mouseY <= 190) {
            triangle(566, 178, 584, 178, 575, 192);
            menE[3] = true;
          } else {
            triangle(568, 180, 582, 180, 575, 190);
            menE[3] = false;
          }
        } 
        if (numConcDistintos%2 == 0) {
          scrllBarMap = map(scrllBarAC, 0, 166-(60+40*(numConcDistintos/2 - 1)), 70, 170);
        } else {
          scrllBarMap = map(scrllBarAC, 0, 166-(60+40*(numConcDistintos/2)), 70, 170);
        }
        if (567 <= mouseX && mouseX <= 583 && scrllBarMap-8 <= mouseY && mouseY <= scrllBarMap+8) {
          ellipse(575, scrllBarMap, 10, 10);
          menE[4] = true;
        } else {
          ellipse(575, scrllBarMap, 8, 8);
          menE[4] = false;
        }
      }
    } else if (menInd == 21) {
      stroke(110);
      fill(0);
      rect(35, 45, 530, 140);
      noStroke();
      fill(250);
      textFont(font1,19);
      text("Debe añadir un concepto primero.", 155, 90);
      text("Click para continuar.", 205, 160);
    } else if (menInd == 22) {
      stroke(110);
      fill(0);
      rect(500, 78, 50, 27);
      rect(500, 105, 50, 27);
      rect(500, 132, 50, 27);
      rect(500, 159, 50, 27);
      stroke(110);
      fill(150, 0, 150, 70);
      if (500 <= mouseX && mouseX <= 550 && 78 <= mouseY && mouseY < 105) {
        rect(500, 78, 50, 27);
        menE[0] = true;
      } else {
        menE[0] = false;
      } if (500 <= mouseX && mouseX <= 550 && 105 <= mouseY && mouseY < 132) {
        rect(500, 105, 50, 27);
        menE[1] = true;
      } else {
        menE[1] = false;
      } if (500 <= mouseX && mouseX <= 550 && 132 <= mouseY && mouseY < 159) {
        rect(500, 132, 50, 27);
        menE[2] = true;
      } else {
        menE[2] = false;
      } if (500 <= mouseX && mouseX <= 550 && 159 <= mouseY && mouseY < 186) {
        rect(500, 159, 50, 27);
        menE[3] = true;
      } else {
        menE[3] = false;
      }
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
      text("A", 520, 98);
      text("B", 520, 125);
      text("C", 520, 152);
      text("D", 520, 179);
      if (!ANGasto[3].equals("")) text(ANGasto[3], 140, 70);
      if (!ANGasto[4].equals("")) text(ANGasto[4], 100, 100);
      if (!ANGasto[5].equals("")) text(ANGasto[5], 520, 70);
      if (!ANGasto[6].equals("")) text(ANGasto[6], 130, 140);
      if (!ANTotal.equals("")) text(ANTotal, 395, 140);
      if (!ANIVA.equals("")) text(ANIVA, 230, 140);
    } else if (menInd == 23) {
      noStroke();
      fill(250);
      textFont(font1,17);
      if (!ANGasto[3].equals("")) text(ANGasto[3], 140, 70);
      if (!ANGasto[4].equals("")) text(ANGasto[4], 100, 100);
      if (!ANGasto[5].equals("")) text(ANGasto[5], 520, 70);
      if (!ANGasto[6].equals("")) text(ANGasto[6], 130, 140);
      if (!ANTotal.equals("")) text(ANTotal, 395, 140);
      if (!ANIVA.equals("")) text(ANIVA, 230, 140);
      stroke(110);
      fill(0);
      rect(140, 50, 170, 27);
      rect(140, 77, 170, 27);
      rect(140, 104, 170, 27);
      rect(140, 131, 170, 27);
      stroke(110);
      fill(150, 0, 150, 70);
      if (140 <= mouseX && mouseX <= 310 && 50 <= mouseY && mouseY < 77) {
        rect(140, 50, 170, 27);
        menE[0] = true;
      } else {
        menE[0] = false;
      } if (140 <= mouseX && mouseX <= 310 && 77 <= mouseY && mouseY < 104) {
        rect(140, 77, 170, 27);
        menE[1] = true;
      } else {
        menE[1] = false;
      } if (140 <= mouseX && mouseX <= 310 && 104 <= mouseY && mouseY < 131) {
        rect(140, 104, 170, 27);
        menE[2] = true;
      } else {
        menE[2] = false;
      } if (140 <= mouseX && mouseX <= 310 && 131 <= mouseY && mouseY < 158) {
        rect(140, 131, 170, 27);
        menE[3] = true;
      } else {
        menE[3] = false;
      }
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
      text("Total:", 345, 140);
      text("Capítulo:", 45, 170);
      text("Volver", 370, 223);
      text("Introducir", 480, 223);
      text("Base", 160, 70);
      text("IVA incluido", 160, 97);
      text("Base/3", 160, 124);
      text("IVA incluido/3", 160, 151);
    }
  }
}

void mouseClicked() { 
  if (menInd == 0) {
    if (menE[0]) {  // Ver Gastos.
    } else if (menE[1]) {  // Añadir gasto.
      menInd = 2;
      menE[1] = false;
      for (byte b = 0; b < 9; b++) ANGasto[b] = "";
    } else if (menE[2]) {  // Producir pdf (Menú para elegir).
    } else if (menE[3]) {  // Nuevo libro de gastos (Otro menú). Esta parte la dejo para el final.
    }
  } else if (menInd == 2) {
    if (menE[0]) { // Concepto. Abrir Menú.
      carga();
      if (numGastos != 0 && cargaCorrecta) ConceptosPorFrecuencia();
      scrllBarAC = 0;
      textEdit = "";
      menInd = 20;
    } else if (menE[1]) {  // Clase.
      if (ANGasto[3].equals("")) {  // Error.
        menInd = 21;
      } else {  // Clase del concepto. Otro menú, también. 
        menInd = 22;
      }
      menE[1] = false;
    } else if (menE[2]) {  // Base.
      if (ANGasto[3].equals("")) {  // Error.
        menInd = 21;
      } else {        // Abre menú y termina en editor.
        menInd = 23;
      }
      menE[2] = false;
    } else if (menE[3]) {
      // Fecha. Menú.
    } else if (menE[4]) {  // Tipo IVA. Descartado. Lo dejo así por no hacer ningún desplazamiento.
    } else if (menE[5]) {  // Total. Descartado.
    } else if (menE[6]) {
      // Capítulo. Menú.
    } else if (menE[7]) { // Volver al inicio.
      menInd = 0;
      menE[7] = false;
    } else if (menE[8]) {
      // Introducir: Verifica los datos de todos los apartados y añade el gasto.
    }
  } else if (menInd == 20 || menInd == 50) {
    if (menE[0]) { // Volver al menú de añadir gasto.
      menInd = 2;
      menE[0] = false;
    } else if (menE[1]) {  // Nuevo concepto. Mandar a editor de texto.
      if (menInd == 20) {
        menInd = 50;
      } else {  // Introducir nuevo concepto.
        ANGasto[3] = textEdit;
        ANGasto[5] = "A";
        if (!ANGasto[4].equals("")) {
          ANTotal = "";
          ANIVA = "";
          ANGasto[4] = "";
        }
        menInd = 2;
      }
      menE[1] = false;
    } else if (menE[2]) {  // ScrollBar arriba.
      scrllBarAC += 20;
      scrllBajo = false;
      if (scrllBarAC > 0) scrllBarAC = 0;
    } else if (menE[3]) {  // ScrollBar abajo.
      scrllBarAC -= 20;
      if (numConcDistintos%2 == 0) {
        if (scrllBarAC < 166-(60+40*(numConcDistintos/2 - 1))) {
          scrllBarAC = 166-(60+40*(numConcDistintos/2 - 1));
          scrllBajo = true;
        }
      } else {
        if (scrllBarAC < 166-(60+40*(numConcDistintos/2))) {
          scrllBarAC = 166-(60+40*(numConcDistintos/2));
          scrllBajo = true;
        }
      }
    } else if (menE[4]) {  // ScrollBar cuerpo. Aquí nada.
    } else {
      int nu = 0;
      for (int n = 0; n < numConcDistintos; n++) {
        if (menE[5+n]) {  // Conceptos número n en n+5. Aquí tengo que poner un bucle for.
          ANGasto[3] = concBdD[n];
          ANGasto[5] = claseDominante(concBdD[n]);
          if (ANGasto[5].equals("A")) {
            ANGasto[6] = "21%";
          } else if (ANGasto[5].equals("B")) {
            ANGasto[6] = "10%";
          } else if (ANGasto[5].equals("C")) {
            ANGasto[6] = "4%";
          } else if (ANGasto[5].equals("D")) {
            ANGasto[6] = "0%";
          }
          if (!ANGasto[4].equals("")) {
            ANTotal = "";
            ANIVA = "";
            ANGasto[4] = "";
          }
          menInd = 2;
          menE[5+n] = false;
        } else {
          nu++; 
        }
      }
      if (menInd == 50) if (nu == numConcDistintos) if (!(144 <= mouseX && mouseX <= 414 && 202 <= mouseY && mouseY <= 232)) menInd = 20;
    }
  } else if (menInd == 21) {
    menInd = 2;
  } else if (menInd == 22) {  // Cambio de clase.
    if (menE[0]) {  // A.
      ANGasto[5] = "A";
      ANGasto[6] = "21%";
    } else if (menE[1]) {  // B.
      ANGasto[5] = "B";
      ANGasto[6] = "10%";
    } else if (menE[2]) {  // C.
      ANGasto[5] = "C";
      ANGasto[6] = "4%";
    } else if (menE[3]) {  // D.
      ANGasto[5] = "D";
      ANGasto[6] = "0%";
    }
    if (!ANGasto[4].equals("")) {
      ANTotal = "";
      ANIVA = "";
      ANGasto[4] = "";
    }
    menInd = 2;
  } else if (menInd == 23) {  // Menú para elegir el tipo de base a insertar.
    byte c = 0;
    for (byte b = 0; b < 4; b++) if (!menE[b]) c++;
    if (c == 4) {
      menInd = 2;
    } else {
      textEdit = "";
      menInd = 24;
    }
  } else if (menInd == 24) {  // Menú de insertar base.
    if (menE[4]) {        // Introduzco los datos.
      if (textEdit.equals("")) {
        ANTotal = "";
        ANIVA = "";
        ANGasto[4] = "";
      } else {
        float ba = float(textEdit);
        float iv = float(ANGasto[6].substring(0,ANGasto[6].length()-1));
        iv = iv/100f;
        if (menE[0]) {          // Base.
        } else if (menE[1]) {   // IVA incluido.
          ba = ba/(1f+iv);
        } else if (menE[2]) {   // Base/3.
          ba = ba/3f;
        } else if (menE[3]) {   // Iva incluido/3.
          ba = ba/(1f+iv);
          ba = ba/3f;
        }
        ANTotal = nfc(ba*(1+iv),2);
        ANIVA = nfc(ba*iv,2);
        ANGasto[4] = nfc(ba,2);
      }
      menInd = 2;
      menE[4] = false;
    } else {
      if (!(95 <= mouseX && mouseX <= 330 && 82 <= mouseY && mouseY <= 109)) {
        for (byte b = 0; b < 4; b++) menE[b] = false;
        menInd = 2;
      }
    }
  }
}

void mouseWheel (MouseEvent event) {
  if (scrllBarAC <= 0) {
    scrllBarAC -= 7*event.getCount();
    if (scrllBarAC > 0) scrllBarAC = 0; 
    if (event.getCount() > 0) {
      if (numConcDistintos != 0) {
        if (numConcDistintos > 6) {
          if (numConcDistintos%2 == 0) {
            if (scrllBarAC < 166-(60+40*(numConcDistintos/2 - 1))) {
              scrllBarAC = 166-(60+40*(numConcDistintos/2 - 1));
              scrllBajo = true;
            }
          } else {
            if (scrllBarAC < 166-(60+40*(numConcDistintos/2))) {
              scrllBarAC = 166-(60+40*(numConcDistintos/2));
              scrllBajo = true;
            }
          }
        } else {
          scrllBarAC = 0;
        }
      }
    } else {
      scrllBajo = false;
    }
  }
}

void mouseDragged () {
  if (menInd == 20) {
    if (menE[4]) {
      if (numConcDistintos%2 == 0) {
        scrllBarAC = map(mouseY, 70, 170, 0, 166-(60+40*(numConcDistintos/2 - 1)));
        if (scrllBarAC > 0) scrllBarAC = 0;
        if (scrllBarAC < 166-(60+40*(numConcDistintos/2 - 1))) {
          scrllBarAC = 166-(60+40*(numConcDistintos/2 - 1));
          scrllBajo = true;
        } else {
          scrllBajo = false;
        }
      } else {
        scrllBarAC = map(mouseY, 70, 170, 0, 166-(60+40*(numConcDistintos/2)));
        if (scrllBarAC > 0) scrllBarAC = 0;
        if (scrllBarAC < 166-(60+40*(numConcDistintos/2))) {
          scrllBarAC = 166-(60+40*(numConcDistintos/2));
          scrllBajo = true;
        } else {
          scrllBajo = false;
        }
      }
    }
  }
}

void keyPressed() {
  if (menInd == 50) {
    if ((key >= 32 && key < 250) && key != 95 && key !=168 && key != 180) {
      letter = key;
      if (tild) {
        if (key == 65) key = 193;
        if (key == 69) key = 201;
        if (key == 73) key = 205;
        if (key == 79) key = 211;
        if (key == 85) key = 218;
        if (key == 97) key = 225;
        if (key == 101) key = 233;
        if (key == 105) key = 237;
        if (key == 111) key = 243;
        if (key == 117) key = 250;
        tild = false;
      }
      if (umlaut) {
        if (key == 85) key = 220;
         if (key == 117) key = 252;
         umlaut = false;
      }
      if (textWidth(textEdit) <= 240) textEdit = textEdit + key;
    }
    if (key == 168) umlaut = true;
    if (key == 180) tild = true;
    if (key == ENTER) {    // Introduce nuevo concepto.
      ANGasto[3] = textEdit;
      ANGasto[5] = "A";
      ANGasto[6] = "21%";
      if (!ANGasto[4].equals("")) {
        ANTotal = "";
        ANIVA = "";
        ANGasto[4] = "";
      }
      menInd = 2;
    }
  } else if (menInd == 24) {
    if (key >= 48 && key <= 57) {
      letter = key;
      if (textWidth(textEdit) <= 180) textEdit = textEdit + key;
    } else if (key == 44 || key == 46 || key == 39)  {
      key = 46;
      boolean b = false;
      if (textEdit.length() >= 1) {
        for (int i = 0; i < textEdit.length(); i++) if (textEdit.charAt(i) == '.') b = true;
        if (!b && textWidth(textEdit) <= 240) textEdit = textEdit + key;
      }
    } else if (key == 45) {
      if (textEdit.length() == 0) textEdit = textEdit + key;
    }
    if (key == ENTER) {    // Introduce la base.
      if (textEdit.equals("")) {
        ANTotal = "";
        ANIVA = "";
        ANGasto[4] = "";
      } else {
        float ba = float(textEdit);
        float iv = float(ANGasto[6].substring(0,ANGasto[6].length()-1));
        iv = iv/100f;
        if (menE[0]) {          // Base.
        } else if (menE[1]) {   // IVA incluido.
          ba = ba/(1f+iv);
        } else if (menE[2]) {   // Base/3.
          ba = ba/3f;
        } else if (menE[3]) {   // Iva incluido/3.
          ba = ba/(1f+iv);
          ba = ba/3f;
        }
        ANTotal = nfc(ba*(1+iv),2);
        ANIVA = nfc(ba*iv,2);
        ANGasto[4] = nfc(ba,2);
        for (byte be = 0; be < 4; be++) menE[be] = false;
      }
      menInd = 2;
    }
  }
  if (menInd == 24 || menInd == 50) {
    if (key == BACKSPACE) {
      if (textEdit.length() >= 1) {
        ch1 = new char[textEdit.length()-1];
        for (int i = 0; i < textEdit.length()-1; i++) ch1[i] = textEdit.charAt(i);
        textEdit = new String(ch1);
      } else if (textEdit.equals("")) textEdit = "";
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

void carga() {
  DatosBdD = loadStrings("BdD.dat");
  if (DatosBdD != null) for (int i = 0; i < DatosBdD.length; i++) GastosBdD[i] = split(DatosBdD[i], '_');
  numGastos = DatosBdD.length;
  byte c = 0;
  if (GastosBdD[0].length == 9) for (int i = 0; i < 9; i++) if (!GastosBdD[0][i].equals("")) c++;
  if (c == 9) cargaCorrecta = true;
}

void ConceptosPorFrecuencia() {
  String[] conc = new String[numGastos];
  int[] concF = new int[numGastos];
  int n = 0;
  for (int i = 0; i < numGastos; i++) {
    if (n == 0) {
      conc[0] = GastosBdD[0][3];
      concF[0] = 1;
      n++;
      for (int j = 1; j < numGastos; j++) if (GastosBdD[0][3].equals(GastosBdD[j][3])) concF[0]++;
    } else {
      int m = 0;
      for (int k = 0; k < n; k++) if (conc[k].equals(GastosBdD[i][3])) m++;
      if (m == 0) {  // Si es un concepto que aparece por primera vez:
        conc[n] = GastosBdD[i][3];
        concF[n] = 1;
        if (i != numGastos-1) for (int j = i+1; j < numGastos; j++) if (GastosBdD[i][3].equals(GastosBdD[j][3])) concF[n]++;
        n++;
      }
    }
  }
  if (numGastos > 1) {
    boolean b = true;
    n = 0;
    while (b) {
      if (n == numGastos) {
        b = false;
      } else {
        if (concF[n] == 0) b = false;
      }
      n++;
    }
    n--;
    numConcDistintos = n;
  } else {
    numConcDistintos = 1;
  }
  int permut = 0;  // Ordeno;
  int permutM = 0;
  String permutMS = "";
  for (int i = 0; i < n; i++) {
    int[] concFInv= new int[n-i];
    for (int m = 0; m < n-i; m++) concFInv[m] = concF[m];
    concFBdD[i] = max(concFInv);
    for (int m = 0; m < n-i; m++) if (concFInv[m] == concFBdD[i]) {
      permut = m;
      concBdD[i] = conc[m];
    }
    permutM = concF[n-i-1];
    concF[n-i-1] = concF[permut];
    concF[permut] = permutM;
    permutMS = conc[n-i-1];
    conc[n-i-1] = conc[permut];
    conc[permut] = permutMS;
  }
}

String claseDominante(String con) {
 int nu = 0;
 int mu = 0;
 int p = 0;
 for (int i = 0; i < numGastos; i++) {
   if (GastosBdD[i][3].equals(con)) nu++;
 }
 String[] concCl = new String[nu];
 int[] concClF = new int[nu];
 for (int i = 0; i < numGastos; i++) {
   if (GastosBdD[i][3].equals(con)) {
     mu = 0;
     for (int j = 0; j < nu; j++) {
       if (GastosBdD[i][5].equals(concCl[j])) {
         concClF[j]++;
       } else {
         mu++; 
       }
     }
     if (mu == nu) {
       concCl[p] = GastosBdD[i][5];
       p++;
     }
   }
 }
 for (int i = 0; i < nu; i++) {
   if (concClF[i] == max(concClF)) p = i; 
 }
 return concCl[p];
}