/**
 moving picture of painting Nihonbashi
 */
//int m = millis();
// how many images 
int qtyImages = 13;

// an array to hold images
PImage[] images = new PImage[qtyImages];

// a value to scale everything by
float scalePercent=0.55;

// the position of images
int[] posX = new int[qtyImages];
int[] posY = new int[qtyImages];

// a place to hold coordinate presets for images
Table coordinates;

//boat movement
floating b1,b2,b3;
moveforward b4;

////////////////////////////////////////////////////////////////////////////////
// SETUP

void setup () {
  size(10, 10);

  // loads and scales all the images
  initializeImages();

  // loads coordinate presents
  initializeCoordinates();

  b4 = new moveforward(); 
  b4.pos = new PVector(posX[2], posY[2]);
  //images[0].img
  b4.img = images[2];

  b1 = new floating(); 
  
  b1.pos = new PVector(posX[1], posY[1]);  
      //translate(sin(frameCount/18.)*2, 0);
      // fill(m % 255);
  b1.img=images[1];


  b2 = new floating(); 
  b2.type="people";
  b2.pos = new PVector(posX[3], posY[3]);  
      //translate(sin(frameCount/18.)*2, 0);
      // fill(m % 255);
  b2.img=images[3];
  
    b3 = new floating(); 
  b3.pos = new PVector(posX[4], posY[4]);
   b3.img=images[4];
}



////////////////////////////////////////////////////////////////////////////////
// DRAW

void draw() { 
  imageMode(CORNER);
  drawBackground();

  imageMode(CENTER);
  //for (int i = 1; i<images.length; i++) {
  //  image(images[i], posX[i], posY[i]);
  //}
  
  
 //drawBackground();
  b1.draw();
  b2.update();
  b2.draw();
  b3.draw();
  b4.set();
  whereAmI();
}


void mouseClicked(){
b2.draw();

}




////////////////////////////////////////////////////////////////////////////////
// drawBackground()

void drawBackground() {
  image(images[0], 0, 0);
}



////////////////////////////////////////////////////////////////////////////////
// initializeImages()

void initializeImages() {
  // load up all our images
  for (int i = 0; i<images.length; i++) {

    String file = "images/Nihonbashi-" + nf(i, 3)+ ".png";
    images[i] = loadImage(file);
    // resize them
    images[i].resize(int(scalePercent*images[i].width), int(scalePercent*images[i].height));
  }
  //...and our window to match it
  surface.setSize(images[0].width, images[0].height);
  // draw the backgroundImage
  drawBackground();
}

////////////////////////////////////////////////////////////////////////////////
// initializeCoordinates()

void initializeCoordinates() {

  // load the coordinates csv
  coordinates = loadTable("coordinates.csv", "csv");

  // how many rows are there?
  println(coordinates.getRowCount() + " total rows in table"); 

  for (int i = 0; i < qtyImages; i++) {

    // get the row from the table
    TableRow coordinate = coordinates.getRow(i);

    // extract the coloumn elements from the row 
    posX[i] = coordinate.getInt(0);
    posY[i] = coordinate.getInt(1);

    println("x: "+posX[i]+", y: "+posY[i]);
  }
}
