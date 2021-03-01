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
  deginc = 20;
  text("LEFT MOUSE to add a 2d point",5,15);
  text("Press L to generate 3d model",5,30);
  strokeWeight(1);
  noFill();
  obj=createShape();
  obj.beginShape();
}
void draw() {
  if(dr){
    background(0);
    translate(mouseX,mouseY);
    shape(obj3);
  }
}

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
  
