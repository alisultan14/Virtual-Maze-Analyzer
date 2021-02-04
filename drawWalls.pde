//draw walls using black lines
void drawWalls(int number) //number = maze number
{
  int unit = size/6;
  pg.strokeWeight(2); 
  pg.stroke(0); //black stroke
  //walls are individual to each maze
  switch(number)
  {
    case 1:
      pg.line(0,3*unit,2*unit,3*unit); pg.line(0,5*unit,4*unit,5*unit); pg.line(3*unit,0,3*unit,2*unit); pg.line(5*unit,0,5*unit,4*unit); break;
    case 2:
      pg.line(unit,0,unit,2*unit); pg.line(3*unit,0,3*unit,2*unit); pg.line(2*unit,3*unit,2*unit,6*unit); pg.line(2*unit,3*unit,4*unit,3*unit); break;
    case 3:
      pg.line(unit,2*unit,6*unit,2*unit); pg.line(unit,2*unit,unit,4*unit); pg.line(3*unit,3*unit,6*unit,3*unit); pg.line(3*unit,3*unit,3*unit,5*unit); break;
    case 4:
      pg.line(3*unit,unit,6*unit,unit); pg.line(3*unit,unit,3*unit,3*unit); pg.line(3*unit,3*unit,4*unit,3*unit); pg.line(5*unit,3*unit,5*unit,4*unit); pg.line(5*unit,4*unit,0,4*unit); break;
    case 5:
      pg.line(2*unit, 0, 2*unit, unit); pg.line(2*unit, unit, 4*unit, unit); pg.line(4*unit, unit, 4*unit, 5*unit); pg.line(0, unit, unit, unit); pg.line(unit, unit, unit, 3*unit); pg.line(unit, 3*unit, 3*unit, 3*unit); break;
    case 6:
      pg.line(0,unit,5*unit,unit); pg.line(0, 3*unit,4*unit, 3*unit); pg.line(4*unit, 3*unit, 4*unit, 5*unit); break;
    case 7:
      pg.line(0,unit,3*unit,unit); pg.line(4*unit,unit,6*unit,unit); pg.line(3*unit,unit,3*unit,3*unit); pg.line(4*unit,unit,4*unit,4*unit); break;
    case 8:
      pg.line(unit,0,unit,3*unit); pg.line(unit,3*unit,3*unit,3*unit); pg.line(4*unit,3*unit,5*unit,3*unit); pg.line(5*unit,3*unit,5*unit,4*unit); pg.line(5*unit,4*unit,0,4*unit); break;
    case 9:
      pg.line(0,unit,5*unit,unit); pg.line(unit,unit,unit,4*unit); pg.line(unit,4*unit,3*unit,4*unit); pg.line(2*unit,3*unit,6*unit,3*unit); pg.line(4*unit,3*unit,4*unit,5*unit);  break;
    case 10:
      pg.line(unit,0,unit,2*unit); pg.line(unit,2*unit,4*unit,2*unit); pg.line(5*unit,2*unit,5*unit,4*unit); pg.line(5*unit,4*unit,0,4*unit); break;
    case 11:
      pg.line(0,unit,3*unit,unit); pg.line(3*unit,unit,3*unit,3*unit); pg.line(2*unit,2*unit,2*unit,4*unit); pg.line(unit,3*unit,unit,5*unit); pg.line(4*unit,unit,6*unit,unit); pg.line(4*unit,unit,4*unit,4*unit); break;
    case 12:
      pg.line(unit,0,unit,5*unit); pg.line(unit,5*unit,2*unit,5*unit); pg.line(2*unit,unit,2*unit,4*unit); pg.line(4*unit,4*unit,4*unit,6*unit); break;
  }
}
