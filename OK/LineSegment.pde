class LineSegment{
  Coordinate vert1;       //starting point
  Coordinate vert2;       //end point
  float length;             //the length of this line segment
  
  LineSegment(Coordinate vert1, Coordinate vert2,float length){
    this.vert1 = vert1;
    this.vert2 = vert2;
    float dx = vert1.x - vert2.x;
    float dy = vert1.y - vert2.y;
    this.length = sqrt(dx*dx + dy*dy);
  }
}
