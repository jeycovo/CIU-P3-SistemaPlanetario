
//Hashmap creado para almacenar los planetas con su información, el nombre del planeta será la clave
import java.util.Map;
HashMap<String,cuerpoCeleste> sistemaSolar;
//
float camaraX, camaraY, camaraZ;
PImage bg;
void setup(){
  //creamos un nuevo diccionario con los planetas y sus medidas:
  //radio, velocidad de rotacion, velocidad de translación, orbita,
  sistemaSolar = new HashMap<String,cuerpoCeleste>();
  
  /*
  
  vRotacion -> km/h
  vTraslacion -> km/h
  distanciaSol -> 10^6 km (millones de km)
  radio -> km
  */ 
  //Creamos y metemos los planetas
  size(1280,1024,P3D);
  //float radio,float radioT, float vTraslacion, float vRotacion, String centroOrbita, String dirTextura
  sistemaSolar.put("sol",new cuerpoCeleste(150,0,0,1,"sol","2k_sun.jpg"));
  sistemaSolar.put("Selenio",new cuerpoCeleste(50,450,1,2,"sol","2k_mercury.jpg"));
  sistemaSolar.put("Radon",new cuerpoCeleste(60,570,2,3,"sol","2k_venus_surface.jpg"));
  sistemaSolar.put("Tantalio",new cuerpoCeleste(70,750,3,4,"sol","2k_earth_daymap.jpg"));
  sistemaSolar.put("Iridio",new cuerpoCeleste(30,900,2,2,"sol","2k_mars.jpg"));
  sistemaSolar.put("Helio",new cuerpoCeleste(100,1250,1,5,"sol","2k_jupiter.jpg"));
  sistemaSolar.put("Polonio",new cuerpoCeleste(50,1500,2.5,8,"sol","2k_saturn.jpg"));
  
  sistemaSolar.put("Hafnio",new cuerpoCeleste(15,150,2.3,2,"Helio","2k_moon.jpg"));
  sistemaSolar.put("Escandio",new cuerpoCeleste(10,190,1.5,2,"Helio","2k_neptune.jpg"));
  sistemaSolar.put("Galio",new cuerpoCeleste(20,120,2,2,"Tantalio","2k_mercury.jpg"));

  
  //Coordenadas iniciales
  camaraX = width/2;
  camaraY = height/2;
  camaraZ = -1550;
  
  //Imagen de fondo
  bg = loadImage("2k_stars.jpg");
  
  //Ajustamos texto
  textSize(50);
}

void draw(){
//Nos situamos en medio de la pantalla
 bg.resize(width,height);
 background(bg);
 translate(camaraX,camaraY,camaraZ);
 
  textAlign(CENTER);
  for(String a: sistemaSolar.keySet()){
    cuerpoCeleste objeto = sistemaSolar.get(a);
    pushMatrix();
    objeto.traslacion();
    objeto.rotacion();
    objeto.mostrar();
    //mostramos el texto
    popMatrix();
    text(a,objeto.coordenadaX,objeto.coordenadaY+objeto.radio+40);
  }
    textAlign(LEFT);
    text("flechas de dirección: Moverse por el sistema planetario",-width+200,1200);
    text("w -  Acercar la camara",-width+200,1240);
    text("s -  Alejar la camara",-width+200,1280);
}

class cuerpoCeleste{
  float coordenadaX, coordenadaY, coordenadaZ;
  PShape formaPlaneta;
  PImage texturaPlaneta;
  String centroOrbita;
  float vRotacion, vTraslacion, radio, radioT;
  int angT = 45;
  int angR = 0;
  
  cuerpoCeleste(float radio,float radioT, float vTraslacion, float vRotacion, String centroOrbita, String dirTextura){
   this.radio = radio;
   this.vRotacion = vRotacion;
   this.vTraslacion = vTraslacion;
   
   coordenadaY = 0; 
   coordenadaX = 0; 
   coordenadaZ = 0;
   
   this.radioT = radioT;
   this.centroOrbita = centroOrbita;
   crearForma(dirTextura);
  }
  
  //Crear forma del planeta
  void crearForma(String dirTextura){
    PImage img = loadImage(dirTextura);
    formaPlaneta = createShape(SPHERE, radio);
    formaPlaneta.setTexture(img);
    formaPlaneta.setStroke(0);
  }
  
  //mostrar en el plano el objeto
  void mostrar(){
    shape(formaPlaneta);
  }
  
  //Movimiento del cuerpo celeste
  void traslacion(){
      cuerpoCeleste centro = sistemaSolar.get(centroOrbita);
      float a = centro.coordenadaX;
      float b = centro.coordenadaY;
      coordenadaX = radioT*cos(radians(angT))+a;
      coordenadaY = radioT*sin(radians(angT))+b;
      angT -= vTraslacion;
      translate(coordenadaX,coordenadaY,coordenadaZ); //<>//
    /*
    float h = coordenadaX;
    this.coordenadaX = (coordenadaX * cos(angT) - coordenadaY * sin(angT));
    this.coordenadaY = ( h * sin(angT) + coordenadaY * cos(angT));
    translate(coordenadaX,coordenadaY,coordenadaZ);
    */ //<>//
  }
  
  void rotacion(){
    rotateX(-radians(75));
    rotateY(radians(angR));
    angR+= vRotacion;
    if(angR>360){ angR = 0; }
  }
}
