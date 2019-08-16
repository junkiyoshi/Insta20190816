class Wave
{
  PVector center;
  float radius;
  float lifespan;
  
  Wave(float x, float y, float r)
  {
    center = new PVector(x, y);
    radius = r;
    lifespan = 125;
  }
  
  void run()
  {
    update();
    display();
  }
  
  void update()
  {
    radius += 3;
    lifespan -= 1;
  }
  
  void display()
  {
    pushMatrix();
    translate(center.x, center.y);
    noFill();
    stroke(39, lifespan);
    strokeWeight(3);
    ellipse(0, 0, radius, radius);
    popMatrix();
  }
  
  boolean isDead()
  {
    if(lifespan < 0)
    {
      return true;
    }
    
    return false;
  }
}
