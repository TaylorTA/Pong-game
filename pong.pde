int keyScore = 0;
int mouseScore = 0;
float ballX = 250;
float ballY = 250;
float leftPX = 10;
float leftPY = 230;
float rightPX = 485;
float rightPY = 230;
final int BALL_DIAM = 10;
final int P_WIDTH = 10;
final int P_HIGHT = 40;
int pSpeed = 3;
float ballSpeed = 2;
float direction;
float vx;
float vy;
final float MIN_SPEED = 1;
final float MAX_SPEED = 3;
boolean gameOver = false;

void setup(){
  size(500,500);
  
  // generate initial direction and speed
  do{
    direction = random(0,PI*2); 
    vx = ballSpeed * cos(direction);
    vy = ballSpeed * sin(direction);
  }while(abs(vx)<ballSpeed/2);
}

void draw(){
  if(!gameOver){
    playGame();
  }
}

void playGame(){
  
  // move paddles
  if(keyPressed){
    if(keyCode == UP){
      leftPY -= pSpeed;
    }else if(keyCode == DOWN){
      leftPY += pSpeed;
    }
  }
  if(mousePressed){
    if(mouseButton == LEFT){
      rightPY += pSpeed;
    }else if(mouseButton == RIGHT){
      rightPY -= pSpeed;
    }
  }
  
  //move the ball
  ballX += vx;
  ballY += vy;
  
  //Make the ball bounce off the top and bottom
  if(ballY < BALL_DIAM/2 || ballY > 500 - BALL_DIAM/2){
    vy *= -1;
  }
  
  //Make the ball bounce off the paddles.
  //hit left paddle
  if((abs(leftPX + P_WIDTH - ballX) < 1) && ballY > leftPY && ballY < leftPY + P_HIGHT){
    // get new speed
    float pCenter = leftPY + P_HIGHT/2;
    float distance = abs(pCenter - ballY);
    ballSpeed = (MAX_SPEED - MIN_SPEED)*distance/(P_HIGHT/2) + MIN_SPEED;
    
    //get new direction
    do{
      direction = random(0,PI*2); 
      vx = ballSpeed * cos(direction);
      vy = ballSpeed * sin(direction);
    }while(vx<ballSpeed/2);
  }else 
  // hit right paddle
  if(abs(ballX - rightPX) < 1 && ballY > rightPY && ballY < rightPY + P_HIGHT){
    // get new speed
    float pCenter = leftPY + P_HIGHT/2;
    float distance = abs(pCenter - ballY);
    ballSpeed = (MAX_SPEED - MIN_SPEED)*distance/(P_HIGHT/2) + MIN_SPEED;
    println(ballSpeed);
    
    //get new direction
    do{
      direction = random(0,PI);
      vx = ballSpeed * cos(direction);
      vy = ballSpeed * sin(direction);
    }while(vx>0 || abs(vx)<ballSpeed/2);
  }
  
  // increase score
  if(ballX<leftPX){
    mouseScore++;
    
    // start new round
    ballX = width/2;
    ballY = height/2;
    do{
      direction = random(0,PI*2); 
      vx = ballSpeed * cos(direction);
      vy = ballSpeed * sin(direction);
    }while(abs(vx)<ballSpeed/2);
  } else if(ballX > rightPX + P_WIDTH){
    keyScore++;
    
    // start new round
    ballX = width/2;
    ballY = height/2;
    do{
      direction = random(0,PI*2); 
      vx = ballSpeed * cos(direction);
      vy = ballSpeed * sin(direction);
    }while(abs(vx)<ballSpeed/2);
  }
  
  if(mouseScore == 11 || keyScore == 11){
    gameOver = true;
  }
  
  // draw the game
  drawGame();
}

void drawGame(){
  background(255);
  fill(255,0,0);
  ellipse(ballX,ballY,BALL_DIAM,BALL_DIAM);
  fill(0,0,255);
  rect(leftPX,leftPY,P_WIDTH,P_HIGHT);
  rect(rightPX,rightPY,P_WIDTH,P_HIGHT);
  fill(0);
  drawScore();
}

void drawScore(){
  textSize(20);
  String toPrint = "Keyboard: " + keyScore;
  text(toPrint, width/4-textWidth(toPrint)/2, 50);
  toPrint = "Mouse: " + mouseScore;
  text(toPrint, width*3/4-textWidth(toPrint)/2, 50);
}
