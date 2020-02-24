float mov = 100;

void keyPressed(){
    switch (keyCode){
      case UP:
        camaraY -= mov;
        break;
      case DOWN:
        camaraY += mov;
        break;
      case LEFT:
        camaraX += mov;
        break;
      case RIGHT:
        camaraX -= mov;
        break;
    }
    switch (key){
      case 'w':
        camaraZ += mov;
        break;
      case 's':
        camaraZ -= mov;
        break;
    }
}
