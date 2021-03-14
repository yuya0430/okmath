class Coordinate{
  float x;           //coordinate of x
  float y;           //coordinate of y
  String Name; //the name of Vertex
  
  Coordinate(float x , float y , String Name){
    this.x = x;
    this.y = y;
    this.Name = Name;
  }
  
  void setX(float a){
    x = a; 
  }
  void setY(float a){
    y = a; 
  }
  
  void setXY(float a , float b){
    x = a;
    y = b;
  }
  
  void setName(String A){
    Name = A; 
  }
}
