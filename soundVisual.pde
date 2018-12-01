import processing.sound.*;
import peasy.*;
float angle, angleX, angleY;
Table table;
float r = 150;
PImage sphere;
PShape sphere2;
SoundFile sample;
Amplitude rms;
float scale = 5.0;
float smoothFactor = 0.25;
float sum;
float sc=0.02, sc2=0.02, sc3=0.02;
ArrayList<starz> s3 = new ArrayList<starz>();
float re = 255, g= 0, b=255;
PeasyCam camera;

void setup() {
  fullScreen(P3D);
  camera = new PeasyCam(this, width*0.5, height*0.5, 0, 1550);
  sphere = loadImage("bg2.jpg");
  //where on the sphere will the rectangles be located
  table = loadTable("randomData.csv", "header");

  noStroke();
  sphere2 = createShape(SPHERE, r);
  sphere2.setTexture(sphere);

  //You can play a different song by changing the name below
  sample = new SoundFile(this, "3.mp3");
  sample.play();

  // Create and patch the rms tracker
  rms = new Amplitude(this);
  rms.input(sample);
}

void draw() {
  // comment the background line below to see a cool paintting effect
 //background(51);
  if (random(1) < 0.1) {
    s3.add(new starz(random(0, 3000), random(0, 3000), 3, 3));
  }


  for (int i = s3.size()-1; i >= 0; i--) {
    starz f = s3.get(i);
    f.display(re, g, b);
  }

  translate(width*0.5, height*0.5);



  rotateZ(angle);
  rotateY(angleY);
  rotateX(angleX);
  angle += sc;
  angleX += sc2;
  angleY += sc3;
  float rand = random(0, 255);
  float rand2 = random(0, 255);
  float rand3 = random(0, 255);
  lights();
  //fill(200);
  noStroke();

  shape(sphere2);

  sum += (rms.analyze() - sum) * smoothFactor;  

  float rmsScaled = sum * (height/2) * scale;

  for (TableRow row : table.rows()) {
    float yaxis = row.getFloat("yaxis");
    float xaxis = row.getFloat("xaxis");
    float theta = radians(yaxis) + PI/2;
    float phi = radians(xaxis) + PI;
    float x = r * sin(theta) * cos(phi);
    float y = -r * sin(theta) * sin(phi);
    float z = r * cos(theta);
    PVector newpos = new PVector(x, y, z);
    PVector xvector= new PVector(1, 0, 0);
    float angleb = PVector.angleBetween(xvector, newpos);
    PVector iaxis = xvector.cross(newpos);

    pushMatrix();
    translate(x, y, z);
    rotate(angleb, iaxis.x, iaxis.y, iaxis.z);
    fill(rand, rand2, rand3);
    box(rmsScaled, 5, 5);
    popMatrix();
  }
}

void mousePressed() {
  re = random(0, 255);
  g = random(0, 255);
  b = random(0, 255);
}

void keyPressed() {
  if (key == 'r')
    s3.remove(s3.size()-1);
  if (keyCode == UP)
    sc3 += 0.001;
  if (keyCode == DOWN)
    sc3 -= 0.001;
  if (keyCode == RIGHT)
    sc2 += 0.001;
  if (keyCode == LEFT)
    sc2 -= 0.001;
}