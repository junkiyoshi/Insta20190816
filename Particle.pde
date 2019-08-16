class Particle 
{
  Body body;
  float size;
  float lifespan;
  boolean countDown;

  Particle(float x, float y, float s, color c) {
    size = s;
    lifespan = 255;
    makeBody(new Vec2(x, y));
  }

  void makeBody(Vec2 center) {

    CircleShape cs = new CircleShape();
    float box2dSize = box2d.scalarPixelsToWorld(size);
    cs.setRadius(box2dSize / 2);

    FixtureDef fd = new FixtureDef();
    fd.shape = cs;
    fd.density = 1;
    fd.friction = 1;
    fd.restitution = 0.5;

    BodyDef bd = new BodyDef();
    bd.type = BodyType.DYNAMIC;
    bd.position.set(box2d.coordPixelsToWorld(center));

    body = box2d.createBody(bd);
    body.createFixture(fd);
    body.setUserData(this);
  }
  
  boolean isDead()
  {
    if(lifespan < 0){
      box2d.destroyBody(body);
      return true;
    }else{
      return false;
    }
  }

  void display() {
    Vec2 pos = box2d.getBodyPixelCoord(body);

    pushMatrix();
    translate(pos.x, pos.y);
    fill(39, lifespan);
    stroke(39);
    strokeWeight(2);
    ellipse(0, 0, size, size);
    popMatrix();
    
    // lifespan -= 2;
  }
}
