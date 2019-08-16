import java.util.*;
import shiffman.box2d.*;
import org.jbox2d.common.*;
import org.jbox2d.dynamics.joints.*;
import org.jbox2d.collision.shapes.*;
import org.jbox2d.collision.shapes.Shape;
import org.jbox2d.common.*;
import org.jbox2d.dynamics.*;
import org.jbox2d.dynamics.contacts.*;
import ddf.minim.*;

Box2DProcessing box2d;
ArrayList<Particle> particles;
Obstacle[] obstacles;
ArrayList<Wave> waves;

Minim minim;
AudioSample[] pianos;

void setup()
{
  size(512, 512);
  frameRate(30);
  colorMode(HSB);
  
  box2d = new Box2DProcessing(this);
  box2d.createWorld();
  box2d.setGravity(0, -20);
  box2d.listenForCollisions();
    
  particles = new ArrayList<Particle>();
  obstacles = new Obstacle[3];
  obstacles[0] = new Obstacle(width / 2, height / 2);
  obstacles[1] = new Obstacle(width / 6 * 1, height / 6 * 4);
  obstacles[2] = new Obstacle(width / 6 * 5, height / 6 * 4);
  
  minim = new Minim(this);
  pianos = new AudioSample[8];
  pianos[0] = minim.loadSample("pianoA.mp3");
  pianos[1] = minim.loadSample("pianoB.mp3");
  pianos[2] = minim.loadSample("pianoC.mp3");
  pianos[3] = minim.loadSample("pianoC2.mp3");
  pianos[4] = minim.loadSample("pianoD.mp3");
  pianos[5] = minim.loadSample("pianoE.mp3");
  pianos[6] = minim.loadSample("pianoF.mp3");
  pianos[7] = minim.loadSample("pianoG.mp3");
}

void draw()
{
  box2d.step();
  background(239);
  
  for(Obstacle obs : obstacles)
  {
    obs.display();
  }
  
  if(frameCount % 60 == 1)
  {
    Particle p = new Particle(random(width * 0.2, width * 0.8), 50, 25, color(random(255), 255, 230));
    particles.add(p);
  }  
  
  Iterator<Particle> it = particles.iterator();
  while(it.hasNext())
  {
    Particle p = it.next();
    p.display();
    
    if(p.isDead())
    {
      it.remove();
    }
  }
  
  Iterator<Wave> it_wave = waves.iterator();
  while(it_wave.hasNext())
  {
    Wave w = it_wave.next();
    w.run();
    if(w.isDead())
    {
      it_wave.remove();
    }
  }
}

void stop(){
  
  minim.stop();
  for(int i = 0; i < pianos.length; i++){
    
    pianos[i].close();
  }
}

void beginContact(Contact cp)
{  
  Fixture f1 = cp.getFixtureA();
  Fixture f2 = cp.getFixtureB();
  
  Body b1 = f1.getBody();
  Body b2 = f2.getBody();
  
  Object o1 = b1.getUserData();
  Object o2 = b2.getUserData();
  
  if(o1.getClass() == Particle.class)
  {
    Particle p = (Particle)o1;
    p.lifespan -= 30;
  }
  
  if(o2.getClass() == Particle.class)
  {
    Particle p = (Particle)o2;
    p.lifespan -= 30;
  }
  
  if(o1.getClass() == Obstacle.class)
  {
    Obstacle o = (Obstacle)o1;
    makeWave(o.x, o.y, o.size);
    
    pianos[int(random(8))].trigger(); 
    return;
  }
  else if(o2.getClass() == Obstacle.class)
  {
    Obstacle o = (Obstacle)o2;
    makeWave(o.x, o.y, o.size);
       
    pianos[int(random(8))].trigger(); 
    return;
  }
}

void makeWave(float x, float y, float size){
  
  waves.add(new Wave(x, y, size));
}
