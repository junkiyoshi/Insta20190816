class Obstacle
{
  Body body;
  float x, y, size;
  
  Obstacle(float x_, float y_)
  {
    x = x_;
    y = y_;
    size = 150;
    makeBody(new Vec2(x, y));
    
    waves = new ArrayList<Wave>();
  }
  
  void makeBody(Vec2 center) 
  {
    CircleShape cs = new CircleShape();
    float box2dSize = box2d.scalarPixelsToWorld(size / 2);
    cs.setRadius(box2dSize);

    BodyDef bd = new BodyDef();
    bd.type = BodyType.STATIC;
    bd.position.set(box2d.coordPixelsToWorld(center));

    body = box2d.createBody(bd);
    body.createFixture(cs, 1);
    body.setUserData(this);
  }
  
  void display()
  {
    Vec2 pos = box2d.getBodyPixelCoord(body);

    pushMatrix();
    translate(pos.x, pos.y);
    fill(39);
    noStroke();
    ellipse(0, 0, size, size);
    popMatrix();
  }
}
