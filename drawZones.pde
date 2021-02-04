
//draw danger zones
void drawZones(int number) //number = maze number
{
  int unit = size/6; //there are 6x6 cells in each maze
  pg.noStroke();
  pg.fill(0);
  switch(number)
   {
       case 1:
         dottedLine(1*unit,3*unit,1*unit,5*unit); dottedLine(2*unit,5*unit,2*unit,6*unit); dottedLine(4*unit,5*unit,4*unit,6*unit); dottedLine(2*unit,3*unit,4*unit,5*unit); dottedLine(3*unit,1*unit,5*unit,1*unit); dottedLine(5*unit,2*unit,6*unit,2*unit); dottedLine(3*unit,2*unit,5*unit,4*unit); dottedLine(5*unit,4*unit,6*unit,4*unit); break;
       case 2:
         dottedLine(1*unit,1*unit,3*unit,1*unit); dottedLine(1*unit,2*unit,6*unit,2*unit); dottedLine(0*unit,3*unit,2*unit,3*unit); dottedLine(3*unit,3*unit,3*unit,6*unit); dottedLine(4*unit,3*unit,4*unit,6*unit); break;
       case 3:
         dottedLine(1*unit,0*unit,1*unit,2*unit); dottedLine(3*unit,2*unit,3*unit,3*unit); dottedLine(1*unit,4*unit,3*unit,5*unit); dottedLine(3*unit,4*unit,6*unit,4*unit); dottedLine(3*unit,5*unit,6*unit,5*unit); break;
       case 4:
         dottedLine(3*unit,0*unit,3*unit,1*unit); dottedLine(0*unit,2*unit,2*unit,4*unit); dottedLine(3*unit,3*unit,5*unit,1*unit); dottedLine(3*unit,4*unit,3*unit,6*unit); dottedLine(5*unit,4*unit,5*unit,6*unit); break;
       case 5:
         dottedLine(4*unit,0*unit,4*unit,1*unit); dottedLine(4*unit,3*unit,6*unit,3*unit); dottedLine(4*unit,5*unit,6*unit,5*unit); dottedLine(0*unit,3*unit,1*unit,3*unit); dottedLine(3*unit,3*unit,3*unit,6*unit); break;
       case 6:
         dottedLine(3*unit,1*unit,3*unit,6*unit); dottedLine(4*unit,1*unit,4*unit,3*unit); dottedLine(4*unit,5*unit,4*unit,6*unit); break;
       case 7:
         dottedLine(0*unit,3*unit,2*unit,1*unit); dottedLine(4*unit,0*unit,4*unit,1*unit); dottedLine(4*unit,3*unit,6*unit,3*unit); dottedLine(4*unit,4*unit,6*unit,4*unit); dottedLine(0*unit,3*unit,3*unit,3*unit); dottedLine(3*unit,3*unit,3*unit,6*unit); break;
       case 8:
         dottedLine(1*unit,2*unit,3*unit,0*unit); dottedLine(3*unit,3*unit,6*unit,0*unit); dottedLine(3*unit,4*unit,3*unit,6*unit); dottedLine(5*unit,4*unit,5*unit,6*unit); break;
       case 9:
         dottedLine(1*unit,3*unit,3*unit,1*unit); dottedLine(0*unit,4*unit,1*unit,4*unit); dottedLine(3*unit,4*unit,3*unit,6*unit); dottedLine(4*unit,4*unit,6*unit,4*unit); dottedLine(4*unit,5*unit,6*unit,5*unit); break;
       case 10:
         dottedLine(3*unit,0*unit,3*unit,2*unit); dottedLine(4*unit,0*unit,4*unit,2*unit); dottedLine(3*unit,4*unit,3*unit,6*unit); dottedLine(5*unit,4*unit,5*unit,6*unit); break;
       case 11:
         dottedLine(2*unit,1*unit,2*unit,2*unit); dottedLine(4*unit,0*unit,4*unit,1*unit); dottedLine(2*unit,4*unit,2*unit,6*unit); dottedLine(3*unit,3*unit,3*unit,6*unit); dottedLine(4*unit,3*unit,6*unit,3*unit); dottedLine(4*unit,4*unit,6*unit,4*unit); break;
       case 12:
         dottedLine(2*unit,0*unit,2*unit,1*unit); dottedLine(2*unit,4*unit,2*unit,5*unit); break;
   }
}

//draws dotted lines. each line contains 15 dots
void dottedLine(int x1, int y1, int x2, int y2){
  double dist = Math.sqrt(Math.pow(x2-x1,2)+Math.pow(y2-y1,2));
  float steps = (float)dist/8;
 for(int i=0; i<=steps; i++) {
   float x = lerp(x1, x2, i/steps);
   float y = lerp(y1, y2, i/steps);
   pg.ellipse(x,y,3,3);
 }
}
