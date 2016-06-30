void setup() {
  size(500,500);
  drawOneRandomArc();
  //drawArc(250+125,250+0,250+0,250+125,250+0,250+0,true);
}

// returns angle of dy/dx as a value from 0...2PI
float atan3(float dy,float dx) {
  float a=atan2(dy,dx);
  if(a<0) a=(PI*2.0)+a;
  return a;
}

// draw an arc
void drawArc(float sx,float sy,float ex,float ey,float cx,float cy,boolean cw) {
  println("start =("+sx+","+sy+")");
  println("end =("+ex+","+ey+")");
  println("center =("+cx+","+cy+")");
  println("clockwise="+cw);
  
  // start radius
  float dx = sx - cx;
  float dy = sy - cy;
  float angle1=atan3(dy,dx);
  float sr=sqrt(dx*dx+dy*dy);
  // end radius
  dx = ex - cx;
  dy = ey - cy;
  float angle2=atan3(dy,dx);
  float er=sqrt(dx*dx+dy*dy);

  // find angle of arc (sweep)
  float sweep=angle2-angle1;

  if(!cw && sweep<0) angle2+=2*PI;
  else if(cw && sweep>0) angle1+=2*PI;

  sweep = angle2-angle1;
  float dr = er-sr;
  println("angle1="+angle1);
  println("angle2="+angle2);
  println("sweep="+sweep);
  println("delta radius="+dr);

  println("green is start");
  stroke(0,255,0);
  line(cx,cy,sx,sy);
  println("red is end");
  stroke(255,0,0);
  line(cx,cy,ex,ey);
    
  // get length of arc
  // float circ=PI*2.0*radius;
  // float len=theta*circ/(PI*2.0);
  // simplifies to
  float len1 = abs(sweep) * sr;
  float len = sqrt( len1 * len1 + dr * dr );

  int i, segments = max( ceil( len / 10 ), 1);
  float r, nx, ny, a, scale;

  strokeWeight(2);
  println("segments="+segments);
  for(i=0;i<=segments;++i) {
    // interpolate around the arc
    scale = ((float)i)/((float)segments);
    a = sweep * scale + angle1;
    r = dr * scale + sr;
    //print("R="+r);
    //println("\tS="+scale);
    nx = cx + cos(a) * r;
    ny = cy + sin(a) * r;
    // send it to the planner
    stroke(scale*255,255-scale*255,0);
    line(sx,sy,nx,ny);
    sx = nx;
    sy = ny;
  }
}


void draw() {
}


void drawOneRandomArc() {
  // start of arc
  float sx = random(width);
  float sy = random(height);
  // end of arc
  float ex = random(width);
  float ey = random(height);
  // center of arc
  float cx = random(width);
  float cy = random(height);
  
  stroke(random(255),random(255),random(255));
  drawArc(sx,sy,ex,ey,cx,cy,random(2)==1);
}