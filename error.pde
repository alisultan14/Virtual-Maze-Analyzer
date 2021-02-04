//counts errors in specified zone. 
void error(int num, int x1, int y1, int x2, int y2) //num = log file number(from top), (x1,y1) and (x2,y2) are endpoints of error zone. top left is (0,0) and bottom right is (6,6)
{
  File dir = new File(directory);
  int c=0;
  try
  {
    for (File file : dir.listFiles())
    {
      //go over all the log files again
      FileReader fr = new FileReader(file);
      LineNumberReader lnr = new LineNumberReader(fr);
      int nrows = 0;
      while (lnr.readLine() != null)
        nrows++;
      lnr.close();

      //get x and y coordinates
      if (c==num)
      {
        //get x and y positions in each log file
        double xPos[] = new double[nrows];
        double yPos[] = new double[nrows];

        Scanner input = new Scanner(file);
        for (int i=0; i<nrows; i++)
        {
          String code = input.nextLine();
          xPos[i] = Double.parseDouble(code.substring(code.indexOf(' ')+1, code.indexOf(',')));
          yPos[i] = Double.parseDouble(code.substring(code.indexOf(',')+1, code.lastIndexOf(',')));
        }
        input.close();

        int count =0; // count number of errors
        boolean goingIn; //check if going in or out. going in AND out counts as 1 error
        x1 = (6-x1)*256; //match coordinate system with log file's from (0,0) to (6,6) -> (1536,1536) to (0,0)
        x2 = (6-x2)*256;
        y1 = (6-y1)*256;
        y2 = (6-y2)*256;
        if (x2-x1!=0) //slope is defined
        {
          double slope = (y2-y1)/(x2-x1);
          goingIn = true;
          for (int i=0; i<nrows-1; i++)
          {
            if ((xPos[i]>Math.min(x1, x2) && xPos[i]<Math.max(x1, x2))) //point-slope form
            {
              double y = slope*(xPos[i]-x1)+y1;
              if (y>Math.min(yPos[i], yPos[i+1]) && y<Math.max(yPos[i], yPos[i+1]))
              {
                if(goingIn==true)
                { count++; goingIn=false; }
                else
                  goingIn=true;
              }
            }
          }
        } else //slop is undefined (vertical error zone)
        {
          goingIn = true;
          for (int i=0; i<nrows-1; i++)
          {
            if (yPos[i]>Math.min(y1, y2) && yPos[i]<Math.max(y1, y2))
            {
              if (x1>Math.min(xPos[i], xPos[i+1]) && x1<Math.max(xPos[i], xPos[i+1]))
              {
                if(goingIn==true)
                { count++; goingIn=false; }
                else
                  goingIn=true;
              }
            }
          }
        }
        //revert coordinates to original
        x1=-(x1/256-6); 
        x2=-(x2/256-6); 
        y1=-(y1/256-6); 
        y2=-(y2/256-6);
        outFile.print("Zone ("+x1+","+y1+") - ("+x2+","+y2+") : "+count+"\t\t\t");
        break;
      }
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
