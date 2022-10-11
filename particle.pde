float maxVel = 5;
float maxAcc = 1;

class Particle {
  int type;
  PVector pos, vel, acc;
  float mass;

  Particle(float x, float y) {
    this.type = floor(random(maxTypes)); // currently just affects the color and mass
    this.pos = new PVector(x, y);
    this.vel = new PVector(0, 0);
    this.acc = new PVector(0, 0);
    this.mass = map(type, 0, maxTypes-1, 12, 20);
  }

  void applyForce(PVector force) {
    this.acc.add(force.div(this.mass));
  }

  void update() {

    // constrain acceleration (the contstrain function wasn't working idk)
    if (this.acc.x > maxAcc) this.acc.x = maxAcc;
    if (this.acc.y > maxAcc) this.acc.y = maxAcc;
    if (this.acc.x < -maxAcc) this.acc.x = -maxAcc;
    if (this.acc.y < -maxAcc) this.acc.y = -maxAcc;

    // update velocity
    this.vel.add(this.acc);

    // constrain velocity
    if (this.vel.x > maxVel) this.vel.x = maxVel;
    if (this.vel.y > maxVel) this.vel.y = maxVel;
    if (this.vel.x < -maxVel) this.vel.x = -maxVel;
    if (this.vel.y < -maxVel) this.vel.y = -maxVel;

    // update position
    this.pos.add(this.vel);

    // reset acceleration
    this.acc.mult(0);

    // bounce off the walls
    if (this.pos.x > width || this.pos.x < 0) this.vel.x *= -1;
    if (this.pos.y > height || this.pos.y < 0) this.vel.y *= -1;
  }

  void show() {
    fill(col[type]);
    circle(this.pos.x, this.pos.y, this.mass);
  }
}
