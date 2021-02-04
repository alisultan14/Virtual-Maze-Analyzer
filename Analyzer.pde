/* Virtual Maze Analyzer
 Sorawit R.
 Summer 2018
 roongrus@lafayette.edu
 - generates an summary .txt file(open with Excel/spreadsheet programs)and heat maps for each individual .txt log file
 - needs Processing to run/edit this program
*/


/*
  cells in the virtual maze are labeled A1(bottom right)-F6(top left). A-F runs right to left and 1-6 runs bottom to top
  HOWEVER in the log files the maze is 1536*1536 (36 cells of 256*256 pixels each) where (0,0) is bottom right
  for example, (123,250) is in A1 and (1500,1200) is F5
*/

import java.util.Scanner;
import java.io.File; 
import java.io.FileReader;
import java.io.FileNotFoundException;
import java.io.LineNumberReader;
import java.util.Date;
import java.text.DateFormat;
import java.text.SimpleDateFormat;


int nfiles; //number of files in Logs folder

String id[]; //participant id
int group[]; //group number: 1=normal, 2=abnormal
int mazeNumber[]; //maze number (1-12)
String mazeTrial[]; //maze trial (1-6)


double distance[][]; //distance in each cell
long duration[][]; //duration in each cell
double avgDistance[][]; //avg distance per cell per maze
long avgDuration[][];  //avg duration per cell per maze
double stdDistance[][]; //standard deviation of distance per cell per maze
double stdDuration[][]; //standard deviation of duration per cell per maze
double zDistance[][]; //z-score of distance per cell per maze
double zDuration[][]; //z-score of duratino per cell per maze
double pe[][]; //performance efficiency score - average of zDistance and zDuration

double totalDistance[]; //total distance per log file
double totalDuration[]; //total duration per log file
double meanSpeed[]; //totalDistance divided by totalDuration
double frozenTime[]; //time participant stays still per log file

int mazeCount[]; //number of log files per maze

PrintWriter outFile; //output directory

String directory; //input directory

int size = 300; //size of heat map

PGraphics pg; //new graphics window


void folderSelected(File selection) 
{
  if (selection == null)  //user doesn't select folder
    println("Window was closed or the user hit cancel."); 
  else  //user selects folder
  {
    directory = selection.getAbsolutePath();
    println("User selected " + selection.getAbsolutePath());
    runAnalysis();  //get summary .txt file and .jpg heat maps in the same directory as log files
  
    drawMap(); //draws and saves heat map
      println("test");
    exit(); //automatically quits program
  }
}



void setup() {
  size(300,300); //300x300 window for instructions
  background(0);
  textAlign(CENTER);
  textSize(24);
  fill(255);
  text("Choose Logs folder",150,100);
  textSize(16);
  text("analysis.txt and Heat Maps folder",150,200);
  text("will be in the same directory as Logs",150,220);
  
  selectFolder("Select a folder to process:", "folderSelected"); //select folder
  
  pg = createGraphics(300,300); //initiate PGraphics window for heat maps
  
}
