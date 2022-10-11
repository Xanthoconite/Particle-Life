Particle[] particles;
int population = 20;
int maxTypes = 20;
color[] col;
float G = 1;

void setup() {
  size(720, 480);
  //noStroke();
  stroke(255);
  
  // assign a random color to each particle "type"
  col = new color[maxTypes];
  for (int i = 0; i < col.length; i++) {
    col[i] = color(random(255), random(255), random(255));
  }


  // create the particles with a random position on the canvas
  particles = new Particle[population];
  for (int i = 0; i < particles.length; i++) {
    particles[i] = new Particle(random(width), random(height));
  }
}

void draw() {
  background(0);
  
  // loop through every particle for every particle
  for (Particle p : particles) {    
    for (Particle q : particles) {   
      
      // don't calculate the gravitational force of itself
      if(p != q) {
        push();
        
        // center to p's position
        translate(p.pos.x, p.pos.y);
        
        // create a copy of q so actual q isn't affected - get position relative to p
        PVector q_copy = new PVector(q.pos.x - p.pos.x, q.pos.y - p.pos.y);
        
        // calculate the force of gravity based on Newton's Law
        q_copy.setMag((float)(G * p.mass * q.mass / (Math.pow(dist(0, 0, q.pos.x, q.pos.y), 2))));
        p.applyForce(q_copy);
        
        pop();
      }
    }
    
    p.update();
    p.show();
  }
}
