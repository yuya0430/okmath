class Diagram{
  
  void setup(){
  //size(1000,1000);
  //size(1000,1000 , P3D);  //3D Object Display
  //fullScreen();
  background(0);
  //frameRate(0.5);
  frameRate(30);
  println("call d.setup()");
}

void Vertgenerate3(ArrayList<Coordinate> vertexlist , ArrayList<LineSegment> segmentlist , String A , String B , String C ){ // Function for Defining the basic three vertex
     Vertex(vertexlist , segmentlist , 350 , 200 , A);
     Vertex(vertexlist , segmentlist , 300 , 900 , B);
     Vertex(vertexlist , segmentlist , 700 , 900 , C);
}

void Vertgenerate4(ArrayList<Coordinate> vertexlist , ArrayList<LineSegment> segmentlist , String A , String B , String C , String D){// Function for Defining the basic four vertex
     Vertex(vertexlist , segmentlist , 200 , 300 , A);
     Vertex(vertexlist , segmentlist , 200 , 700 , B);
     Vertex(vertexlist , segmentlist , 800 , 700 , C);
     Vertex(vertexlist , segmentlist , 800 , 300 , D);
}

void Vertgenerate3lis(ArrayList<Coordinate> vertexlist , ArrayList<LineSegment> segmentlist , ArrayList<String> v){ // Function for Defining the basic three vertex
     Vertex(vertexlist , segmentlist , 350 , 200 , v.get(0));
     Vertex(vertexlist , segmentlist , 300 , 900 , v.get(1));
     Vertex(vertexlist , segmentlist , 700 , 900 , v.get(2));
}

void Vertgenerate4lis(ArrayList<Coordinate> vertexlist , ArrayList<LineSegment> segmentlist ,ArrayList<String> v){// Function for Defining the basic four vertex
     Vertex(vertexlist , segmentlist , 200 , 300 , v.get(0));
     Vertex(vertexlist , segmentlist , 200 , 700 , v.get(1));
     Vertex(vertexlist , segmentlist , 800 , 700 , v.get(2));
     Vertex(vertexlist , segmentlist , 800 , 300 , v.get(3));
}

void Vertex(ArrayList<Coordinate> vertexlist ,ArrayList<LineSegment> segmentlist, float x , float y ,String Name){ //Function for drawing arbitrary Vertex(x,y)
  vertexlist.add(new Coordinate(x,y,Name));        //Resister the new vertex
  float length = 0;
  int vertexnum = vertexlist.size();
  for(int i = 0; i < vertexnum-1 ; i++){           //Resister all of the line segments concerning this new vertex
    segmentlist.add(new LineSegment(vertexlist.get(i) , vertexlist.get(vertexnum-1) , length));
  } 
}

void Line(ArrayList<Coordinate> vertexlist ,ArrayList<LineSegment> segmentlist, String A , String B){ //Function of drawing the Line segment AB
  LineSegment seg = LineInfo(segmentlist , A , B);
  stroke(255);
  line((seg.vert1).x , (seg.vert1).y , (seg.vert2).x , (seg.vert2).y);
}

void Linelis(ArrayList<Coordinate> vertexlist ,ArrayList<LineSegment> segmentlist, ArrayList<String> v){ //Function of drawing the Line segment AB
  String A = v.get(0);
  String B = v.get(1);
  LineSegment seg = LineInfo(segmentlist , A , B);
  stroke(255);
  line((seg.vert1).x , (seg.vert1).y , (seg.vert2).x , (seg.vert2).y);
}

Coordinate VertexInfo(ArrayList<Coordinate> vertexlist , String A){ //Function for getting Vertex information from vertex-name
  int vertexnum = vertexlist.size(); 
  Coordinate temp = vertexlist.get(0);
  for(int i = 0 ; i < vertexnum ; i++){
     temp = vertexlist.get(i);
     if(temp.Name == A) break;
  }
  return temp;
}


LineSegment LineInfo(ArrayList<LineSegment> segmentlist , String A , String B){ //Function for getting information line segment from two vertex-name
  int segmentnum = segmentlist.size();
  LineSegment temp = segmentlist.get(0);
  for(int i = 0 ; i < segmentnum ; i++){
     temp = segmentlist.get(i);
     if(((temp.vert1).Name == A && (temp.vert2).Name == B)  || ((temp.vert1).Name == B  && (temp.vert2).Name == A)) break;
  }
  return temp;
}

void CrossPoint(ArrayList<Coordinate> vertexlist , ArrayList<LineSegment> segmentlist , String A , String B , String C , String D , String E){  //Function for drawing the Crosspoint of LineAB and LineCD
   Coordinate a = VertexInfo(vertexlist , A);
   Coordinate b = VertexInfo(vertexlist , B);
   Coordinate c = VertexInfo(vertexlist , C);
   Coordinate d = VertexInfo(vertexlist , D);
   
   float a1 , a2 , b1 , b2;
   //Calcurate the cross point of LineSegmentAB and LineSegmentCD (y=a1x + b1 and y = a2x + b2)
   a1 = (b.y - a.y)/(b.x - a.x);
   a2 = (d.y - c.y)/(d.x - c.x);
   //b1 = a.y - ((b.y - a.y)/(b.x - a.x))*a.x;
   //b2 = c.y - ((d.y - c.y)/(d.x - c.x))*c.x;
   b1 = a.y - a1*a.x;
   b2 = c.y - a2*c.x;
   
   float crossx , crossy;
   crossx = (b2 - b1)/(a1 - a2);
   crossy = ((b2 - b1)/(a1 - a2))*a1 + b1;
   
   Vertex(vertexlist , segmentlist , crossx , crossy , E);
   Line(vertexlist , segmentlist , A , E);
   Line(vertexlist , segmentlist , B , E);
   Line(vertexlist , segmentlist , C , E);
   Line(vertexlist , segmentlist , D , E);
}

void CrossPointlis(ArrayList<Coordinate> vertexlist , ArrayList<LineSegment> segmentlist , ArrayList<String> v1 , ArrayList<String> v2 , ArrayList<String> v3){  //Function for drawing the Crosspoint of LineAB and LineCD
   String A = v1.get(0);
   String B = v1.get(1);
   String C = v2.get(0);
   String D = v2.get(1);
   String E = v3.get(0);
   
   Coordinate a = VertexInfo(vertexlist , A);
   Coordinate b = VertexInfo(vertexlist , B);
   Coordinate c = VertexInfo(vertexlist , C);
   Coordinate d = VertexInfo(vertexlist , D);
   
   float a1 , a2 , b1 , b2;
   //Calcurate the cross point of LineSegmentAB and LineSegmentCD (y=a1x + b1 and y = a2x + b2)
   a1 = (b.y - a.y)/(b.x - a.x);
   a2 = (d.y - c.y)/(d.x - c.x);
   //b1 = a.y - ((b.y - a.y)/(b.x - a.x))*a.x;
   //b2 = c.y - ((d.y - c.y)/(d.x - c.x))*c.x;
   b1 = a.y - a1*a.x;
   b2 = c.y - a2*c.x;
   
   float crossx , crossy;
   crossx = (b2 - b1)/(a1 - a2);
   crossy = ((b2 - b1)/(a1 - a2))*a1 + b1;
   
   Vertex(vertexlist , segmentlist , crossx , crossy , E);
   Line(vertexlist , segmentlist , A , E);
   Line(vertexlist , segmentlist , B , E);
   Line(vertexlist , segmentlist , C , E);
   Line(vertexlist , segmentlist , D , E);
}

/*float[] CrossPointc(ArrayList<Coordinate> vertexlist, ArrayList<LineSegment> segmentlist , String A , Coordinate x , String B , Coordinate y){ //Return the coordinate of Cross Point for Ax and By
   Coordinate a = VertexInfo(vertexlist , A);
   Coordinate b = VertexInfo(vertexlist , B);
   
   float a1 , a2 , b1 , b2;
   a1 = (a.y - x.y)/(a.x - x.x);
   a2 = (b.y - y.y)/(b.x - y.x);
   b1 = a.y - a1*x.x;
   b2 = b.y - a2*y.x;
   
   float[] cross = new float[2];
   cross[0] = (b2 - b1)/(a1 - a2);
   cross[1] = ((b2 - b1)/(a1 - a2))*a1 + b1;
   
   return cross;
}*/

float[] CrossPointc(ArrayList<Coordinate> vertexlist, ArrayList<LineSegment> segmentlist , Coordinate a , Coordinate x , Coordinate b , Coordinate y){ //Return the coordinate of Cross Point for Ax and By
   
   float a1 , a2 , b1 , b2;
   a1 = (a.y - x.y)/(a.x - x.x);
   a2 = (b.y - y.y)/(b.x - y.x);
   b1 = a.y - a1*a.x;
   b2 = b.y - a2*b.x;
   
   float[] cross = new float[2];
   cross[0] = (b2 - b1)/(a1 - a2);
   cross[1] = ((b2 - b1)/(a1 - a2))*a1 + b1;
   
   return cross;
}

void ParallelLine(ArrayList<Coordinate> vertexlist , ArrayList<LineSegment> segmentlist , String A , String B , String C){ //Function for culculate the parallel-line of AB through C
  Coordinate a = VertexInfo(vertexlist , A);
  Coordinate b = VertexInfo(vertexlist , B);
  Coordinate c = VertexInfo(vertexlist , C);
  
  float a1 , a2 , b1 , b2 ;
  float[] paramater;
  //AB: y = a1x + b1
  a1 = (b.y - a.y)/(b.x - a.x);
  b1 = a.y - ((b.y - a.y)/(b.x - a.x))*a.x;
  a2 = a1;
  b2 = c.y - a2*c.x;
}


void ChangeX(ArrayList<Coordinate> vertexlist ,String A , float value){         //Function for changeing the x-coordinate of arbitrary vertex
  Coordinate a = VertexInfo(vertexlist , A);
  a.setX(value);
}

void ChangeY(ArrayList<Coordinate> vertexlist , String A , float value){        //Function for changing the y-coordinate of arbitrary vertex
  Coordinate a = VertexInfo(vertexlist , A);
  a.setY(value);
}

void SwapName(ArrayList<Coordinate> vertexlist , String A , String B){
   Coordinate a = VertexInfo(vertexlist , A);
   Coordinate b = VertexInfo(vertexlist , B);
   a.Name = B;
   b.Name = A;
}

void RotateName(ArrayList<Coordinate> vertexlist , String A , String B , String C){
   Coordinate a = VertexInfo(vertexlist , A);
   Coordinate b = VertexInfo(vertexlist , B);
   Coordinate c = VertexInfo(vertexlist , C);
   a.Name = C;
   b.Name = A;
   c.Name = B;
}

void Circle(int r){
   ellipse(300 , 300 , r , r); 
}

void Inscribe(ArrayList<Coordinate> vertexlist , String A , String B , String C){
  Coordinate a = VertexInfo(vertexlist , A);
  Coordinate b = VertexInfo(vertexlist , B);
  Coordinate c = VertexInfo(vertexlist , C);
  
  float dxAB = a.x - b.x;
  float dyAB = a.y - b.y;
  float dxBC = b.x - c.x;
  float dyBC = b.y - c.y;
  float dxAC = a.x - c.x;
  float dyAC = a.y - c.y;
  float lengthAB = sqrt(dxAB*dxAB + dyAB*dyAB);
  float lengthBC = sqrt(dxBC*dxBC + dyBC*dyBC);
  float lengthAC = sqrt(dxAC*dxAC + dyAC*dyAC);
  float insx , insy;
  
  float[] temp1 = InternalDivisionc(vertexlist , segmentlist , A , B , lengthAC , lengthBC);
  float[] temp2 = InternalDivisionc(vertexlist , segmentlist , A , C , lengthAB , lengthBC);
  float IDP1x = temp1[0];
  float IDP1y = temp1[1];
  float IDP2x = temp2[0];
  float IDP2y = temp2[1];
  
  Vertex(vertexlist ,segmentlist, IDP1x , IDP1y , "T");
  Vertex(vertexlist ,segmentlist, IDP2x , IDP2y , "S");
  Line(vertexlist , segmentlist , "B" , "S");
  Line(vertexlist , segmentlist , "C" , "T");
  
  
  Coordinate x = new Coordinate(IDP1x , IDP1y , "Z1");
  Coordinate y = new Coordinate(IDP2x , IDP2y , "Z2");
  
  float[] InnerCenter = new float[2];
  InnerCenter = CrossPointc(vertexlist , segmentlist , c , x , b , y);
  
  float Centerx = InnerCenter[0]; //x-coordinate of inscribe
  float Centery = InnerCenter[1]; //y-coordinate of inscribe
  
  float gradAB = (b.y - a.y)/(b.x - a.x);
  float InterceptAB = a.y - gradAB*a.x;
  float h = (abs(-gradAB*c.x + c.y - InterceptAB))/(sqrt(gradAB*gradAB + 1)); //distance of LineSegmentAB and VertexC
  float area = (h*lengthAB)/2;
  
  //float diameter = (lengthBC*(b.y-a.y))*2/(lengthAB + lengthBC + lengthAC); //the diameter of the inscribe(diameter = area*2/sum of edge length
  float diameter = (area)*2/(lengthAB + lengthBC + lengthAC); //the diameter of the inscribe(diameter = area*2/sum of edge length)
  stroke(255);
  noFill();
  ellipse(Centerx , Centery , diameter , diameter); // draw the inscribe
  Vertex(vertexlist , segmentlist , Centerx , Centery , "I");
}

void Inscribelis(ArrayList<Coordinate> vertexlist , ArrayList<String> v){
  Coordinate a = VertexInfo(vertexlist , v.get(0));
  Coordinate b = VertexInfo(vertexlist , v.get(1));
  Coordinate c = VertexInfo(vertexlist , v.get(2));
  
  float dxAB = a.x - b.x;
  float dyAB = a.y - b.y;
  float dxBC = b.x - c.x;
  float dyBC = b.y - c.y;
  float dxAC = a.x - c.x;
  float dyAC = a.y - c.y;
  float lengthAB = sqrt(dxAB*dxAB + dyAB*dyAB);
  float lengthBC = sqrt(dxBC*dxBC + dyBC*dyBC);
  float lengthAC = sqrt(dxAC*dxAC + dyAC*dyAC);
  float insx , insy;
  
  float[] temp1 = InternalDivisionc(vertexlist , segmentlist , v.get(0) , v.get(1) , lengthAC , lengthBC);
  float[] temp2 = InternalDivisionc(vertexlist , segmentlist , v.get(0) , v.get(2) , lengthAB , lengthBC);
  float IDP1x = temp1[0];
  float IDP1y = temp1[1];
  float IDP2x = temp2[0];
  float IDP2y = temp2[1];
  
  /*Vertex(vertexlist ,segmentlist, IDP1x , IDP1y , "T");
  Vertex(vertexlist ,segmentlist, IDP2x , IDP2y , "S");
  Line(vertexlist , segmentlist , "B" , "S");
  Line(vertexlist , segmentlist , "C" , "T");*/
  
  
  Coordinate x = new Coordinate(IDP1x , IDP1y , "Z1");
  Coordinate y = new Coordinate(IDP2x , IDP2y , "Z2");
  
  float[] InnerCenter = new float[2];
  InnerCenter = CrossPointc(vertexlist , segmentlist , c , x , b , y);
  
  float Centerx = InnerCenter[0]; //x-coordinate of inscribe
  float Centery = InnerCenter[1]; //y-coordinate of inscribe
  
  float gradAB = (b.y - a.y)/(b.x - a.x);
  float InterceptAB = a.y - gradAB*a.x;
  float h = (abs(-gradAB*c.x + c.y - InterceptAB))/(sqrt(gradAB*gradAB + 1)); //distance of LineSegmentAB and VertexC
  float area = (h*lengthAB)/2;
  
  //float diameter = (lengthBC*(b.y-a.y))*2/(lengthAB + lengthBC + lengthAC); //the diameter of the inscribe(diameter = area*2/sum of edge length
  float diameter = (area)*4/(lengthAB + lengthBC + lengthAC); //the diameter of the inscribe(diameter = area*2/sum of edge length)
  stroke(255);
  noFill();
  ellipse(Centerx , Centery , diameter , diameter); // draw the inscribe
  Vertex(vertexlist , segmentlist , Centerx , Centery , "I");
}

void Circumcircle(ArrayList<Coordinate> vertexlist , String A, String B , String C){
  Coordinate a = VertexInfo(vertexlist , A);
  Coordinate b = VertexInfo(vertexlist , B);
  Coordinate c = VertexInfo(vertexlist , C);
  
  float midABx = (a.x + b.x)/2;
  float midABy = (a.y + b.y)/2;
  float midACx = (a.x + c.x)/2;
  float midACy = (a.y + c.y)/2;
  
  float gradAB , gradAC;
  gradAB = (b.y - a.y)/(b.x - a.x);
  gradAC = (c.y - a.y)/(c.x - a.x);
  
  float a1 , b1 , a2 , b2; //AB:y=a1x+b1 , AC:y=a2x+b2
  a1 = -1/gradAB;
  b1 = midABy - a1*midABx;
  a2 = -1/gradAC;
  b2 = midACy - a2*midACx;
  
  float centerx , centery;
  centerx = (b2 - b1)/(a1 - a2);
  centery = ((b2 - b1)/(a1 - a2))*a1 + b1;
  
  float dxAB = a.x - b.x;
  float dyAB = a.y - b.y;
  float dxBC = b.x - c.x;
  float dyBC = b.y - c.y;
  float dxAC = a.x - c.x;
  float dyAC = a.y - c.y;
  float lengthAB = sqrt(dxAB*dxAB + dyAB*dyAB);
  float lengthBC = sqrt(dxBC*dxBC + dyBC*dyBC);
  float lengthAC = sqrt(dxAC*dxAC + dyAC*dyAC);
  
 
  float InterceptAB = a.y - gradAB*a.x;
  float h = (abs(-gradAB*c.x + c.y - InterceptAB))/(sqrt(gradAB*gradAB + 1)); //distance of LineSegmentAB and VertexC
  float area = (h*lengthAB)/2;
  float diameter = (2*lengthAB*lengthBC*lengthAC)/(4*area);
  //println(centerx + " , "+ centery + " , " + diameter);
  
  stroke(255);
  noFill();
  ellipse(centerx , centery , diameter , diameter);
  Vertex(vertexlist , segmentlist , centerx , centery , "O");
}

void Circumcirclelis(ArrayList<Coordinate> vertexlist , ArrayList<String> v){
  Coordinate a = VertexInfo(vertexlist , v.get(0));
  Coordinate b = VertexInfo(vertexlist , v.get(1));
  Coordinate c = VertexInfo(vertexlist , v.get(2));
  
  float midABx = (a.x + b.x)/2;
  float midABy = (a.y + b.y)/2;
  float midACx = (a.x + c.x)/2;
  float midACy = (a.y + c.y)/2;
  
  float gradAB , gradAC;
  gradAB = (b.y - a.y)/(b.x - a.x);
  gradAC = (c.y - a.y)/(c.x - a.x);
  
  
  float a1 , b1 , a2 , b2;
  a1 = -1/gradAB;
  b1 = midABy - a1*midABx;
  a2 = -1/gradAC;
  b2 = midACy - a2*midACx;
  
  float centerx , centery;
  centerx = (b2 - b1)/(a1 - a2);
  centery = ((b2 - b1)/(a1 - a2))*a1 + b1;
  
  float dxAB = a.x - b.x;
  float dyAB = a.y - b.y;
  float dxBC = b.x - c.x;
  float dyBC = b.y - c.y;
  float dxAC = a.x - c.x;
  float dyAC = a.y - c.y;
  float lengthAB = sqrt(dxAB*dxAB + dyAB*dyAB);
  float lengthBC = sqrt(dxBC*dxBC + dyBC*dyBC);
  float lengthAC = sqrt(dxAC*dxAC + dyAC*dyAC);
  
  
  float InterceptAB = a.y - gradAB*a.x;
  float h = (abs(-gradAB*c.x + c.y - InterceptAB))/(sqrt(gradAB*gradAB + 1)); //distance of LineSegmentAB and VertexC
  float area = (h*lengthAB)/2;
  float diameter = (2*lengthAB*lengthBC*lengthAC)/(4*area);
  stroke(255);
  noFill();
  ellipse(centerx , centery , diameter , diameter);
  Vertex(vertexlist , segmentlist , centerx , centery , "O");
}

void Triangle(ArrayList<Coordinate> vertexlist , ArrayList<LineSegment> segmentlist ,  String A , String B ,String C){  //Generally ,the function of drawing Triangle
  noFill();
  stroke(255);
  triangle(VertexInfo(vertexlist , A).x , VertexInfo(vertexlist , A).y , VertexInfo(vertexlist , B).x , VertexInfo(vertexlist , B).y , VertexInfo(vertexlist , C).x , VertexInfo(vertexlist , C).y);
}


void Trianglelis(ArrayList<Coordinate> vertexlist , ArrayList<LineSegment> segmentlist , ArrayList<String> v){  //Generally ,the function of drawing Triangle
  String A = v.get(0);
  String B = v.get(1);
  String C = v.get(2);
  noFill();
  stroke(255);
  triangle(VertexInfo(vertexlist , A).x , VertexInfo(vertexlist , A).y , VertexInfo(vertexlist , B).x , VertexInfo(vertexlist , B).y , VertexInfo(vertexlist , C).x , VertexInfo(vertexlist , C).y);
}

//Function for drawing IsoscelesTriangle(AB=AC , AB:BC = ab;bc)
void IsoscelesTriangle(ArrayList<Coordinate> vertexlist , ArrayList<LineSegment> segmentlist , String A , String B , String C , float ab , float bc){
  Coordinate a = VertexInfo(vertexlist , A);
  Coordinate b = VertexInfo(vertexlist , B);
  Coordinate c = VertexInfo(vertexlist , C);
  
  float ax = (b.x + c.x)/2.0;
  
  ChangeX(vertexlist , A , ax);
  float lengthBC = sqrt(pow((c.x - b.x),2) + pow((c.y - b.y),2));                //calculate length of line segment"BC"
  for(int i = (int)b.y ; i > 0 ; i--){
    ChangeY(vertexlist , A , i);
    float lengthAB = sqrt(pow((b.x - a.x) , 2) + pow((b.y - a.y) ,2));           //calculate length of line segment"AB" again 
    if((lengthAB)*bc < (lengthBC*ab)+10 && (lengthAB)*bc > (lengthBC*ab)-10) break;
  }
  Triangle(vertexlist , segmentlist , A , B ,C);
}


void IsoscelesTrianglelis(ArrayList<Coordinate> vertexlist , ArrayList<LineSegment> segmentlist , ArrayList<String> v , float ab , float bc){
  String A = v.get(0);
  String B = v.get(1);
  String C = v.get(2);
  
  Coordinate a = VertexInfo(vertexlist , A);
  Coordinate b = VertexInfo(vertexlist , B);
  Coordinate c = VertexInfo(vertexlist , C);
  
  float ax = (b.x + c.x)/2.0;
  
  ChangeX(vertexlist , A , ax);
  float lengthBC = sqrt(pow((c.x - b.x),2) + pow((c.y - b.y),2));                //calculate length of line segment"BC"
  for(int i = (int)b.y ; i > 0 ; i--){
    ChangeY(vertexlist , A , i);
    float lengthAB = sqrt(pow((b.x - a.x) , 2) + pow((b.y - a.y) ,2));           //calculate length of line segment"AB" again 
    if((lengthAB)*bc < (lengthBC*ab)+10 && (lengthAB)*bc > (lengthBC*ab)-10) break;
  }
  Triangle(vertexlist , segmentlist , A , B , C );
}

//Function for drawing RightTriangle(∠C = 90°)
void RightTriangle(ArrayList<Coordinate> vertexlist , ArrayList<LineSegment> segmentlist , String A , String B , String C ,float angle){
    Coordinate a = VertexInfo(vertexlist , A);
    Coordinate b = VertexInfo(vertexlist , B);
    Coordinate c = VertexInfo(vertexlist , C); 
    
    ChangeX(vertexlist , "A" , c.x);
    
    float lengthBC = sqrt(pow((c.x - b.x),2) + pow((c.y - b.y),2));                //calculate length of line segment"BC"
    for(int i = (int)c.y ; i > 0 ; i--){
      ChangeY(vertexlist , "A" , i);
      float lengthAB = sqrt(pow((b.x - a.x) , 2) + pow((b.y - a.y) ,2));            //calculate length of line segment"AB" again 
      if(lengthAB*cos(radians(angle)) < lengthBC+10 && lengthAB*cos(radians(angle)) > lengthBC -10) break;
    }
    
    Triangle(vertexlist , segmentlist , A, B, C);
}

void RightTrianglelis(ArrayList<Coordinate> vertexlist , ArrayList<LineSegment> segmentlist , ArrayList<String> v ,float angle){
    String A = v.get(0);
    String B = v.get(1);
    String C = v.get(2);
    Coordinate a = VertexInfo(vertexlist , A);
    Coordinate b = VertexInfo(vertexlist , B);
    Coordinate c = VertexInfo(vertexlist , C); 
    
    ChangeX(vertexlist , A , c.x);
    float lengthBC = sqrt(pow((c.x - b.x),2) + pow((c.y - b.y),2));                //calculate length of line segment"BC"
    for(int i = (int)c.y ; i > 0 ; i--){
      ChangeY(vertexlist , A , i);
      float lengthAB = sqrt(pow((b.x - a.x) , 2) + pow((b.y - a.y) ,2));            //calculate length of line segment"AB" again 
      if(lengthAB*cos(radians(angle)) < lengthBC+10 && lengthAB*cos(radians(angle)) > lengthBC -10) break;
    }
    
    Triangle(vertexlist , segmentlist , A, B, C);
}


void Square(ArrayList<Coordinate> vertexlist , ArrayList<LineSegment> segmentlist ,  String A , String B ,String C , String D){ //Generally , the function of drawing Square
  noFill();
  stroke(255);
  float height = LineInfo(segmentlist , A , B).length;
  float width = LineInfo(segmentlist , B , C).length;
  rect(VertexInfo(vertexlist , A).x , VertexInfo(vertexlist , A).y , width , height);
}

void Squarelis(ArrayList<Coordinate> vertexlist , ArrayList<LineSegment> segmentlist , ArrayList<String> v){ //Generally , the function of drawing Square
  String A = v.get(0);
  String B = v.get(1);
  String C = v.get(2);
  String D = v.get(3);
  noFill();
  stroke(255);
  float height = LineInfo(segmentlist , A , B).length;
  float width = LineInfo(segmentlist , B , C).length;
  rect(VertexInfo(vertexlist , A).x , VertexInfo(vertexlist , A).y , width , height);
}


void Parallelogram(ArrayList<Coordinate> vertexlist , ArrayList<LineSegment> segmentlist , String A , String B , String C , String D){
   Coordinate a = VertexInfo(vertexlist , A);
   Coordinate b = VertexInfo(vertexlist , B);
   Coordinate c = VertexInfo(vertexlist , C);
   Coordinate d = VertexInfo(vertexlist , D);
   
   noFill();
   stroke(255);
   ChangeX(vertexlist , A , a.x+100);
   ChangeX(vertexlist , B , b.x-100);
   ChangeX(vertexlist , C , c.x-100);
   ChangeX(vertexlist , D , d.x+100);
   
   line(a.x , a.y , b.x , b.y);
   line(b.x , b.y , c.x , c.y);
   line(c.x , c.y , d.x , d.y);
   line(d.x , d.y , a.x , a.y);
}

void Parallelogramlis(ArrayList<Coordinate> vertexlist , ArrayList<LineSegment> segmentlist , ArrayList<String> v){
   String A = v.get(0);
   String B = v.get(1);
   String C = v.get(2);
   String D = v.get(3);
   Coordinate a = VertexInfo(vertexlist , A);
   Coordinate b = VertexInfo(vertexlist , B);
   Coordinate c = VertexInfo(vertexlist , C);
   Coordinate d = VertexInfo(vertexlist , D);
   
   noFill();
   stroke(255);
   ChangeX(vertexlist , A , a.x+100);
   ChangeX(vertexlist , B , b.x-100);
   ChangeX(vertexlist , C , c.x-100);
   ChangeX(vertexlist , D , d.x+100);
   
   line(a.x , a.y , b.x , b.y);
   line(b.x , b.y , c.x , c.y);
   line(c.x , c.y , d.x , d.y);
   line(d.x , d.y , a.x , a.y);
}
   


void InternalDivision(ArrayList<Coordinate> vertexlist ,ArrayList<LineSegment> segmentlist ,String A, String B , float a , float b , String Name){ //Function of drawing Internal Division Point(AD:DB = a:b)
  float sum = (a+b);
  Coordinate start = VertexInfo(vertexlist , A);
  Coordinate end = VertexInfo(vertexlist , B);
  float ix = (float)(start.x*b + end.x*a)/sum;  //x-Coordinate of Internal Division
  float iy = (float)(start.y*b + end.y*a)/sum;  //y-Coordinate of Internal Division
  
  Vertex(vertexlist,segmentlist, ix , iy , Name);
}

float[] InternalDivisionc(ArrayList<Coordinate> vertexlist , ArrayList<LineSegment> segmentlist , String A , String B , float a , float b){ //Function of returning the coordinate of Internal Division Point
  float sum = (a+b);
  Coordinate start = VertexInfo(vertexlist , A);
  Coordinate end = VertexInfo(vertexlist , B);
  float ix = (float)(start.x*b + end.x*a)/sum;  //x-Coordinate of Internal Division
  float iy = (float)(start.y*b + end.y*a)/sum;  //y-Coordinate of Internal Division
  
  float[] parameter = new float[2];
  parameter[0] = ix;
  parameter[1] = iy;
  return parameter;
}

void InternalDivisionlis(ArrayList<Coordinate> vertexlist ,ArrayList<LineSegment> segmentlist , ArrayList<String> v1 , ArrayList<Integer> n , ArrayList<String> v2){ //Function of drawing Internal Division Point(AD:DB = a:b)
  String A = v1.get(0);
  String B = v1.get(1);
  int a = n.get(0);
  int b = n.get(1);
  String Name = v2.get(0);
  
  float sum = (a+b);
  Coordinate start = VertexInfo(vertexlist , A);
  Coordinate end = VertexInfo(vertexlist , B);
  float ix = (float)(start.x*b + end.x*a)/sum;  //x-Coordinate of Internal Division
  float iy = (float)(start.y*b + end.y*a)/sum;  //y-Coordinate of Internal Division
  
  Vertex(vertexlist,segmentlist, ix , iy , Name);
}

void Region3(ArrayList<Coordinate> vertexlist , ArrayList<LineSegment> segmentlist , String A , String B , String C){ //Function for showing Triangle"ABC" Region
  Coordinate a = VertexInfo(vertexlist , A);
  Coordinate b = VertexInfo(vertexlist , B);
  Coordinate c = VertexInfo(vertexlist , C);
  
  fill(0,255,255,180);
  noStroke();
  beginShape();
    vertex(a.x , a.y);
    vertex(b.x , b.y);
    vertex(c.x , c.y);
  endShape(CLOSE);
  fill(255);
}

void Region3lis(ArrayList<Coordinate> vertexlist , ArrayList<LineSegment> segmentlist , ArrayList<String> v){ //Function for showing Triangle"ABC" Region
  String A = v.get(0);
  String B = v.get(1);
  String C = v.get(2);
  
  Coordinate a = VertexInfo(vertexlist , A);
  Coordinate b = VertexInfo(vertexlist , B);
  Coordinate c = VertexInfo(vertexlist , C);
  
  fill(0,255,255,180);
  noStroke();
  beginShape();
    vertex(a.x , a.y);
    vertex(b.x , b.y);
    vertex(c.x , c.y);
  endShape(CLOSE);
  fill(255);
}

void Region4(ArrayList<Coordinate> vertexlist , ArrayList<LineSegment> segmentlist , String A , String B , String C , String D){ //Function for showing Square"ABCD" Region
  Coordinate a = VertexInfo(vertexlist , A);
  Coordinate b = VertexInfo(vertexlist , B);
  Coordinate c = VertexInfo(vertexlist , C);
  Coordinate d = VertexInfo(vertexlist , D);
  
  fill(255,0,255,180);
  noStroke();
  beginShape();
    vertex(a.x , a.y);
    vertex(b.x , b.y);
    vertex(c.x , c.y);
    vertex(d.x , d.y);
  endShape(CLOSE);
  fill(255);
}

void Region4lis(ArrayList<Coordinate> vertexlist , ArrayList<LineSegment> segmentlist , ArrayList<String> v){ //Function for showing Square"ABCD" Region
  String A = v.get(0);
  String B = v.get(1);
  String C = v.get(2);
  String D = v.get(3);
  Coordinate a = VertexInfo(vertexlist , A);
  Coordinate b = VertexInfo(vertexlist , B);
  Coordinate c = VertexInfo(vertexlist , C);
  Coordinate d = VertexInfo(vertexlist , D);
  
  fill(255,0,255,180);
  noStroke();
  beginShape();
    vertex(a.x , a.y);
    vertex(b.x , b.y);
    vertex(c.x , c.y);
    vertex(d.x , d.y);
  endShape(CLOSE);
  fill(255);
}

float MovingPoint(ArrayList<Coordinate> vertexlist ,ArrayList<LineSegment> segmentlist , int divisionnum , float t ,String A , String B , String P){ //Function for showing  MovingPoint P
  float speed = 1.0/(float)divisionnum;    //Definition of the speed of the Movingpoint
  InternalDivision(vertexlist , segmentlist , A , B ,t , 1-t , P); 
  t += speed;
  return t;
}

float MovingPoint3(ArrayList<Coordinate> vertexlist , String A , String B , String C ,String D ,  float s , int count){
  int edgenum = 3;
   int moveparamater = 1;
    for(int i = 1 ; i <=edgenum ; i++){
      if(count <= 100*i && count > 100*(i-1)){
        moveparamater = i;
        break;
      }
      else{
        moveparamater = edgenum+1;
      }
   }
   switch(moveparamater){
     case 1: s = MovingPoint(vertexlist , segmentlist , 100 , s ,A , B , "P" );
          if(count == 100*moveparamater){
          s = 0; 
          }
          break;
          
     case 2: s = MovingPoint(vertexlist , segmentlist , 100 , s ,B , C , "P" );
          if(count == 100*moveparamater){
          s = 0; 
          }
          break;
          
     case 3: s = MovingPoint(vertexlist , segmentlist , 100 , s ,C , D, "P" );
          if(count == 100*moveparamater){
          s = 0; 
          } 
          break;
          
     default: break;   
   }
 if(count == edgenum*100) count = 0;
 return s;
}

float MovingPoint3lis(ArrayList<Coordinate> vertexlist , ArrayList<String> v1,ArrayList<String> v2 , float s , int count){
    String A = v1.get(0);
    String B = v1.get(1);
    String C = v1.get(2);
    String D = v1.get(3);
    String P = v2.get(0);
   
  
  int edgenum = 3;
   int moveparamater = 1;
    for(int i = 1 ; i <=edgenum ; i++){
      if(count <= 100*i && count > 100*(i-1)){
        moveparamater = i;
        break;
      }
      else{
        moveparamater = edgenum+1;
      }
   }
   switch(moveparamater){
     case 1: s = MovingPoint(vertexlist , segmentlist , 100 , s ,A , B , P );
          if(count == 100*moveparamater){
          s = 0; 
          }
          break;
          
     case 2: s = MovingPoint(vertexlist , segmentlist , 100 , s ,B , C , P );
          if(count == 100*moveparamater){
          s = 0; 
          }
          break;
          
     case 3: s = MovingPoint(vertexlist , segmentlist , 100 , s ,C , D, P );
          if(count == 100*moveparamater){
          s = 0; 
          } 
          break;
          
     default: break;   
   }
 if(count == edgenum*100) count = 0;
 //println("count = " + count + " , " + "s = "  + s);
 return s;
}


void LengthDisplay(ArrayList<Coordinate> vertexlist , ArrayList<LineSegment> segmentlist , String A , String B , String num){//Function for showing the length of Linesegment"AB"
  Coordinate a = VertexInfo(vertexlist , A);
  Coordinate b = VertexInfo(vertexlist , B);
  
  fill(255 , 0 , 0);
  float midx = (a.x + b.x)/2.0;
  float midy = (a.y + b.y)/2.0;
  textSize(24);
  text(num , midx-10 , midy-10);
  fill(255);
    
}

ArrayList<String> VertexNameSearch(String input){ //Function for search the alphabet in sequence"input"
  String[] alphabet = {"A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z"};
  String[] spl = split(input , " ");
  ArrayList<String> vertexname = new ArrayList<String>();
  for(int i = 0 ; i < spl.length ; i++){
     for(int j = 0 ; j < alphabet.length ; j++){
       if(spl[i].equals(alphabet[j])){
           vertexname.add(alphabet[j]);
       }
     }
  }
  return vertexname;
}

boolean VertexExistCheck(ArrayList<Coordinate> vertexlist , ArrayList<String> inputlist , ArrayList<String> v){ //操作対象の頂点がすでに存在するかの確認
  boolean check = true;
  //生成した頂点名を格納したリスト
  ArrayList<String> vertstr = new ArrayList<String>(); 
  for(int i = 0 ; i < vertexlist.size() ; i++){
    vertstr.add(vertexlist.get(i).Name);  
  }
  vertstr.add("P"); //動点ができるようになるがPの入力ミスは検出できなくなる
  if(vertexlist.size() == 0){ //まだ頂点が一つもない状態での処理
     /*background(0);
     fill(255,0,0);
     textSize(50);
     text("Please Generate Vertex !!" , 300 , 450);
     fill(255);
     delay(3000);*/
     //inputlist.remove(inputlist.size()-1);
     //println("You haven't generate vertex yet! , inputlist.size = " + inputlist.size());
     check = false;
  }
  else{
    Boolean flag = true;
    for(int j = 0 ; j < v.size() ; j++){
      flag  = vertstr.contains(v.get(j)); // 入力の頂点名がvertexlistに含まれていないときfalse
      if(flag == false){
        //println("error = " + error);
        /*background(0);
        fill(255,0,0);
        textSize(50);
        text("Please Generate Vertex !!" , 300 , 450);
        fill(255);
        delay(3000);*/
        check = false;
        //inputlist.remove(inputlist.size()-1); //毎回エラーが出るのを防ぐために入力を削除
        //println("NOT EXIST, intputlist.size = " + inputlist.size());
        break;
      }
    }
  }
  return check;
}

boolean DuplicationCheck(ArrayList<Coordinate> vertexlist, ArrayList<String> inputlist , ArrayList<String> v ){
  boolean check = true;
  for(int i = 0 ; i < v.size() ; i++){
     String S = v.get(i);
     if(v.indexOf(S) != v.lastIndexOf(S)){
        /*background(0);
        fill(255,0,0);
        textSize(50);
        text("ERROR! Duplication of vertex happend" , 300, 450);
        fill(255);
        delay(3000);*/
        check = false;
        //inputlist.remove(inputlist.size()-1); //毎回エラーが出るのを防ぐために入力を削除
        //println("Duplication happend! , inputlist.size() = " + inputlist.size());
        break;
     }
  } 
  return check;
}

String ErrorCheck(ArrayList<Coordinate> vertexlist, ArrayList<String> inputlist , ArrayList<String> v ){
  String error;
  Boolean check = VertexExistCheck(vertexlist , inputlist , v);
  if(DuplicationCheck(vertexlist , inputlist , v) == false) error = "Duplication";
  else if(check == false && vertexlist.size() == 0) error = "Novertex";
  else if(check == false ) error = "NotExist";
  else error = "";
  return error;
}


ArrayList<Integer> NumberSearch(String input){
    String[] number = {"1","2","3","4","5","6","7","8","9"};
    String[] spl = split(input , " ");
    ArrayList<Integer> numlist = new ArrayList<Integer>();
    for(int i =0 ; i < spl.length ; i++){
      for(int j = 0 ; j < number.length ; j++){
         if(spl[i].equals(number[j])){
            numlist.add(j+1); 
         }
      }
    }
  return numlist;
}

void VertexDisplay(ArrayList<Coordinate> vertexlist){
  fill(255);
  int vertexnum = vertexlist.size();
  for(int i = 0 ; i < vertexnum ; i++){
     ellipse(vertexlist.get(i).x , vertexlist.get(i).y , 10 ,10); 
  }
}

void NameDisplay(ArrayList<Coordinate> vertexlist){ //Function of showing the name of all vertexes
  fill(255,255,0);
  textSize(36);
  int vertexnum = vertexlist.size();
  for(int i = 0 ; i < vertexnum ; i++){
    text(vertexlist.get(i).Name , vertexlist.get(i).x+10 , vertexlist.get(i).y+10); 
  }
}

void CreateString(StringBuilder ES , String Sn){
    Sn = Sn.replace(" " , "");
    ES.append(Sn+"\n");
}

void AddString(StringBuilder ES , String Sn){
    Sn = Sn.replace(" " , "");
    ES.append("  ↓\n" + Sn + "\n");  
} 


void keyPressed(){
    println(keyPressed);
    loop();
}

ArrayList<Coordinate> vertexlist = new ArrayList<Coordinate>();    //the list of vertex
ArrayList<LineSegment> segmentlist = new ArrayList<LineSegment>(); //the list of linesegment
//ArrayList<Float> lengthlist = new ArrayList<Float>();              //the list of linesegment's length
float s = 0;     //parameter for controlling the speed of moving point 
int count = 1;

ArrayList<String> inputlist = new ArrayList<String>();             //the list of Input
boolean transform = false;                                         //flag of need of changing the shape of Triangle or Square
boolean gene = false;
String error="";
String S;


/*void draw(){
  background(0);
  //String S = "三角形";
  String S = "四角形";
  if(S == "三角形"){
    //Draw the Triangle
    Vertex(vertexlist , segmentlist , 350 , 200 , "A");
    Vertex(vertexlist , segmentlist , 300 , 900 , "B");
    Vertex(vertexlist , segmentlist , 700 , 900 , "C");  
    Triangle(vertexlist , segmentlist , "A" , "B" , "C");
  }
  else if (S == "四角形"){
    Vertex(vertexlist , segmentlist , 200 , 300 , "A");
    Vertex(vertexlist , segmentlist , 200 , 700 , "B");
    Vertex(vertexlist , segmentlist , 800 , 700 , "C");
    Vertex(vertexlist , segmentlist , 800 , 300 , "D");
    //Square(vertexlist , segmentlist , "A" , "B" , "C" , "D");
  }

  //Change the shape of the Triangle
  //IsoscelesTriangle(vertexlist , segmentlist , "A" , "B" , "C" ,2,1);
  //RightTriangle(vertexlist , segmentlist , "A" , "B" , "C" , 60);
  //SwapName(vertexlist , "A" , "B");
  //RotateName(vertexlist , "A" , "B" , "C");
  
  //Change the shape of the Square
  Parallelogram(vertexlist , segmentlist , "A" , "B" , "C" , "D");
  
  //Line(vertexlist , segmentlist , "A" , "C");
  
  //Process when Internal Division Point exists
  InternalDivision(vertexlist, segmentlist , "B" , "C" , 1 , 1 ,"F");
  
  //Drawing the line
  //Line(vertexlist, segmentlist , "A" , "D");
  
  //Showing the orbit of the moving point
  //MovingPoint(vertexlist , segmentlist , 100 ,"A" , "B" , "P");
  
  
  //Example
  InternalDivision(vertexlist , segmentlist , "A" , "C" , 2 ,5, "E");
  Line(vertexlist , segmentlist , "B" , "E");
  Line(vertexlist , segmentlist , "E" , "F");
  Vertex(vertexlist , segmentlist , 900 , 500 , "Q");
  Line(vertexlist , segmentlist,  "B" , "Q");
  
  
  //Drawing the CrossPoint
  CrossPoint(vertexlist , segmentlist , "E" , "F" , "B" , "Q" , "CrossPoint(EF-BQ)");
  
  
  //Moving point function ver.
  s = MovingPoint3(vertexlist , "A" , "B" , "C", "E" ,s ,count);
  count++;
  if(count == 3*100+1) count =0;

  //Line(vertexlist , segmentlist , "P" , "C");

  
  //Drawing a triangle area
  Region3(vertexlist , segmentlist , "P" , "A" , "Q");
  
  //Drawing a square area
  //Region4(vertexlist, segmentlist , "P" , "F" , "C" , "Q");
  
  //Showing the distance of linesegment
  LengthDisplay(vertexlist , segmentlist , "A" , "B" , "5");
  LengthDisplay(vertexlist , segmentlist , "B" , "C" , "8");
  
  
  //show the name of all vertexes at the end
  NameDisplay(vertexlist);
  
  //show the name of all vertexes in using circle
  VertexDisplay(vertexlist);
  
  
  //Clear Arraylist
  for(int i = 0 ; i < vertexlist.size() ; i++){
    vertexlist.remove(i);
  }
  vertexlist.clear();
  for(int i = 0 ; i < segmentlist.size() ; i++){
    segmentlist.remove(i);
  }
  segmentlist.clear();
  
}*/

boolean check = true;
void draw(ArrayList<String> inputlist){
  //println("call d.draw()");
  /*if(count%2 == 0) check = true;
  else check = false;
  println("check = " + check +  " , count = " + count);*/
  background(0);
  PFont font  = createFont("MS Gothic" , 24 , true);
  textFont(font);
  //入力をString型変数Sに代入
  /*String S = "";
  if(count == 1)  S = "四角形 A B C D";
  if(count == 30) S = "平行四辺形 A B C D";
  if(count == 60) S = "C D を 2 : 1 に 内分する 点 E";
  if(count == 90) S = "対角線 B D"; 
  if(count == 120)S = "線分 A E";
  if(count == 150)S = "A E と B D の 交点 F";
  if(count == 180)S = "B E と A D の 交点 G";
  if(count == 210)S = "三角形 F D A の 面積";
  if(count == 240)S = "四角形 F B C E の 面積";
  if(count == 270)S = "A B C D の 順 に 移動する　動点 P";*/
  /*if(count == 1)  S = "三角形 A B C";
  if(count == 30) S = "二等辺三角形 A B C";
  if(count == 60) S = "A C を 2 : 1 に 内分する 点 D";
  if(count == 90) S = "線分 B D";*/
  
  /*if(S != ""){
    inputlist.add(S); 
  }*/
  
 
  StringBuilder sb = new StringBuilder();
  for(int i = 0 ; i < inputlist.size() ;  i++){
     sb.append(" ");
     sb.append(inputlist.get(i)); 
  }
  String str = new String(sb);
  
  StringBuilder EntrySequence = new StringBuilder();
  
  for(int i = 0 ; i <  inputlist.size() ; i++){
    String Sn = inputlist.get(i);
    //If the shape of Triangle or Square is defined
     if(Sn.indexOf("面積") == -1 && str.indexOf("平行四辺形") != -1 || str.indexOf("直角三角形") != -1 || str.indexOf("二等辺三角形") != -1){ //Process to transform the shape of triangle or square
      transform = true;
    }
    
    /*String last = inputlist.get(inputlist.size()-1);
    if(gene == false && last.indexOf("四角形")==-1 && last.indexOf("三角形")==-1 && last.indexOf("線分")!=-1){ //Vertexes haven't been made 
      
    }*/
   
   
    if(Sn.indexOf("三角形") != -1 && Sn.indexOf("面積") == -1 && Sn.indexOf("外接円") == -1 && Sn.indexOf("内接円") == -1 && Sn.indexOf("二等辺") == -1 && Sn.indexOf("直角") == -1){ //Process to generate triangle
      //Draw the Triangle
      /*Vertex(vertexlist , segmentlist , 350 , 200 , "A");
      Vertex(vertexlist , segmentlist , 300 , 900 , "B");
      Vertex(vertexlist , segmentlist , 700 , 900 , "C");*/
      CreateString(EntrySequence , Sn);
      ArrayList<String> v = VertexNameSearch(Sn);
      if(DuplicationCheck(vertexlist , inputlist , v) == false){ //If Duplication of vertex's name happend , skip the operation
        error = ErrorCheck(vertexlist , inputlist , v);
        break;
      }
      if(gene == false){
        Vertgenerate3lis(vertexlist , segmentlist , v);
        gene = true;
      }
      if(transform == false){
        Trianglelis(vertexlist , segmentlist , v);
      }
      //println(vertexlist.size() + "//");
    }
    else if (Sn.indexOf("四角形") != -1 && Sn.indexOf("面積") == -1 ){ //Process to generate square
      /*Vertex(vertexlist , segmentlist , 200 , 300 , "A");
      Vertex(vertexlist , segmentlist , 200 , 700 , "B");
      Vertex(vertexlist , segmentlist , 800 , 700 , "C");
      Vertex(vertexlist , segmentlist , 800 , 300 , "D");*/
      CreateString(EntrySequence,Sn);
      ArrayList<String> v = VertexNameSearch(Sn);
      if(DuplicationCheck(vertexlist , inputlist , v) == false){//If Duplication of vertex's name happend , skip the operation
         error = ErrorCheck(vertexlist , inputlist , v);
         break;
      }
      if(gene == false){
        Vertgenerate4lis(vertexlist , segmentlist , v);
        gene = true;
      }
      if(transform == false){
        Squarelis(vertexlist , segmentlist ,v);
      }
    }
    
    
    if(Sn.indexOf("平行四辺形") != -1 && transform == true){
       //AddString(EntrySequence,Sn);
       ArrayList<String> v = VertexNameSearch(Sn);
       if(DuplicationCheck(vertexlist , inputlist , v ) == false || VertexExistCheck(vertexlist , inputlist , v ) == false){//If Duplication of vertex's name happend or vertex doesn't exist, skip the operation
         error = ErrorCheck(vertexlist , inputlist , v);
         break; 
       }
       Parallelogramlis(vertexlist , segmentlist , v);
    }
    if(Sn.indexOf("直角三角形") != -1 && transform == true){
       AddString(EntrySequence,Sn);
       ArrayList<String> v = VertexNameSearch(Sn);
       if(DuplicationCheck(vertexlist , inputlist , v) == false || VertexExistCheck(vertexlist , inputlist , v) == false){
         error = ErrorCheck(vertexlist , inputlist , v);
         break;
       }
       RightTrianglelis(vertexlist , segmentlist , v , 60);
    }
    if(Sn.indexOf("二等辺三角形") != -1 && transform == true){
       AddString(EntrySequence,Sn);
       ArrayList<String> v = VertexNameSearch(Sn);
       if(DuplicationCheck(vertexlist , inputlist , v ) == false || VertexExistCheck(vertexlist , inputlist , v) == false){
         error = ErrorCheck(vertexlist , inputlist , v);
         break; 
       }
       IsoscelesTrianglelis(vertexlist , segmentlist , v , 2, 1);
    }
    if(Sn.indexOf("内分") != -1){
      AddString(EntrySequence,Sn);
      String[] spl1 = split(Sn , "内分");
      ArrayList<String> v1 = VertexNameSearch(spl1[0]); //二本の線分の名前を格納
      ArrayList<String> v2 = VertexNameSearch(spl1[1]); //内分点の頂点名を格納
      ArrayList<Integer> n = NumberSearch(Sn);
      
      if(DuplicationCheck(vertexlist , inputlist , v1) == false || VertexExistCheck(vertexlist , inputlist , v1) == false){
        error = ErrorCheck(vertexlist , inputlist , v1);
        break;
      }
      InternalDivisionlis(vertexlist , segmentlist , v1 , n , v2);
      LengthDisplay(vertexlist , segmentlist , v1.get(0) , v2.get(0) , String.valueOf(n.get(0)));
      LengthDisplay(vertexlist , segmentlist , v1.get(1) , v2.get(0) , String.valueOf(n.get(1)));
    }
    if(Sn.indexOf("対角線") != -1){
      AddString(EntrySequence,Sn);
      ArrayList<String> v = VertexNameSearch(Sn);
      if(DuplicationCheck(vertexlist , inputlist , v) == false || VertexExistCheck(vertexlist , inputlist , v) == false){
        error = ErrorCheck(vertexlist , inputlist , v);
        break; 
      }
      Linelis(vertexlist , segmentlist , v); 
    }
    if(Sn.indexOf("線分") != -1){
      AddString(EntrySequence,Sn);
      ArrayList<String> v = VertexNameSearch(Sn);
      if(DuplicationCheck(vertexlist , inputlist , v ) == false || VertexExistCheck(vertexlist , inputlist , v ) == false){
        error = ErrorCheck(vertexlist , inputlist , v);
        break;
      }
       Linelis(vertexlist , segmentlist , v); 
    }
    if(Sn.indexOf("辺") != -1){
      AddString(EntrySequence,Sn);
      ArrayList<String> v = VertexNameSearch(Sn);
      if(DuplicationCheck(vertexlist , inputlist , v) == false || VertexExistCheck(vertexlist , inputlist , v) == false){
        error = ErrorCheck(vertexlist , inputlist , v);
        break; 
      }
       Linelis(vertexlist , segmentlist , v); 
    }
    if(Sn.indexOf("交点") != -1){
      AddString(EntrySequence,Sn);
      String temp = Sn.replace("と" , "交点");
      String[] spl = split(temp ,"交点");
      ArrayList<String> v1 = VertexNameSearch(spl[0]);
      ArrayList<String> v2 = VertexNameSearch(spl[1]);
      ArrayList<String> v3 = VertexNameSearch(spl[2]);
      boolean duplication1 = DuplicationCheck(vertexlist , inputlist , v1);
      boolean vertexist1 = VertexExistCheck(vertexlist , inputlist , v1);
      boolean duplication2 = DuplicationCheck(vertexlist , inputlist , v2);
      boolean vertexist2 = VertexExistCheck(vertexlist , inputlist , v2);
      
      if(duplication1 == false || vertexist1 == false || duplication2 == false || vertexist2 == false){
        if(duplication1 == false || vertexist1 == false) error = ErrorCheck(vertexlist , inputlist , v1);
        if(duplication1 == false || vertexist2 == false) error = ErrorCheck(vertexlist , inputlist , v2);
        break; 
      }
      CrossPointlis(vertexlist , segmentlist , v1 , v2 ,v3); 
    }
    if(Sn.indexOf("面積") != -1 && Sn.indexOf("三角形") != -1){
      AddString(EntrySequence,Sn);
      ArrayList<String> v = VertexNameSearch(Sn); 
      if(DuplicationCheck(vertexlist , inputlist , v ) == false || VertexExistCheck(vertexlist , inputlist , v) == false){
        error = ErrorCheck(vertexlist , inputlist , v);
        break;
      }
      Region3lis(vertexlist , segmentlist , v); 
    }
    if(Sn.indexOf("面積") != -1 && Sn.indexOf("四角形") != -1){
      AddString(EntrySequence,Sn);
      ArrayList<String> v = VertexNameSearch(Sn);
      if(DuplicationCheck(vertexlist , inputlist , v) == false || VertexExistCheck(vertexlist , inputlist , v) == false){
         error = ErrorCheck(vertexlist , inputlist , v);
         break; 
      }
      Region4lis(vertexlist , segmentlist , v); 
    }
    if(Sn.indexOf("内接円") != -1 && Sn.indexOf("三角形") != -1){
      AddString(EntrySequence,Sn);
      ArrayList<String> v = VertexNameSearch(Sn); 
      if(DuplicationCheck(vertexlist , inputlist , v ) == false || VertexExistCheck(vertexlist , inputlist , v) == false){
        error = ErrorCheck(vertexlist , inputlist , v);
        break;
      }
      Inscribelis(vertexlist , v); 
    }
    if(Sn.indexOf("外接円") != -1 && Sn.indexOf("三角形") != -1){
      AddString(EntrySequence,Sn);
      ArrayList<String> v = VertexNameSearch(Sn); 
      if(DuplicationCheck(vertexlist , inputlist , v ) == false || VertexExistCheck(vertexlist , inputlist , v) == false){
        error = ErrorCheck(vertexlist , inputlist , v);
        break;
      }
      Circumcirclelis(vertexlist , v); 
    }
    if(Sn.indexOf("動点") != -1){
      AddString(EntrySequence,Sn);
      String[] spl = split(Sn ,"動点");
      ArrayList<String> v1 = VertexNameSearch(spl[0]); //通過点の頂点名を格納
      ArrayList<String> v2 = VertexNameSearch(spl[1]); //動点の頂点名を格納
      if(DuplicationCheck(vertexlist , inputlist , v1) == false || VertexExistCheck(vertexlist , inputlist , v1) == false){
        error = ErrorCheck(vertexlist , inputlist , v1);
        break;
      }
      s = MovingPoint3lis(vertexlist , v1 , v2 ,s ,count);
      count++;
    }
    if(count == 3*100+1) count =0;
      
  }
  /*text("問3(山梨県公立高校入試改題)" , 100 , 900);
  text("平行四辺形ABCDの辺CD上にCE:ED=2:1となる点Eをとり、線分AEと対角線BDの交点をFとした。\n\nさらに線分ADの延長線と線分BEの交点をGとする。\n\nこの時、三角形EDGと四角形FBCEの面積を導出せよ。" , 120  , 950);
 */
  fill(0,0,255);
  textSize(48);
  text("ENTRY SEQUENCE" , 1250 , 50);
  fill(255);
  textSize(24);
  //text("四角形ABCD\n　↓\n平行四辺形ABCDに変換\n　↓\nCE:ED=2:1\n　↓\n対角線BD\n　↓\n線分AE\n　↓\nAEとBDの交点をF\n　↓\nBEとADの交点をG\n　↓\n四角形FBCEの面積\n　↓\nABEDの順に移動する動点P\n　↓\n三角形APDの面積　" , 1300 , 200);
  String ES = new String(EntrySequence);
  text(ES , 1250 , 100);
  text("DIAGRAM" , 50 , 50);
  //count++;
  
  
  //全ての頂点の名前を表示
  NameDisplay(vertexlist);
  
  //円を使って全ての頂点を表示
  VertexDisplay(vertexlist);
  
  //エラーの処理 
  //println("countOK = " + countOK);
  if(error.equals("Novertex") == true){
     background(0);
     fill(255,0,0);
     textSize(50);
     text("Please Generate Vertex !!" , 200 , 450);
     fill(255);
     //println("You haven't generate vertex yet! , inputlist.size = " + inputlist.size());
  }
  else if(error.equals("NotExist") == true){
     //println("NotExist error discovered");
     background(0);
     fill(255,0,0);
     textSize(50);
     text("Please Generate Vertex !!" , 200 , 450);
     fill(255);
     //println("NOT EXIST , intputlist.size = " + inputlist.size());
     noLoop();
     //println("loop");
     if(keyPressed == true && key == 'o' || key == 'O') loop();
}
  else if(error.equals("Duplication") == true){
     background(0);
     fill(255,0,0);
     textSize(50);
     text("ERROR! Duplication of vertex happend" , 50, 450);
     fill(255);
  }
  
  if(error.equals("NotExist") || error.equals("Novertex") || error.equals("Duplication"))inputlist.remove(inputlist.size()-1); //毎回エラーが出るのを防ぐために入力を削除
  
  
  //リストの中身をすべてクリア
  for(int i = 0 ; i < vertexlist.size() ; i++){
    vertexlist.remove(i); 
  }
  vertexlist.clear();
  for(int i = 0 ; i < segmentlist.size() ; i++){
    segmentlist.remove(i); 
  }
  segmentlist.clear();
 
  loop();
  
  gene = false;
  transform = false;
  error ="";
  }
}
