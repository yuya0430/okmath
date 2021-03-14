Diagram d = new Diagram();
julius j = new julius();
function f = new function();

void setup(){
  size(1600,1000);
  
  j.setup(this);
  reset();
}

String result = "";;
String copy = "";
boolean k = false;
boolean CategorySelection = false;
int countOK = 0;
int fakecount = 0;
int mode = 0;
ArrayList<String> inputlist = new ArrayList<String>();
int count = 0;

void draw(){
  
  if(CategorySelection == false){
    if(mousePressed == true && 400 < mouseX  && mouseX < 750 && 400 < mouseY  &&  mouseY < 700){
       mode = 1;
       f.setup();
       CategorySelection = true;
    }
    if(mousePressed == true && 850 < mouseX  && mouseX < 1200 && 400 < mouseY  &&  mouseY < 700){
       mode = 2;
       d.setup(); 
       CategorySelection = true;
    }
  }
  
  while(k  && ((key == 'r') || (key == 'R'))){
    String s = j.draw();
    inputlist.add(s);
    result = result  + s;
    if(!result.equals(copy)){ //to show result only one times
      println(result);
      println("最後の入力：" + inputlist.get(inputlist.size()-1));
      copy = result;
    }
    keyReleased();
  }
  
  resetJudge();
  
  
  /*
  count++;
  
  if(count==0)
    result += "二次関数y=一xの二乗+三x+五";
  if(count==30)
    result += "二次関数y=一xの二乗+四x+六";
  if(count==40)
    result += "二次関数y=一xの二乗+五x+七";
  if(count==50)
    result += "二次関数y=一xの二乗+六x+八";
  if(count==60)
    result += "二次関数y=一xの二乗+七x+九";
  if(count==70)
    result += "二次関数y=-一xの二乗+六x+八";
  if(count==80)
    result += "二次関数y=-一xの二乗+五x+七";
  if(count==90)
    result += "二次関数y=-一xの二乗+四x+六";
  if(count==100)
    result += "二次関数y=-一xの二乗+三x+五";
  */
  /*
  if(count == 10)
    result = "一次関数y=一x+二";
    //result = "点(一,三)、点(四,六)を通る直線";
  if(count == 40)
    result += "点(三,七)、点(一,三)、点(二,六)を通る放物線";
  if(count == 70)
    result += "交点";
  if(count == 100)
    result += "三角形";
  println("count = "+count);
  count++;
  if(count == 130){
    result = "";
    count = 0;
  }
  
  mode = 1;
  f.setup();
  */
  
  //"一次関数y=一x+二"
  //"二次関数y=-一xの二乗+二x+三"
  //"点(一,四)と点(二,三)と点(三,零)を通る放物線"
  //"点(一,二)と点(二,零)を通る直線の交点。それと原点の三角形";
  //result = "点(一,二)と点(二,零)を通る直線、定義域二≦x≦五。点(一,四)と点(二,三)と点(三,零)を通る放物線、定義域一≦x≦三";
  
  switch(mode){
    case 0: break;
    
    case 1: //println(result);
            result = result.replace(" ","");
            result = result.replace("　","");
            f.draw(result);
            break;
    
    case 2: d.draw(inputlist);
            break;
    
    case 3: exit();
    
    default: break;
  }
  countOK = 0;
}

void keyPressed(){
   this.k = true;
}

void keyReleased(){
  this.k = false;
}

void resetJudge(){
    if(result.indexOf("リセット") != -1){
    reset();
    result = "";
    copy = "";
    for(int i = 0 ; i < inputlist.size() ; i++){
    inputlist.remove(i); 
    }
    inputlist.clear();
    k = false;
    CategorySelection = false;
    countOK = 0;
    fakecount = 0;
    mode = 0;
  }
}

void reset(){
  background(0);
  textSize(70);
  fill(255,255,0);  
  text("SELECT CATEGORY!" , 470 , 300);
  stroke(0);
  fill(255,0,0);
  rect(400 , 400 , 350 , 300);
  fill(0,0,255);
  rect(850 , 400 , 350 , 300);
  fill(0);
  textSize(50);
  text("FUNCTION" , 450 , 575);
  text("DIAGRAM" , 900 , 575);
  frameRate(10);
  //j.setup(this);
  fill(255);
  delay(3000);
}
