void runAnalysis(){
  nfiles = 0;
  try
  {
    //choose input folder
    File dir = new File(directory);
    
    //count number of files
    for(File file : dir.listFiles())
      nfiles++; 
    
    //choose output file
    outFile = createWriter(directory.substring(0,directory.length()-4)+"analysis.txt");
    
    //initiate variables that store necessary info from each trial
    distance = new double[nfiles][36];
    duration = new long[nfiles][36];
    id = new String[nfiles];
    group = new int[nfiles];
    mazeNumber = new int[nfiles];
    mazeTrial = new String[nfiles];
    mazeCount = new int[12];
    totalDistance = new double[nfiles];
    totalDuration = new double[nfiles];
    meanSpeed = new double[nfiles];
    frozenTime = new double[nfiles];
    
    
    //print the headers
    outFile.print("ID\tGroup\tMaze Number\tTrial Number\tA1_Distance\tB1_Distance\tC1_Distance\tD1_Distance\tE1_Distance\tF1_Distance\tA2_Distance\tB2_Distance\tC2_Distance\tD2_Distance\tE2_Distance\tF2_Distance\tA3_Distance\tB3_Distance\tC3_Distance\tD3_Distance\tE3_Distance\tF3_Distance\tA4_Distance\tB4_Distance\tC4_Distance\tD4_Distance\tE4_Distance\tF4_Distance\tA5_Distance\tB5_Distance\tC5_Distance\tD5_Distance\tE5_Distance\tF5_Distance\tA6_Distance\tB6_Distance\tC6_Distance\tD6_Distance\tE6_Distance\tF6_Distance");
    outFile.print("\tA1_Time\tB1_Time\tC1_Time\tD1_Time\tE1_Time\tF1_Time\tA2_Time\tB2_Time\tC2_Time\tD2_Time\tE2_Time\tF2_Time\tA3_Time\tB3_Time\tC3_Time\tD3_Time\tE3_Time\tF3_Time\tA4_Time\tB4_Time\tC4_Time\tD4_Time\tE4_Time\tF4_Time\tA5_Time\tB5_Time\tC5_Time\tD5_Time\tE5_Time\tF5_Time\tA6_Time\tB6_Time\tC6_Time\tD6_Time\tE6_Time\tF6_Time");
    outFile.print("\tTotalDistance\tTotalDuration\tMeanSpeed\tFrozenTime");
    outFile.println("");
    
    
    //for every log file in folder
    int count = 0;
    for(File file : dir.listFiles())
    {
      String name = file.getName();
      id[count] = name.substring(0,name.lastIndexOf('_'));
      group[count] = Integer.parseInt(name.substring(name.lastIndexOf('_')+1, name.indexOf('-')));
      mazeNumber[count] = Integer.parseInt(name.substring(name.indexOf('e')+1, name.indexOf('-', name.indexOf('-')+1)));
      mazeCount[mazeNumber[count]-1]++;
      mazeTrial[count] = name.substring(name.indexOf('-', name.indexOf('-')+1)+1,name.lastIndexOf('-'));
      //prints participant ID, group number, maze number, maze trial
      outFile.print(id[count]+"\t"+group[count]+"\t"+mazeNumber[count]+"\t"+mazeTrial[count]+"\t");
      
      //count number of rows in each log file
      FileReader fr = new FileReader(file);
      LineNumberReader lnr = new LineNumberReader(fr);
      int nrows = 0;
      while(lnr.readLine() != null)
        nrows++;
      lnr.close();
      
      //get date, time, x and y positions from each log file
      String date[] = new String[nrows];
      String timeTemp[] = new String[nrows];
      double xPos[] = new double[nrows];
      double yPos[] = new double[nrows];
      Date time[] = new Date[nrows];
      DateFormat df = new SimpleDateFormat("hh:mm:ss.SSS");
      
      //within each log file, get time, x and y coordinates
      Scanner input = new Scanner(file);
      for(int i=0; i<nrows; i++)
      {
        String code = input.nextLine();
        date[i] = code.substring(0,code.indexOf('T'));
        timeTemp[i] = code.substring(code.indexOf('T')+1, code.indexOf(' '));
        time[i] = df.parse(timeTemp[i]);
        xPos[i] = Double.parseDouble(code.substring(code.indexOf(' ')+1, code.indexOf(',')));
        yPos[i] = Double.parseDouble(code.substring(code.indexOf(',')+1, code.lastIndexOf(',')));
      }
      input.close();
    
      
      //calculates distance and duration in each 'cell' per log file
      for(int i=1; i<nrows; i++)
      {
        int x = (int)xPos[i]/256;
        int y = (int)yPos[i]/256;
        distance[count][y*6+x]+=Math.sqrt(Math.pow(yPos[i]-yPos[i-1],2)+Math.pow(xPos[i]-xPos[i-1],2));
        duration[count][y*6+x]+=time[i].getTime()-time[i-1].getTime();
        if((yPos[i]-yPos[i-1])+(xPos[i]-xPos[i-1])<5)
          frozenTime[count] += time[i].getTime()-time[i-1].getTime();
      }
      
      
      //prints distance and duration in each 'cell' per log file
      for(int i=0; i<36; i++)
      {
          totalDistance[count] += distance[count][i];
          outFile.print(distance[count][i]+"\t");
      }
      
      for(int i=0; i<36; i++)
      {
          totalDuration[count] += duration[count][i];
          outFile.print(duration[count][i]+"\t");
      }
      meanSpeed[count] = totalDistance[count]/totalDuration[count];
      outFile.print(totalDistance[count]+"\t"+totalDuration[count]+"\t"+meanSpeed[count]+"\t"+frozenTime[count]);
      outFile.println("");
 
      
      count++;
    }  
   
  
    //calculates and prints average per maze
    avgDistance = new double[12][36];
    avgDuration = new long[12][36];
    for(int i=0; i<nfiles; i++)
    {
      for(int j=0; j<36; j++)
      {
        avgDistance[mazeNumber[i]-1][j] += distance[i][j];
        avgDuration[mazeNumber[i]-1][j] += duration[i][j];
      }
    }
    for(int i=0; i<12; i++)
    {
      for(int j=0; j<36; j++)
      {
        if(mazeCount[i]!=0) //avoid division by 0
        {
          avgDistance[i][j] /= mazeCount[i];
          avgDuration[i][j] /= mazeCount[i];
        }
      }
    } 
    outFile.println("");
    outFile.print("Average");
    outFile.println("");
    for(int i=0; i<12; i++)
    {
      outFile.print("Maze Number\t\t"+(i+1)+"\t\t");
      for(int j=0; j<36; j++)
      {
        outFile.print(avgDistance[i][j]+"\t");
      }
      for(int j=0; j<36; j++)
      {
        outFile.print(avgDuration[i][j]+"\t");
      }
      outFile.println("");
    }
    


    //calculates and prints standard deviation per maze
    stdDistance = new double[12][36];
    stdDuration = new double[12][36];
    for(int i=0; i<nfiles; i++)
    {
      for(int j=0; j<36; j++)
      {
        stdDistance[mazeNumber[i]-1][j] += Math.pow(distance[i][j]-avgDistance[mazeNumber[i]-1][j],2.0);
        stdDuration[mazeNumber[i]-1][j] += Math.pow(duration[i][j]-avgDuration[mazeNumber[i]-1][j],2.0);
      }
    }
    outFile.println("");
    outFile.print("SD");
    outFile.println("");
    for(int i=0; i<12; i++)
    {
      outFile.print("Maze Number\t\t"+(i+1)+"\t\t");
      for(int j=0; j<36; j++)
      {
        stdDistance[i][j] = Math.pow(stdDistance[i][j]/(mazeCount[i]-1),0.5);
        outFile.print(stdDistance[i][j]+"\t");
      }
      for(int j=0; j<36; j++)
      {
        stdDuration[i][j] = Math.pow(stdDuration[i][j]/(mazeCount[i]-1),0.5);
        outFile.print(stdDuration[i][j]+"\t");
      }
      outFile.println("");
    }


//calculates z scores (distance and duration separately) per maze
    zDistance = new double[nfiles][36];
    zDuration = new double[nfiles][36];
    for(int i=0; i<nfiles; i++)
    {
      for(int j=0; j<36; j++)
      {
        if(stdDistance[mazeNumber[i]-1][j]!=0)
        {
          zDistance[i][j] = (distance[i][j]-avgDistance[mazeNumber[i]-1][j])/stdDistance[mazeNumber[i]-1][j];
          zDuration[i][j] = (duration[i][j]-avgDuration[mazeNumber[i]-1][j])/stdDuration[mazeNumber[i]-1][j];
        }
      }
    }
    //prints out z-scores
    outFile.println("");
    outFile.println("");
    outFile.println("Z-Scores");
    outFile.println("");
    outFile.println("");
    
    outFile.print("ID\tGroup\tMaze Number\tTrial Number\tA1_Distance\tB1_Distance\tC1_Distance\tD1_Distance\tE1_Distance\tF1_Distance\tA2_Distance\tB2_Distance\tC2_Distance\tD2_Distance\tE2_Distance\tF2_Distance\tA3_Distance\tB3_Distance\tC3_Distance\tD3_Distance\tE3_Distance\tF3_Distance\tA4_Distance\tB4_Distance\tC4_Distance\tD4_Distance\tE4_Distance\tF4_Distance\tA5_Distance\tB5_Distance\tC5_Distance\tD5_Distance\tE5_Distance\tF5_Distance\tA6_Distance\tB6_Distance\tC6_Distance\tD6_Distance\tE6_Distance\tF6_Distance");
    outFile.print("\tA1_Time\tB1_Time\tC1_Time\tD1_Time\tE1_Time\tF1_Time\tA2_Time\tB2_Time\tC2_Time\tD2_Time\tE2_Time\tF2_Time\tA3_Time\tB3_Time\tC3_Time\tD3_Time\tE3_Time\tF3_Time\tA4_Time\tB4_Time\tC4_Time\tD4_Time\tE4_Time\tF4_Time\tA5_Time\tB5_Time\tC5_Time\tD5_Time\tE5_Time\tF5_Time\tA6_Time\tB6_Time\tC6_Time\tD6_Time\tE6_Time\tF6_Time");
    outFile.println("");
    for(int i=0; i<nfiles; i++)
    {
      outFile.print(id[i]+"\t"+group[i]+"\t"+mazeNumber[i]+"\t"+mazeTrial[i]+"\t");
      for(int j=0; j<36; j++)
          outFile.print(zDistance[i][j]+"\t");
      
      for(int j=0; j<36; j++)
          outFile.print(zDuration[i][j]+"\t");
      outFile.println("");  
    }


    //calculates performance efficiency scores per log file
    pe = new double[nfiles][36];
    for(int i=0; i<nfiles; i++)
    {
      for(int j=0; j<36; j++)
        pe[i][j] = (zDistance[i][j]+zDuration[i][j])/2;
    }
 
    //prints out performance efficiency scores
    outFile.println("");
    outFile.println("");
    outFile.println("PE scores");
    outFile.println("");
    outFile.println("");
    outFile.print("ID\tGroup\tMaze Number\tTrial Number\tA1 \tB1 \tC1 \tD1 \tE1 \tF1 \tA2 \tB2 \tC2 \tD2 \tE2 \tF2 \tA3 \tB3 \tC3 \tD3 \tE3 \tF3 \tA4 \tB4 \tC4 \tD4 \tE4 \tF4 \tA5 \tB5 \tC5 \tD5 \tE5 \tF5 \tA6 \tB6 \tC6 \tD6 \tE6 \tF6 ");    outFile.println("");
    for(int i=0; i<nfiles; i++)
    {
      outFile.print(id[i]+"\t"+group[i]+"\t"+mazeNumber[i]+"\t"+mazeTrial[i]+"\t");
      for(int j=0; j<36; j++)
        outFile.print(pe[i][j]+"\t");
      outFile.println("");  
    }
    
    //prints number of errors. top left corner is (0,0) and bottom right is (6,6)
    outFile.println("");
    outFile.println("");
    outFile.println("Errors");
    outFile.println("");
    outFile.println("");
    outFile.print("ID\tGroup\tMaze Number\tTrial Number");
    outFile.println("");
    for(int i=0; i<nfiles; i++)
    {
      outFile.print(id[i]+"\t"+group[i]+"\t"+mazeNumber[i]+"\t"+mazeTrial[i]+"\t");
      switch(mazeNumber[i])
      {
       case 1:
         error(i,1,3,1,5); error(i,2,5,2,6); error(i,4,5,4,6); error(i,2,3,4,5); error(i,3,1,5,1); error(i,5,2,6,2); error(i,3,2,5,4); error(i,5,4,6,4); break;
       case 2:
         error(i,1,1,3,1); error(i,1,2,6,2); error(i,0,3,2,3); error(i,3,3,3,6); error(i,4,3,4,6); break;
       case 3:
         error(i,1,0,1,2); error(i,3,2,3,3); error(i,1,4,3,5); error(i,3,4,6,4); error(i,3,5,6,5); break;
       case 4:
         error(i,3,0,3,1); error(i,0,2,2,4); error(i,3,3,5,1); error(i,3,4,3,6); error(i,5,4,5,6); break;
       case 5:
         error(i,4,0,4,1); error(i,4,3,6,3); error(i,4,5,6,5); error(i,0,3,1,3); error(i,3,3,3,6); break;
       case 6:
         error(i,3,1,3,6); error(i,4,1,4,3); error(i,4,5,4,6); break;
       case 7:
         error(i,0,3,2,1); error(i,4,0,4,1); error(i,4,3,6,3); error(i,4,4,6,4); error(i,0,3,3,3); error(i,3,3,3,6); break;
       case 8:
         error(i,1,2,3,0); error(i,3,3,6,0); error(i,3,4,3,6); error(i,5,4,5,6); break;
       case 9:
         error(i,1,3,3,1); error(i,0,4,1,4); error(i,3,4,3,6); error(i,4,4,6,4); error(i,4,5,6,5); break;
       case 10:
         error(i,3,0,3,2); error(i,4,0,4,2); error(i,3,4,3,6); error(i,5,4,5,6); break;
       case 11:
         error(i,2,1,2,2); error(i,4,0,4,1); error(i,2,4,2,6); error(i,3,3,3,6); error(i,4,3,6,3); error(i,4,4,6,4); break;
       case 12:
         error(i,2,0,2,5); break;
     }
      
     outFile.println("");
   }
   outFile.close();
   
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
  catch(java.text.ParseException e)
  {
    println(e);
  }
}
