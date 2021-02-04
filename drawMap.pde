//draws heat map
void drawMap() 
{
  //directory in which heat maps to be printed
  File dir = new File(directory);
  int c=0;
  try
  {
    for(File file : dir.listFiles())
    {
      
      //go over all the log files again
      FileReader fr = new FileReader(file);
      LineNumberReader lnr = new LineNumberReader(fr);
      int nrows = 0;
      while(lnr.readLine() != null)
        nrows++;
      lnr.close();
    
      //get x and y positions in each log file
      double xPos[] = new double[nrows];
      double yPos[] = new double[nrows];
    
      Scanner input = new Scanner(file);
      for(int i=0; i<nrows; i++)
      {
        String code = input.nextLine();
        xPos[i] = Double.parseDouble(code.substring(code.indexOf(' ')+1, code.indexOf(',')));
        yPos[i] = Double.parseDouble(code.substring(code.indexOf(',')+1, code.lastIndexOf(',')));
      }
      input.close();
      
      pg.beginDraw();
      pg.background(255);
      //yellow border
      pg.strokeWeight(1);
      pg.stroke(255,255,0);
      
      for(int i=5; i>=0; i--)
      {
        for(int j=5; j>=0; j--)
        {
          double grad = pe[c][(5-j)+6*(5-i)]/3.0;
          int col = (int)(grad*255);
          if(grad<=0)
            pg.fill(255+col,255,255+col); //draw green rectangles in case of negative PE score
          else
            pg.fill(255,255-col,255-col); //draw red rectangles in case of positive PE score
          pg.rect(j*size/6,i*size/6,size/6, size/6); //rectangle is 50x50 pixel each
        }
      }
      
      //purple stroke
      pg.stroke(0,0,255);
      pg.strokeWeight(2);
      pg.noFill();
      pg.beginShape();
      //draws path 
      for(int i=0; i<nrows; i++)
      {
        pg.vertex((float)(1536-xPos[i])*size/1536,(float)(1536-yPos[i])*size/1536);
      }
      pg.endShape();
      drawWalls(mazeNumber[c]); //draw walls using black lines
      drawZones(mazeNumber[c]); //draw danger zones using black dashed lines
      pg.endDraw();
      //save heat maps as .jpg files
      pg.save(directory.substring(0,directory.length()-4)+"Heat Maps/"+id[c]+"-"+group[c]+"-"+mazeNumber[c]+"-"+mazeTrial[c]+".jpg");
      c++;
    }
  }
  //catch errors
  catch (FileNotFoundException e) 
  {
    e.printStackTrace();
  }
  catch(IOException e)
  {
    e.printStackTrace();
  }
}
