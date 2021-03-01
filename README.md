# ProcessingRevol
Por Alejandro García Sosa
## Descripción del proyecto:
En este proyecto para la asignatura **Creando Interfaces de Usuario** (en adelante **CIU**) del cuarto curso del plan de estudios del **Grado en Ingeniería Informática** de la **ULPGC** del 2010, se ha utlizado la herramienta **Processing**.

La interfaz consiste en un fondo negro, dividido con una línea verde vertical. Al hacer click enla derecha de la línea, se añade ese punto al perfil del modelo 3d que se generará pulsando la telca **L**. El la esquina superior izquierda viene una explicación de los controles.

Al generar el modelo 3d, la línea central y las instrucciones desaparecen, y la figura generada se desplazará a donde el usuario tenga el ratón, para que pueda examinarla como desee.

## Diseño interno:
#### Setup:
```
float x,y,x2,y2;
int deginc;
PShape obj,obj3;
boolean dr;

void setup() {
  size(500,500,P3D);
  background(0);
  dr = false;
  stroke(0,255,0);
  line(width/2,0,width/2,height);
  deginc = 10;
  text("LEFT MOUSE to add a 2d point",5,15);
  text("Press L to generate 3d model",5,30);
  strokeWeight(1);
  noFill();
  obj=createShape();
  obj.beginShape();
}
```
#### Loop (Solo se activa post-modelo 3d):
```
void draw() {
  if(dr){
    background(0);
    translate(mouseX,mouseY);
    shape(obj3);
  }
}
```
En el **draw**, todo está encapsulado dentro de un if, el cual se activa tras generar el modelo 3d, ya que su única función es trasladar el modelo 3d una vez generado.

#### Generación del perfil 2d:
```
void mousePressed(){
  if(!dr){
    if(mouseX > width/2){
      if(y2 == 0){  
        x2 = 0;
        y2 = mouseY-height/2;
        obj.vertex(x2,y2,0);
      }else{
        x2 = x;
        y2 = y;
      }
      x = mouseX-width/2;
      y = mouseY-height/2;
      obj.vertex(x,y,0);
      line(mouseX,mouseY,x2+width/2,y2+height/2);
    }
  }
}
```
Al hacer click con el ratón, se añade un punto al modelo 2d, alvo que sea el primero, en cuyo caso se añade el punto que está en la misma altura, pero tocando la línea central. También se dibuja una línea que une el punto actual con el anterior.

#### Generación del modelo 3d:
```
void keyPressed(){
  if(key == 'L'|| key == 'l'){
    background(0);
    dr = true;
    obj.vertex(0,y,0);
    obj.endShape();
    obj3 = createShape();
    obj3.beginShape(TRIANGLE_STRIP);
    obj3.fill(255);
    int vertex = obj.getVertexCount();
    for(int i = 0; i < 360; i+=deginc){
      for(int j = 0; j < vertex; j++){
         PVector v = obj.getVertex(j);
         PVector rot = (rotate(v,i));
         PVector rot2 = (rotate(v,i+deginc));
         obj3.vertex(rot.x, rot.y, rot.z);
         obj3.vertex(rot2.x, rot2.y, rot2.z);
      }
    }
    translate(width/2,height/2);
    obj3.endShape();
    shape(obj3);
  }
}

PVector rotate(PVector v, float theta){
  PVector rot = new PVector();
  rot.x = v.x*cos(radians(theta))-v.z*sin(radians(theta));
  rot.z = v.x*sin(radians(theta))+v.z*cos(radians(theta));
  rot.y = v.y;
  return rot;
}
```
Al generar el modelo 3d, se añade un punto que toca la linea central a la misma altura que el último punto introducido. También se genera cada vértice utilizando la fórmula de rotación 3d.

Los valores internos están desplazadon en -width/2 y -height/2, de forma que al trasladar el modelo al centro de la pantalla, el modelo quede centrado, y su tamaño no aumente, ya que si no se hace el desplazamiento, aunque en el **draw** se desplaze al ratón, el modelo queda muy grande, y no cabe en la pantalla.

## Diseño de la interfaz:
Se ha decidido mantener una estética simple, utilizando como base el diseño propuesto en el guión de las prácticas.

## Bibliografía:
- Diapositivas de la asignatura de CIU.
- Guión de Prácticas de la asignatura CIU.
- https://www.openprocessing.org/
- https://processing.org/tutorials/
