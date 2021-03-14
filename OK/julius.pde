//まず「julius_fast_module.bat」起動

import processing.net.*;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

class julius{
  
Client myClient; //Juliusとの連携で必要

float x;
float y;
//XML xml;
String word="";
color col=color(0,0,0);
void setup(PApplet obj){
    //size(500, 500);
    myClient = new Client(obj,"localhost",10500); //Juliusとの連携で必要
 
    x = 500;
    y = random(500);
}
 
String draw(){
    Candidate[] tmpword = getWord(); //ここでJuliusで認識した音声を読み取る
    
    //for(int i=0; i<tmpword.length; i++){
    for(int i=0; i<tmpword.length; i++){
      if(tmpword[i].word.length()==0){
        break;
      }
      String[] sp_word = split(tmpword[i].word,' ');
      if(sp_word[0].equals("三角形")){
        char alfa1 = sp_word[1].charAt(0);
        char alfa2 = sp_word[2].charAt(0);
        char alfa3 = sp_word[3].charAt(0);
        
        if(alfa1 == alfa2 || alfa2 == alfa3 || alfa1 == alfa3){
          tmpword[i].score=0.0;
        }
        if((alfa3-alfa2)+(alfa2-alfa1) == 2){
          tmpword[i].score+=20.0;
        }
      }
      if(sp_word[0].equals("四角形")){
        char alfa1 = sp_word[1].charAt(0);
        char alfa2 = sp_word[2].charAt(0);
        char alfa3 = sp_word[3].charAt(0);
        char alfa4 = sp_word[4].charAt(0);
        
        if(alfa1 == alfa2 || alfa1 == alfa3 || alfa1 == alfa4 || alfa2 == alfa3 || alfa2 == alfa4 || alfa3 == alfa4){
          tmpword[i].score=0.0;
        }
        if((alfa4-alfa3)+(alfa3-alfa2)+(alfa2-alfa1) == 3){
          tmpword[i].score+=20.0;
        }
      }
      if(sp_word[0].equals("平行四辺形")){
        char alfa1 = sp_word[1].charAt(0);
        char alfa2 = sp_word[2].charAt(0);
        char alfa3 = sp_word[3].charAt(0);
        char alfa4 = sp_word[4].charAt(0);
        
        if(alfa1 == alfa2 || alfa1 == alfa3 || alfa1 == alfa4 || alfa2 == alfa3 || alfa2 == alfa4 || alfa3 == alfa4){
          tmpword[i].score=0.0;
        }
        if((alfa4-alfa3)+(alfa3-alfa2)+(alfa2-alfa1) == 3){
          tmpword[i].score+=20.0;
        }
      }
      if(alfachecker(sp_word[0])){
        int select = 0;
        for(int j=0; j<sp_word.length; j++){
          if(sp_word[j].equals("動点")){
            select = 1;
            break;
          }
        }
        if(select == 1){
          int sum_douten=0;
          int flag_douten=0;
          List<Character> c = new ArrayList<Character>();
          for(int j=0; j<sp_word.length; j++){
            if(alfachecker(sp_word[j])){
              c.add(sp_word[j].charAt(0));
            }
            else{
              break;
            }
          }
          for(int j=c.size()-1; j>0; j--){
            sum_douten+= c.get(j) - c.get(j-1);
            if(c.get(j) == c.get(j-1)){
              
            }
          }
          if (sum_douten == c.size()-1){
            //println(tmpword[i].score + "+ 20.0");
            tmpword[i].score += 20.0;
          }
        }
      }
    }
    if(tmpword[0].word.length()!=0){
      sort(tmpword);
    }
    for(int i=0; i<tmpword.length;i++){
      if(tmpword[i].word.length()==0){
        break;
      }
      //println(tmpword[i].word);
      //println(tmpword[i].score);
    }
    
    
    
    
    
    //background(col);
     x -= 1;
    if ( x == -50) {
        x = 550;
        y = random(width - 50);
    }
    text(word,x,y);
    
    return tmpword[0].word;
}
 
//これ以降がJuliusとの連携部分
  

class Candidate {
  float score;
  String word="";

  Candidate(){
    score = 0.0;
    word = "";
  }
}

boolean alfachecker(char c){
  boolean flag = false;
  char[] alfas = {'A','B','C','D','E','F','G','H','I','M','N','O','P','Q','R'};
  for (char i : alfas){
    if(c == i){
      flag = true;
      break;
    }
  }
  return flag;
}

boolean alfachecker(String c){
  boolean flag = false;
  String[] alfas = {"A","B","C","D","E","F","G","H","I","M","N","O","P","Q","R"};
  for (String i : alfas){
    if(c.equals(i)){
      flag = true;
      break;
    }
  }
  return flag;
}

String InputBuf = "";  
Candidate[] getWord(){
    Candidate cand[] = {new Candidate(),new Candidate(),new Candidate(),new Candidate(),new Candidate()};
    if (myClient.available()>0){
        String dataIn = myClient.readString();
        InputBuf = InputBuf + dataIn;
        
        //if(InputBuf.LastIndexof(".") == InputBuf.length() - 3  )
        
        ////println("[" + InputBuf + "]");
        if(InputBuf.endsWith("\n.\n")){
        
          String[] dataInList = split(InputBuf, "\n.\n");
          InputBuf = "";
          
          ////println(dataInList.length);
          for(int i=0;i<dataInList.length;i++){
            if(dataInList[i].length()>0)
            {          
              ////println("----------------------");
              ////println(dataInList[i]);
              
              XML xml = parseXML(dataInList[i]);
              XML[] children_rank = xml.getChildren("SHYPO");
              ////println(children_rank.length);
              
              ////println("----------------------");
              for(int j=0; j<children_rank.length; j++){
                cand[j].score = float(children_rank[j].getString("SCORE"));
                XML[] children_word = children_rank[j].getChildren("WHYPO");
                for(int k=0; k<children_word.length; k++){
                  String tmp = children_word[k].getString("WORD");
                  if(tmp.equals("＜sp＞")==false && tmp.equals("＜s＞")==false && tmp.equals("＜/s＞")==false){
                    cand[j].word += tmp;
                    if(k < children_word.length - 2){
                      cand[j].word += " ";
                    }
                  }
                }
              }
            }
          }
        }
    }        
    return cand;
}

void sort(Candidate[] cand){
  for(int i=0; i< cand.length-1; i++){
    for(int j=i+1; j<cand.length; j++){
      if(cand[i].score < cand[j].score) {
        Candidate c = cand[j];
        cand[j] = cand[i];
        cand[i] = c;
      }
    }
  }
}
}
