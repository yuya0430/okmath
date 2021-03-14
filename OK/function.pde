class function{
  
int textx = 600;
int scale = 50; //50pixel = 1
int flag = 0;
int nk = 30; //name key:organize text space 
float k = -4;
String input; //store sound
boolean key = true; //execute output or not
ArrayList<onedim> o = new ArrayList<onedim>(); //array for 1-dim func
ArrayList<twodim> t = new ArrayList<twodim>(); //array for 2-dim func
int count1 = 0; //number of 1-dim
int count2 = 0; //number of 2-dim
int testcount = 0;
float vk = -3; //vertical k
float pk = -5; //parallel k

int w = 500;
int h = 500;


void setup(){
  //println("call f.setup");
  //size(1000,1000);
  background(0);
  stroke(255);
  strokeWeight(2);
  noFill();
  
}

void draw(String input){
  //println("call f.draw");
  background(0);
  textSize(24);
  translate(500,500);
  //rotate(3*PI/2);
  line(-500,0,500,0); //x axis
  text("x",480,20);
  line(0,-500,0,500); //y axis
  text("y",10,-480);
  text("0",-20,20); //origin
  
  this.nk = 30;

  //delete space
  
  
  //print(key);
  //input = "一次関数y=2x+3";
  //係数としての1は発音しないと上手く処理できない
  
  if(input.length() == 0)
    this.key = false;
  else{
    this.key = true;
    output(input,flag,this.nk);
  }
}

int transNum(String s){
  int result = 0;
  switch(s){
    case "一": result = 1;
               break;
    case "二": result = 2;
               break;
    case "三": result = 3;
               break;
    case "四": result = 4;
               break;
    case "五": result = 5;
               break;
    case "六": result = 6;
               break;
    case "七": result = 7;
               break;
    case "八": result = 8;
               break;
    case "九": result = 9;
               break;
  }
  return result;
}

/*
void keySwitch(String input){
  String[] s = input.split("",0); //char(input)
  for(int i = 0; i<s.length-1; i++)
    if(s[i].equals("O") && s[i+1].equals("K")){ //1-dim
      this.key = true;
      break;
  }
}
*/

//only a,b,c : +,-int
void output(String input,int flag,int nk){ //branch depend on input sound
  //switch output
  
  int i = 0; //dimension key
  String[] s = input.split("",0); //char(input)
  flag = 0; //last searched flag  
  float[] cp11 = new float[2]; //cross point
  float[] cp12 = new float[4]; //cross point
  int oldflag = 0;
  float x1 = 0, x2 = 0;
  boolean pf1 = true;
  boolean pf2 = true;
  
  while(this.key){
  //judge 1-dim or 2-dim
  for(int j = flag; j<s.length; j++){
    if(s[j].equals("一") && s[j+1].equals("次")){ //1-dim
      i = 1;
      flag = j+1;
      break;
    }
    if(s[j].equals("二") && s[j+1].equals("次")){ //2-dim
      i = 2;
      flag = j+1;
      break;
    }
    if(s[j].equals("交") && s[j+1].equals("点")){
      i = 3;
      flag = j+1;
      break;
    }
    if(s[j].equals("三") && s[j+1].equals("角") && s[j+2].equals("形")){
      i = 4;
      flag = j+1;
      break;
    }
    if(s[j].equals("垂") && s[j+1].equals("直")){
      i = 5;
      flag = j+1;
      break;
    }
    if(s[j].equals("平") && s[j+1].equals("行")){
      i = 6;
      flag = j+1;
      break;
    }
    if(s[j].equals("定") && s[j+1].equals("義") && s[j+2].equals("域")){
      x1 = transNum(s[j+3]);
      x2 = transNum(s[j+7]);
      i = 7;
      oldflag = flag;
      flag = j+1;
      break;
    }
    if(s[j].equals("ド") && s[j+1].equals("ラ")){
      i = 8;
      flag = j+1;
      break;
    }
    if(pf1 && (input.indexOf("直線",flag) != -1 || input.indexOf("一次関数",flag) != -1)){
      if(s[j].equals("点") && s[j+13].equals("を")){
      i = 9;
      flag = j+1;
      break;
      }
    }
    if(pf2 && (input.indexOf("放物線",flag) != -1 || input.indexOf("二次関数",flag) != -1)){
      if(s[j].equals("点") && s[j+20].equals("を")){
      i = 10;
      flag = j+1;
      break;
      }
    }
    if(j >= s.length-2){
      this.key = false;
      break; //for
    }
  }
  
  if(this.key == false)
    break; //while
  
  switch(i){
    //↓predicted style
    //"一次関数y=ax+b"
    case 1:
      definite1(s,flag);
      draw1(o.get(count1),scale,this.nk,calc1dim(o.get(count1),scale));
      this.count1++;
      break;
      
    //↓predicted style
    //"二次関数y=axの二乗+bx+c"
    case 2:
      definite2(s,flag);
      draw2(t.get(count2),scale,this.nk,calc2dim(t.get(count2),scale));
      this.count2++;
      break;
    
    case 3:
      if(t.size() != 0){
        cp12 = crosspoint12(o.get(0),t.get(0),scale,this.nk);
      }
      else if(t.size() == 0){
        int m;
        for(m=1; m<o.size(); m++){
          if(o.get(0).a != o.get(m).a){
            break;
          }
        }
        cp11 = crosspoint11(o.get(0),o.get(m),scale,this.nk);
      }
      break;
    
    case 4:
      if(t.size() != 0)
        Region3(cp12[0],cp12[1],cp12[2],cp12[3],0,0,scale);
      else{
        int m = 0;
        if(o.get(0) == o.get(m))
          m++;
        println("m = "+m);
        println("y1 = "+getPointY_0_1(o.get(0))+" y2 = "+getPointY_0_1(o.get(m)));
        Region3(cp11[0],cp11[1],getPointY_0_1(o.get(0)),0,getPointY_0_1(o.get(m)),0,scale);
      }
      break;
    
    case 5:
      k = k+0.2;
      vertical(o.get(0),vk,str(vk),scale,this.nk);
      if(k>5)  k = -5;
      break;
    
    case 6:
      k = k+0.2;
      parallel(o.get(0),pk,str(pk),scale,this.nk);
      if(k>5)  k = -5;
      break;
    
    case 7:
      if((flag-oldflag)<15 || (flag-input.indexOf("直線",oldflag)) < 5){ //1-dim
        draw1Limited(o.get(o.size()-1),scale,x1,x2,this.nk);
      }else{  //2-dim
        draw2Limited(t.get(t.size()-1),scale,x1,x2,this.nk);
      }
      break;
    
    case 8:
      doraemon();
      break;
    
    case 9:
      //点(二,三)と点(三,零)を通る直線
      int[] temp1 = new int[4];
      temp1[0] = transNum(s[flag+1]);
      temp1[1] = transNum(s[flag+3]);
      temp1[2] = transNum(s[flag+8]);
      temp1[3] = transNum(s[flag+10]);
      //a[2]
      int[] d = gauss1(temp1[0],temp1[1],temp1[2],temp1[3]);
      
      text("//1-dim through points",textx,-500+this.nk);
      this.nk += 30;
      showPoints(temp1[0],temp1[1]);
      showPoints(temp1[2],temp1[3]);
      
      onedim ot = new onedim(d[0],d[1],str(d[0]),str(d[1]));
      
      //println("d[0] = "+d[0]+" d[1] = "+d[1]);
      
      this.o.add(ot);
      draw1(ot,scale,this.nk,calc1dim(ot,scale));
      this.count1++;
      
      /*
      println("result : "+result);
      println("flag = "+flag);
      println("s[flag] = "+s[flag]);
      println("x1 = "+temp1[0]+" y1 = "+temp1[1]);
      println("x2 = "+temp1[2]+" y2 = "+temp1[3]);
      */
      
      pf1 = false;
      //flag = flag + 15;
      break;
    
    case 10:
      //点(一,四)と点(二,三)と点(三,零)を通る放物線
      int[] temp2 = new int[6];
      temp2[0] = transNum(s[flag+1]);
      temp2[1] = transNum(s[flag+3]);
      temp2[2] = transNum(s[flag+8]);
      temp2[3] = transNum(s[flag+10]);
      temp2[4] = transNum(s[flag+15]);
      temp2[5] = transNum(s[flag+17]);
      int[] c = gauss2(temp2[0],temp2[1],temp2[2],temp2[3],temp2[4],temp2[5]);
      
      //println("this.nk = "+this.nk+"  this.nk ="+this.nk);
      text("//2-dim through points",textx,-500+this.nk);
      this.nk += 30;
      showPoints(temp2[0],temp2[1]);
      showPoints(temp2[2],temp2[3]);
      showPoints(temp2[4],temp2[5]);
      //this.nk += 90;
      //println("this.nk = "+this.nk+"  this.nk ="+this.nk);
      //println("a = "+c[0]+" b = "+c[1]+" c = "+c[2]);
      
      twodim tt = new twodim(c[0],c[1],c[2],str(c[0]),str(c[1]),str(c[2]));
      this.t.add(tt);
      draw2(tt,scale,this.nk,calc2dim(tt,scale));
      this.count2++;
      //this.nk += 90;
      pf2 = false;
      //flag = flag + 20;
      
      /*
      println("result : "+result);
      println("flag = "+flag);
      println("s[flag] = "+s[flag]);
      println("x1 = "+temp2[0]+" y1 = "+temp2[1]);
      println("x2 = "+temp2[2]+" y2 = "+temp2[3]);
      println("x3 = "+temp2[4]+" y3 = "+temp2[5]);
      */
      
      break;
  }
  }
}

void definite1(String[] s, int flag){
  int style = 0;
  boolean[] minus = new boolean[s.length];
  for(int i=0; i<minus.length; i++)
    minus[i] = false;
  
  //1-dim
  float a = 1;
  float b = 0;
  String as = "";
  String bs = "";
  
  int j=5;
  int k=j+3;
  
  for(int i=flag; i<flag+9; i++){
    if(s[i].equals("-")){ //+int,-int
      style = 1;
      minus[i] = true;
    }else if(style!=1)//only natural number
      style = 2;
  }
  
  switch(style){
    //一次関数y=ax+b 
    //flag:次
    case 1:
      if(minus[flag+j] == true){
        if(minus[flag+k] == true){
          //y=-ax-b
          a = float(s[flag+j]+str(transNum(s[flag+j+1])));
          //print("a = "+a+"\n");
          as = s[flag+j]+str(transNum(s[flag+j+1]));
          //print("as = "+as+"\n");
          b = float(s[flag+k]+str(transNum(s[flag+k+1])));
          //print("b = "+b+"\n");
          bs = s[flag+k]+str(transNum(s[flag+k+1]));
          //print("bs = "+bs+"\n");
          onedim o1 = new onedim(a,b,as,bs);
          this.o.add(o1);
          break;
        }
        //y=-ax+b
        a = float(s[flag+j]+str(transNum(s[flag+j+1])));
        //print("a = "+a+"\n");
        as = s[flag+j]+str(transNum(s[flag+j+1]));
        //print("as = "+as+"\n");
        b = float(str(transNum(s[flag+k+1])));
        //print("b = "+b+"\n");
        bs = str(transNum(s[flag+k+1]));
        //print("bs = "+bs+"\n");
        onedim o1 = new onedim(a,b,as,bs);
        this.o.add(o1);
        break;
    }else{
      //y=ax-b
      a = float(str(transNum(s[flag+j])));
      //print("a = "+a+"\n");
      as = str(transNum(s[flag+j]));
      //print("as = "+as+"\n");
      b = float(s[flag+k-1]+str(transNum(s[flag+k])));
      //print("b = "+b+"\n");
      bs = s[flag+k-1]+str(transNum(s[flag+k]));
      //print("bs = "+bs+"\n");
      onedim o1 = new onedim(a,b,as,bs);
      this.o.add(o1);
      break;
    }
    case 2:
      //y=ax+b
      a = float(str(transNum(s[flag+j])));
      //print("a = "+a+"\n");
      as = str(transNum(s[flag+j]));
      //print("as = "+as+"\n");
      b = float(str(transNum(s[flag+k])));
      //print("b = "+b+"\n");
      bs = str(transNum(s[flag+k]));
      //print("bs = "+bs+"\n");
      onedim o1 = new onedim(a,b,as,bs);
      this.o.add(o1);
      break;
  }
}

void definite2(String[] s, int flag){
  int style = 0;
  boolean[] minus = new boolean[s.length];
  for(int i=0; i<minus.length; i++)
    minus[i] = false;
  
  //1-dim
  float a = 1;
  float b = 0;
  float c = 0;
  String as = "";
  String bs = "";
  String cs = "";
  
  int j = 5;
  int k = j+6;
  int m = k+3;
  
  for(int i=0; i<s.length; i++){
    if(s[i].equals("-")){ //+int,-int
      style = 1;
      minus[i] = true;
    }else if(style!=1 && i==s.length-1)//only natural number
      style = 2;
  }
  
  switch(style){
    //↓predicted style
    //二次関数y=axの二乗+bx+c 
    //flag:次
    case 1:
      if(minus[flag+j] == true){
        if(minus[flag+k] == true){
          if(minus[flag+m] == true){
          //y=-axの二乗-bx-c
          a = float(s[flag+j]+str(transNum(s[flag+j+1])));
          as = s[flag+j]+str(transNum(s[flag+j+1]));
          b = float(s[flag+k]+str(transNum(s[flag+k+1])));
          bs = s[flag+k]+str(transNum(s[flag+k+1]));
          c = float(s[flag+m]+str(transNum(s[flag+m+1])));
          cs = s[flag+m]+str(transNum(s[flag+m+1]));
          
          twodim t1 = new twodim(a,b,c,as,bs,cs);
          this.t.add(t1);
          break;
        }
        //y=-axの二乗-bx+c
        a = float(s[flag+j]+str(transNum(s[flag+j+1])));
        as = s[flag+j]+str(transNum(s[flag+j+1]));
        b = float(s[flag+k]+str(transNum(s[flag+k+1])));
        bs = s[flag+k]+str(transNum(s[flag+k+1]));
        c = float(str(transNum(s[flag+m+1])));
        cs = str(transNum(s[flag+m+1]));
        
        twodim t1 = new twodim(a,b,c,as,bs,cs);
        this.t.add(t1);
        break;
        }else if(minus[flag+m] == true){
          //y=-axの二乗+bx-c
          a = float(s[flag+j]+str(transNum(s[flag+j+1])));
          as = s[flag+j]+str(transNum(s[flag+j+1]));
          b = float(str(transNum(s[flag+k+1])));
          bs = str(transNum(s[flag+k+1]));
          c = float(s[flag+m]+str(transNum(s[flag+m+1])));
          cs = s[flag+m]+str(transNum(s[flag+m+1]));
          
          twodim t1 = new twodim(a,b,c,as,bs,cs);
          this.t.add(t1);
          break;
        }
      //y=-axの二乗+bx+c
      a = float(s[flag+j]+str(transNum(s[flag+j+1])));
      as = s[flag+j]+str(transNum(s[flag+j+1]));
      b = float(s[flag+k]+str(transNum(s[flag+k+1])));
      bs = str(transNum(s[flag+k+1]));
      c = float(str(transNum(s[flag+m+1])));
      cs = str(transNum(s[flag+m+1]));
      
      twodim t1 = new twodim(a,b,c,as,bs,cs);
      this.t.add(t1);
      break;
    }else if(minus[flag+k-1] == true){
      if(minus[flag+m-1] == true){
        //y=axの二乗-bx-c
        a = float(str(transNum(s[flag+j])));
        as = str(transNum(s[flag+j]));
        b = float(s[flag+k-1]+str(transNum(s[flag+k])));
        bs = s[flag+k-1]+str(transNum(s[flag+k]));
        c = float(s[flag+m-1]+str(transNum(s[flag+m])));
        cs = s[flag+m-1]+str(transNum(s[flag+m]));
        
        twodim t1 = new twodim(a,b,c,as,bs,cs);
        this.t.add(t1);
        break;
      }
      //y=axの二乗-bx+c
      a = float(str(transNum(s[flag+j])));
      as = str(transNum(s[flag+j]));
      b = float(s[flag+k-1]+str(transNum(s[flag+k])));
      bs = s[flag+k-1]+str(transNum(s[flag+k]));
      c = float(str(transNum(s[flag+m])));
      cs = str(transNum(s[flag+m]));
      
      twodim t1 = new twodim(a,b,c,as,bs,cs);
      this.t.add(t1);
      break;
    }else{
    //y=axの二乗+bx-c
    a = float(str(transNum(s[flag+j])));
    as = str(transNum(s[flag+j]));
    b = float(str(transNum(s[flag+k])));
    bs = str(transNum(s[flag+k]));
    c = float(s[flag+m-1]+str(transNum(s[flag+m])));
    cs = s[flag+m-1]+str(transNum(s[flag+m]));
    
    twodim t1 = new twodim(a,b,c,as,bs,cs);
    this.t.add(t1);
    break;
    }
      
    case 2:
      //y=axの二乗+bx+c 
      a = float(str(transNum(s[flag+j])));
      //print("a = "+a+"\n");
      as = str(transNum(s[flag+j]));
      //print("as = "+as+"\n");
      b = float(str(transNum(s[flag+k])));
      //print("b = "+b+"\n");
      bs = str(transNum(s[flag+k]));
      //print("bs = "+bs+"\n");
      c = float(str(transNum(s[flag+m])));
      cs = str(transNum(s[flag+m]));
      
      twodim t1 = new twodim(a,b,c,as,bs,cs);
      this.t.add(t1);
      break;
  }
}

void draw1(onedim o, int scale, int nk, float[] temp){ //1-dim func
  line(temp[0], temp[1], temp[2], temp[3]);
  show1dimName(o,"1-dim func",scale,this.nk);
  this.nk += 30;
}

void show1dimName(onedim o, String name, int scale, int nk){
  //show x=0
  boolean key = true;
  float b = o.b*scale;
  if(o.b!=0){
    if(o.a>0)
      text(o.bs,10,-b); 
    else if(o.a<0)
      text(o.bs,-10,-b);
    else
      text(o.bs,0,b+10);
  }else
    key = false;
    
  //show y=0
  if(key == true){
    float x = -(b/scale)/o.a;
    float gx = -b/o.a;
    //O.O(2digit)
    String xs = nf(x,1,1);
    text(xs,gx,0);
  }
  
  //show line-name
  if(o.a!=0){
    if(o.a==1){
      if(b<0)
        text(name + " : y=x" + o.bs, textx, -500+this.nk);
      else if(b>0)
        text(name + " : y=x+" + o.bs, textx, -500+this.nk);
      if(b==0)
        text(name + " : y=x", textx, -500+this.nk);
    }else if(o.a==-1){
      if(b<0)
        text(name + " : y=-x" + o.bs, textx, -500+this.nk);
      else if(b>0)
        text(name + " : y=-x+" + o.bs, textx, -500+this.nk);
      if(b==0)
        text(name + " : y=-x", textx, -500+this.nk);
    }else{
      if(b<0)
        text(name + " : y=" + o.as + "x" + o.bs, textx, -500+this.nk);
      else if(b>0)
        text(name + " : y=" + o.as + "x+" + o.bs, textx, -500+this.nk);
      if(b==0)
        text(name + " : y=" + o.as + "x", textx, -500+this.nk);
    }
  }else{
    text(name + " : y=" + o.bs, textx, -500+this.nk);
  }
}

float[] calc1dim(onedim o, int scale){
  //adjust scale
  float b = o.b*scale;
  
  //1->up 2->down
  float tempy1=-h,tempy2=h;
  float tempx1=w,tempx2=-w;
  
  //calc line limit
  if(-1<=o.a && o.a<=1){ //a:-1~1
    tempy1 = -(o.a*w + b);
    tempy2 = -(o.a*(-w) + b);
  }
  else{
    tempx1 = (h-b)/o.a;
    tempx2 = (-h-b)/o.a;
  }
  
  //array for coodinate
  float[] temp = new float[4];
  temp[0] = tempx1;
  temp[1] = tempy1;
  temp[2] = tempx2;
  temp[3] = tempy2;
  
  return temp;
}

void draw2(twodim t, int scale, int nk, float[] temp){
  //draw graph
  beginShape();
  for(int i=-w; i<w; i++){
    vertex(i,-temp[i+w]); //point -> line
  }
  endShape();
  show2dimName(t,"2-dim func",scale,this.nk);
  //this.nk += 90;
}

void show2dimName(twodim t, String name, int scale, int nk){
  if(t.a == 1){
    if(t.b<0){
      if(t.c>0)
        text(name + " : y=x^2 " + t.bs + "x + " + t.cs, textx, -500+this.nk);
      else if(t.c<0)
        text(name + " : y=x^2 " + t.bs + "x " + t.cs, textx, -500+this.nk);
      else
        text(name + " : y=x^2 " + t.bs + "x", textx, -500+this.nk);
    }else if(t.b>0){
      if(t.c>0)
        text(name + " : y=x^2 + " + t.bs + "x + " + t.cs, textx, -500+this.nk);
      else if(t.c<0)
        text(name + " : y=x^2 + " + t.bs + "x " + t.cs, textx, -500+this.nk);
      else
        text(name + " : y=x^2 + " + t.bs + "x", textx, -500+this.nk);
    }else{
      if(t.c>0)
        text(name + " : y=x^2 + " + t.cs, textx, -500+this.nk);
      else if(t.c<0)
        text(name + " : y=x^2 " + t.cs, textx, -500+this.nk);
      else
        text(name + " : y=x^2", textx, -500+this.nk);
    }
  }else if(t.a == -1){
    if(t.b<0){
      if(t.c>0)
        text(name + " : y=-x^2 " + t.bs + "x + " + t.cs, textx, -500+this.nk);
      else if(t.c<0)
        text(name + " : y=-x^2 " + t.bs + "x " + t.cs, textx, -500+this.nk);
      else
        text(name + " : y=-x^2 " + t.bs + "x", textx, -500+this.nk);
    }else if(t.b>0){
      if(t.c>0)
        text(name + " : y=-x^2 + " + t.bs + "x + " + t.cs, textx, -500+this.nk);
      else if(t.c<0)
        text(name + " : y=-x^2 + " + t.bs + "x " + t.cs, textx, -500+this.nk);
      else
        text(name + " : y=-x^2 + " + t.bs + "x", textx, -500+this.nk);
    }else{
      if(t.c>0)
        text(name + " : y=-x^2 + " + t.cs, textx, -500+this.nk);
      else if(t.c<0)
        text(name + " : y=-x^2 " + t.cs, textx, -500+this.nk);
      else
        text(name + " : y=-x^2", textx, -500+this.nk);
    }
  }else{
    if(t.b<0){
    if(t.c>0)
      text(name + " : y=" + t.as + "x^2 " + t.bs + "x + " + t.cs, textx, -500+this.nk);
    else if(t.c<0)
      text(name + " : y=" + t.as + "x^2 " + t.bs + "x " + t.cs, textx, -500+this.nk);
    else
      text(name + " : y=" + t.as + "x^2 " + t.bs + "x", textx, -500+this.nk);
    }else if(t.b>0){
      if(t.c>0)
        text(name + " : y=" + t.as + "x^2 + " + t.bs + "x + " + t.cs, textx, -500+this.nk);
      else if(t.c<0)
        text(name + " : y=" + t.as + "x^2 + " + t.bs + "x " + t.cs, textx, -500+this.nk);
      else
        text(name + " : y=" + t.as + "x^2 + " + t.bs + "x", textx, -500+this.nk);
    }else{
      if(t.c>0)
        text(name + " : y=" + t.as + "x^2 + " + t.cs, textx, -500+this.nk);
      else if(t.c<0)
        text(name + " : y=" + t.as + "x^2 " + t.cs, textx, -500+this.nk);
      else
        text(name + " : y=" + t.as + "x^2", textx, -500+this.nk);
    }
  }
  this.nk += 30;
  
  //show x=0
  //O.O(2digit)
  String x = nf(t.c,1,1);
  //adjust scale
  t.c *= scale;
  text(x,0,-t.c);
  //restore scale
  t.c /= scale;
  
  //show y=0
  //2-dim answer(ax^2 + bs + c = 0)
  //restore scale
  float x0 = (-t.b+sqrt(pow(t.b,2)-4*t.a*t.c))/(2*t.a);
  float x1 = (-t.b-sqrt(pow(t.b,2)-4*t.a*t.c))/(2*t.a);
  //x = O.O(2digit)
  String x0s = nf(x0,1,1);
  String x1s = nf(x1,1,1);
  text("x0 = " + x0s,textx,-500+this.nk);
  this.nk += 30;
  text("x1 = " + x1s ,textx, -500+this.nk);
  this.nk += 30;
  
  //adjust scale
  t.a /= scale;
  t.c *= scale;
  //show x0,x1
  x0 = (-t.b+sqrt(pow(t.b,2)-4*t.a*t.c))/(2*t.a);
  x1 = (-t.b-sqrt(pow(t.b,2)-4*t.a*t.c))/(2*t.a);
  text("x0",(int)x0+5,-5);
  text("x1",(int)x1+5,-5);
  
  //show vertex
  //restore scale
  t.a *= scale;
  t.c /= scale;
  float vx = -t.b/(2*t.a);
  float vy = -pow(t.b,2)/(4*t.a)+t.c;

  //dotted line
  //adjust scale
  t.a /= scale;
  t.c *= scale;
  float cx = -t.b/(2*t.a); //coordinate x
  float cy = pow(t.b,2)/(4*t.a)-t.c; //coordinate y
  if(cy>0){
    for(int i = (int)cy; i>0; i--)
      if(i%8 == 0)
        ellipse(cx,i,1,1);
  }else{
    for(int i = (int)cy; i<0; i++)
      if(i%8 == 0)
        ellipse(cx,i,1,1);
  }
  if(cx>0){
    for(int i = (int)cx; i>0; i--)
      if(i%8 == 0)
        ellipse(i,cy,1,1);
  }else{
    for(int i = (int)cx; i<0; i++)
      if(i%8 == 0)
        ellipse(i,cy,1,1);
  }
  
  //restore scale
  t.a *= scale;
  t.c /= scale;
  
  
  //print("vx:"+vx+" vy:"+vy+" ");
  
  //v = O.O(2digit)
  String vxs = nf(vx,1,1);
  String vys = nf(vy,1,1);
  text(vxs,cx,-5);
  text(vys,0,cy);
}

float[] calc2dim(twodim t, int scale){
  //*10pixel
  //adjust scale
  float a = t.a/scale;
  float c = t.c*scale;
  
  //(x,y) = (x,array[x])
  float[] array = new float[2*w];
  
  //store coordinate
  for(int i=-w; i<w; i++){
    array[i+w] = (int)(a*pow(i,2) + t.b*i + c); //y=ax^2+bx+c
  }
  
  return array;
}


//show crosspoint between 1,1-dim func
//float[2]
float[] crosspoint11(onedim o1, onedim o2, int scale, int nk){
  float x,y; //crossing point
  float gx, gy; //crossing real point


  println("o1.a="+o1.a+" o2.a="+o2.a);
  x = (o2.b-o1.b)/(o1.a-o2.a);
  y = o1.a*x+o1.b;
  
  
  float[] temp = new float[2];
  temp[0] = x;
  temp[1] = y;
  
  //adjust scale
  o1.b *= scale;
  o2.b *= scale;
  gx = (o2.b-o1.b)/(o1.a-o2.a);
  gy = o1.a*gx+o1.b;

  //restore scale
  o1.b /= scale;
  o2.b /= scale;
  
  //O.O(2digit)
    //OO.OO
  String xs = nf(x,1,1);
  String ys = nf(y,1,1);
  
  //show crossing point
  if(gy>0){
    for(int i = (int)gy; i>0; i--)
      if(i%8 == 0)
        ellipse(gx,-i,1,1);
  }else{
    for(int i = (int)gy; i<0; i++)
      if(i%8 == 0)
        ellipse(gx,-i,1,1);
  }
  if(gx>0){
    for(int i = (int)gx; i>0; i--)
      if(i%8 == 0)
        ellipse(i,-gy,1,1);
  }else{
    for(int i = (int)gx; i<0; i++)
      if(i%8 == 0)
        ellipse(i,-gy,1,1);
  }
  text("cx",gx,0);
  text("cx = " + xs, textx, -500+this.nk);
  this.nk += 30;
  text("cy",0,-gy);
  text("cy = " + ys, textx, -500+this.nk);
  this.nk += 30;
  this.nk += 60;
  println("x="+x+" y="+y+" gx="+gx+" gy="+gy);
  
  return temp;
}


//show crosspoint between 1,2-dim func
//float[4]
float[] crosspoint12(onedim o, twodim t, int scale, int nk){
  float x1, x2, y1, y2; //crossing point x1:+ x2:-
  float gx1, gx2, gy1, gy2; //crossing real point
  x1 = ((o.a-t.b)+sqrt(pow(o.a,2)+pow(t.b,2)-2*(o.a*t.b +2*t.a*t.c -2*t.a*o.b)))/(2*t.a);
  x2 = ((o.a-t.b)-sqrt(pow(o.a,2)+pow(t.b,2)-2*(o.a*t.b +2*t.a*t.c -2*t.a*o.b)))/(2*t.a);
  y1 = o.a*x1+o.b;
  y2 = o.a*x2+o.b;
  
  float[] temp = new float[4];
  temp[0] = x1;
  temp[1] = y1;
  temp[2] = x2;
  temp[3] = y2;
  
  //O.O(2sigit)
  String x1s = nf(x1,1,1);
  String y1s = nf(y1,1,1);
  String x2s = nf(x2,1,1);
  String y2s = nf(y2,1,1);
  
  //print(pow(a1,2)+pow(b2,2)-2*(a1*b2 +2*a2*c2 -2*a2*b1) + "  ");
  //print("x1:" + x1 + " x2:" + x2 + " y1:" + y1 + " y2:" + y2);
  
  //adjust scale
  o.b *= scale;
  t.a /= scale;
  t.c *= scale;
  
  gx1 = ((o.a-t.b)+sqrt(pow(o.a,2)+pow(t.b,2)-2*(o.a*t.b +2*t.a*t.c -2*t.a*o.b)))/(2*t.a);
  gx2 = ((o.a-t.b)-sqrt(pow(o.a,2)+pow(t.b,2)-2*(o.a*t.b +2*t.a*t.c -2*t.a*o.b)))/(2*t.a);
  gy1 = o.a*gx1+o.b;
  gy2 = o.a*gx2+o.b;
  
  //restore scale
  o.b /= scale;
  t.a *= scale;
  t.c /= scale;
  
  //show crossing point 1
  if(gy1>0){
    for(int i = (int)gy1; i>0; i--)
      if(i%8 == 0)
        ellipse(gx1,-i,1,1);
  }else{
    for(int i = (int)gy1; i<0; i++)
      if(i%8 == 0)
        ellipse(gx1,-i,1,1);
  }
  if(gx1>0){
    for(int i = (int)gx1; i>0; i--)
      if(i%8 == 0)
        ellipse(i,-gy1,1,1);
  }else{
    for(int i = (int)gx1; i<0; i++)
      if(i%8 == 0)
        ellipse(i,-gy1,1,1);
  }
  
  //show crossing point 2
  if(gy2>0){
    for(int i = (int)gy2; i>0; i--)
      if(i%8 == 0)
        ellipse(gx2,-i,1,1);
  }else{
    for(int i = (int)gy2; i<0; i++)
      if(i%8 == 0)
        ellipse(gx2,-i,1,1);
  }
  if(gx2>0){
    for(int i = (int)gx2; i>0; i--)
      if(i%8 == 0)
        ellipse(i,-gy2,1,1);
  }else{
    for(int i = (int)gx2; i<0; i++)
      if(i%8 == 0)
        ellipse(i,-gy2,1,1);
  }
  
  //show crossing point 1
  text("cx1",gx1,0);
  text("cx1 = " + x1s, textx, -500+this.nk);
  this.nk += 30;
  text("cy1",0,-gy1);
  text("cy1 = " + y1s, textx, -500+this.nk);
  this.nk += 30;
  
  //show crossing point 2
  text("cx2",gx2,0);
  text("cx2 = " + x2s, textx, -500+this.nk);
  this.nk += 30;
  text("cy2",0,-gy2);
  text("cy2 = " + y2s, textx, -500+this.nk);
  this.nk += 30;
  
  return temp;
}

int[] gauss1(int x1, int y1, int x2, int y2){
  int[] temp = new int[2];
  double[][] k = {{x1,1,y1},{x2,1,y2}};
  
  //about a
  for(int i = 0; i<3; i++)
    k[0][i] -= k[1][i];
  
  double t = k[1][0]/k[0][0];
  
  //about b
  for (int i = 0; i<3; i++)
    k[1][i] -= t*k[0][i];
  
  temp[0] = (int)(k[0][2]/k[0][0]);
  temp[1] = (int)(k[1][2]/k[1][1]);
  
  return temp;
}

//Gaussの消去法で連立方程式を解く
//点(一,四)と点(二,三)と点(三,零)を通る放物線
int[] gauss2(int x1, int y1, int x2, int y2, int x3, int y3){
  //前進消去
  double a1 = (double)x1 * (double)x1;
  double b1 = (double)x1;
  double c1 = 1.0;
  double a2 = (double)x2 * (double)x2;
  double b2 = (double)x2;
  double c2 = 1.0;
  double a3 = (double)x3 * (double)x3;
  double b3 = (double)x3;
  double c3 = 1.0;
           
  double a[][]={{a1,b1,c1,(double)y1},
                {a2,b2,c2,(double)y2},
                {a3,b3,c3,(double)y3}};             
  int N = 3;
  
  double s;
  for(int k=0; k<N-1; k++){
    for(int i=k+1; i<N; i++){
      s=a[i][k]/a[k][k];
      for(int j=k+1; j<=N; j++){
        a[i][j] -= s * a[k][j];
      }
    }
  }
//後退代入
  for(int i=N-1; i>=0; i--){
    s=a[i][N];
    for(int j=i+1; j<N; j++){
      s -= a[i][j] * a[j][N];
    }
    a[i][N] = s/a[i][i];
  }
  int[] ans = {(int)a[0][3],(int)a[1][3],(int)a[2][3]};
  return ans;
}

void showPoints(int x, int y){
  fill(100,200,5);
  ellipse(x*scale, -y*scale, 4,4);
  fill(255);
  noFill();
  text("through point : ("+x+","+y+")" ,textx,-500+this.nk);
  this.nk += 30;
}



void parallel(onedim o, float k, String ks, int scale, int nk){ //y=ax + k
  float a,b;
  String as,bs;
  a = o.a;
  as = str(a);
  b = k;
  bs = ks;
  onedim to = new onedim(a,b,as,bs);
  float[] temp = new float[4];
  temp = calc1dim(to,scale);
  line(temp[0], temp[1], temp[2], temp[3]);
  show1dimName(to,"parallel",scale,this.nk);
  this.nk += 30;
}


void vertical(onedim o, float k, String ks, int scale, int nk){ //y=-1/a x + k
  float a,b;
  String as,bs;
  a = -1/o.a;
  as = str(a);
  b = k;
  bs = ks;
  onedim to = new onedim(a,b,as,bs);
  float[] temp = new float[4];
  temp = calc1dim(to,scale);
  line(temp[0], temp[1], temp[2], temp[3]);
  show1dimName(to,"vertical",scale,this.nk);
  this.nk += 30;
  
}

float getPointX1(onedim o, float x){
  return o.a*x+o.b;
}

float getPointGX1(onedim o, float x, int scale){
  //float tx = x*scale;
  float b = o.b*scale;
  return o.a*x+b;
}

float getPointX2(twodim t, float x){
  return t.a*pow(x,2)+t.b*x+t.c;
}

float getPointGX2(twodim t, float x, int scale){
  //float tx = x*scale;
  float a = t.a/scale;
  float c = t.c*scale;
  return a*pow(x,2)+t.b*x+c;
}

float getPointY_0_1(onedim o){
  return -o.b/o.a;
}

float getPointY_0_2(twodim t){
  return (-t.b+sqrt(pow(t.b,2)-4*t.a*t.c))/(2*t.a);
}


void draw1Limited(onedim o, int scale, float x1, float x2, int nk){ //x1<x2
  float y1, y2;
  float b = o.b*scale;
  x1 = x1*scale;
  x2 = x2*scale;
  y1 = -(o.a*x1 + b);
  y2 = -(o.a*x2 + b);
  strokeWeight(4);
  stroke(0,180,0);
  line(x1,y1,x2,y2);
  stroke(255);
  strokeWeight(2);
  //domain
  text("domain : " + x1/scale + " < x < " + x2/scale, textx,-500+this.nk);
  this.nk += 30;
}

void draw2Limited(twodim t, int scale, float x1, float x2, int nk){ //x1<x2
  int size = (int)(x2-x1)*scale; //scale pixel = 1
  int[] array = new int[size];
  float a,c;
  a = t.a/scale;
  c = t.c*scale;
  x1 *= scale;
  
  for(int i=0; i<array.length; i++){
    array[i] = (int)(a*pow((i+x1),2) + t.b*(i+x1) + c); //array[0]:x1
  }
  
  //draw graph
  strokeWeight(4);
  stroke(0,100,200);
  beginShape();
  for(int i=0; i<array.length; i++){
    vertex(i+x1,-array[i]); //point -> line
  }
  endShape();
  stroke(255);
  strokeWeight(2);
  
  x1 /= scale;
  
  //domain
  text("domain : " + x1 + " < x < " + x2, textx,-500+this.nk);
  this.nk += 30;
}

void doraemon(){
  //ごまかしテキスト
  textSize(30);
  text("//outlines(blue)",textx,-460);
  text("circle: x^2 + y^2 = 64",textx,-420);
  text("//inside circle(white)",textx,-380);
  text("circle: x^2 + (y + 1)^2 = 49",textx,-340);
  text("//nose",textx,-300);
  text("circle: x^2 + (y - 1.5)^2 = 1",textx,-260);
  text("//right eye(white)",textx,-220);
  text("ellipse: x^2 + (y + 1)^2 = 49",textx,-180);
  text("//left eye(white)",textx,-140);
  text("ellipse: x^2 + (y + 1)^2 = 49",textx,-100);
  text("//right eye(black)",textx,-60);
  text("ellipse: x^2 + (y + 1)^2 = 49",textx,-20);
  text("//left eye(black)",textx,20);
  text("ellipse: x^2 + (y + 1)^2 = 49",textx,60);
  text("//mouse(under)",textx,100);
  text("circle: x^2 + (y - 1)^2 = 49",textx,140);
  text("domain: -6.5 < 6.5", textx, 180);
  text("//mouse(top)",textx,220);
  text("circle: x^2 + (y - 5)^2 = 64",textx,260);
  text("domain: -6.5 < 6.5", textx, 300);
  text("//tongue(top)",textx,340);
  text("circle: x^2 + (y + 7)^2 = 9",textx,380);
  text("domain: -2.0 < 2.0", textx,420);
  text("//tongue(under)",textx,460);
  text("circle: x^2 + (y - 1)^2 = 49",textx,500);
  stroke(0);
  
  stroke(0);
  strokeWeight(2);
  //外円
  fill(67,135,233); //浅葱色
  ellipse(0,0,800,800);
  //内円
  fill(255);
  ellipse(0,50,700,700);
  //白目
  stroke(0);
  fill(255);
  ellipse(-75,-220,150,250);
  ellipse(75,-220,150,250);
  //黒目
  fill(0);
  ellipse(-35,-220,40,70);
  ellipse(35,-220,40,70);
  //鼻
  fill(255,38,0); //鉛丹色
  ellipse(0,-95,80,80);
  //口
  fill(255,38,0);
  bezier(-270,100,-200,400,200,400,270,100);
  fill(255);
  bezier(-270,100,-100,180,100,180,270,100);
  //舌
  fill(255,101,12); //珊瑚色
  bezier(-100,305,-50,220,50,220,100,305);
  bezier(-100,305,-50,330,50,330,100,305);
  //鼻下
  strokeWeight(2);
  line(0,-55,0,160);
  //髭
  line(70,-30,300,-80);
  line(80,0,310,0);
  line(70,30,300,80);
  line(-70,-30,-300,-80);
  line(-80,0,-310,0);
  line(-70,30,-300,80);
  //reset sequance
  stroke(255);
  strokeWeight(2);
  fill(255);
}

//Function for showing Triangle"ABC" Region
//color triangle
void Region3(float x1,float y1,float x2,float y2,float x3,float y3, int scale){
  x1 *= scale;
  x2 *= scale;
  x3 *= scale;
  y1 *= scale;
  y2 *= scale;
  y3 *= scale;
  
  fill(0,255,255,180);
  noStroke();
  beginShape();
    vertex(x1 , -y1);
    vertex(x2 , -y2);
    vertex(x3 , -y3);
  endShape(CLOSE);
  //restore circumstances
  fill(255);
  stroke(255);
  noFill();
}
}
