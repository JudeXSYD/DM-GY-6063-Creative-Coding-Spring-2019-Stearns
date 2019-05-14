class Floating {
  PVector pos, vel;
  PImage img;
  //String type = "boat";
  float st= random(0, 50);

  boolean isBoatRotating = false;
  boolean driving = false;

  float sailTime = 600.0; // how many frames should it take to get from start to finish
  float x, y, x2, y2, translateX = 0.0, translateY = 0.0; // x,y are where it actually is, x2, y2 and the end point, translateX and translateY add complex motion
  float xStep = 0.0; 
  float yStep = 0.0; // holds the speed of boat movement based on sailTime
  float rotateAngle = 0;
  float nx = random(1);
  float ny = random(1);
  float nStep = 0.025;
  //noise
  float nAmt = 1.5;
  //up-down
  float angle = 0;
  float angleStep = 0.02;
  float amp = 5;
  //left-right
  float rockAmt =0.015;
  float r = 0;
  float rstep = -0.01;
  String TYPE = "BOAT";

  //constructor
  Floating( float _x, float _y, String _type, PImage _img) {

    pos = new PVector(_x, _y);
    TYPE = _type;
    img = _img;
  }


  //Floating() {
  //  //pos = new PVector(0, 0);
  //  vel = new PVector(2, 1);
  //  //for boats float at different random starttime
  //  st = random(0, 100);
  //}

  void display() {
    // use the image of the boat
    imageMode(CENTER);
    pushMatrix();
    //translateX += xStep;
    //translateY += yStep;
    translate(pos.x+translateX,pos.y+ translateY);
    rotate(rotateAngle);  
    image(img, 0,0 );
    // reset the translation
    translateX = 0;
    translateY = 0;
    popMatrix();
  }

  void move() {

    switch(TYPE) {
    case "BOAT":
      if (isBoatRotating==false){
        this.leftright();
      }
    
      this.bob();
      this.shake();
      break;

    case"BOAT2":
      this.updown();
      break;
      
     

    case"DRIVE":
      this.driving(430, 560);
      //this.disappear();
      this.updown();
      break;


    case"BACK":
      this.backforward();
      break; 

    case "POEPLE":
      this.mirror();

      break;
      //println("TYPE: "+TYPE+" not recognized");
    }
  }

  ////////////////////////////////////////////////////////////////////////////////
  //break down movement

  void backforward() {
    pushMatrix();
    translate(sin(st + frameCount/80.)*5, 0);
    image(img, pos.x, pos.y);
    popMatrix();
  }

  void mirror() {
    image(img, pos.x, pos.y);
  }


  void driving(float x2, float y2) {
    //println("x2: ", x2, "; y2: ", y2, "; pos.x: ", pos.x, "; pos.y: ", pos.y, "; x: ", x, "; pos.y: ", y);
    if (abs(x2 - pos.x) <= 1 && abs(y2 - pos.y) <= 1) {
      //xStep = (pos.x - x)/sailTime;
      //yStep = (pos.y - y)/sailTime;
    } else {
      xStep = (x2 - x)/sailTime;
      yStep = (y2 - y)/sailTime;
      pos.x += xStep;
      pos.y += yStep;
    }
    pushMatrix();
    translate(0, sin(st + frameCount/33.)*3);

    popMatrix();
  }
  //sin(frameCount/18.)/3


  void disappear() {
    pos.x +=0.3;
    pos.y +=sin(frameCount/18.) -0.3;
  }

  //void sail() {

  //  if (x!=x2 && y!= y2) {

  //    x += xStep;
  //    y += yStep;
  //  }
  //}

  void bob() {

    // adds up and down movement to the boat
    translateY += amp * sin(st + angle);
    angle+=angleStep;
  }

  void shake() {

    // adds a random movement to boat
    translateX += nAmt * noise ( nx );
    translateY += nAmt * noise ( ny );
    nx += nStep;
    ny += nStep;
  }

  void leftright() {

    rotateAngle = rockAmt * cos(st + angle);
  }


  //pos.x +=1;
  //pos.y +=sin(st + frameCount/18.)-1;


  void updown() {
    pushMatrix();
    translate(0, sin(st + frameCount/33.)*3);
    image(img, pos.x, pos.y);
    popMatrix();
  }

  void rotateboat() {
    //println(rotateAngle);
    rotateAngle+=rstep;
    //pushMatrix();
    //imageMode(CENTER);
    //translate(pos.x, pos.y);
    //rotate(r);
    //r+= rstep;
    //image(img, 0, 0);

    //popMatrix();
  }



  // }


  ////////////////////////////////////////////////////////////////////////////////
  //detect the images
  boolean isMouseInRange () {

    if ((mouseX > (pos.x - img.width/2)) && (mouseX<(pos.x+img.width/2)) 
      && (mouseY>(pos.y-img.height/2)) && (mouseY<(pos.y+img.height/2))) {
      return true ;
    }
    return false;
  }
}
