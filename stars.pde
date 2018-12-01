class starz {
  float x, y, w, h;
  float r,g,b;

  starz(float x, float y, float w, float h) {
    this.x =x;
    this.y=y;
    this.w=w;
    this.h=h;
  }

  void display(float r,float g,float b) {
    fill(r, g, b);
    noStroke();
    ellipse(this.x, this.y, this.w, this.h);
  }

}