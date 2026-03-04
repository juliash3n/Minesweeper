import de.bezier.guido.*;
//Declare and initialize constants NUM_ROWS and NUM_COLS = 20
int NUM_ROWS = 20;
int NUM_COLS = 20;
int NUM_MINES = 10;
private MSButton[][] buttons; //2d array of minesweeper buttons
private ArrayList <MSButton> mines = new ArrayList <MSButton>();

void setup ()
{
    size(400, 400);
    textAlign(CENTER,CENTER);
    
    // make the manager
    Interactive.make( this );
    
    //your code to initialize buttons goes here
    buttons = new MSButton[NUM_ROWS][NUM_COLS];
    for(int i = 0; i<NUM_ROWS; i++)
        for(int j = 0; j<NUM_COLS; j++)
        buttons[i][j] = new MSButton(i,j);
    
    
    setMines();
}
public void setMines()
{
    while(mines.size()<NUM_MINES){
      int myRow = (int)(Math.random()*(NUM_ROWS));
      int myCol = (int)(Math.random()*(NUM_COLS));
      if(!mines.contains(buttons[myRow][myCol]))
          mines.add(buttons[myRow][myCol]);
    }
}

public void draw ()
{
    background( 0 );
    if(isWon() == true)
        displayWinningMessage();
}
public boolean isWon()
{
    //your code here
    return false;
}
public void displayLosingMessage()
{
    //your code here
}
public void displayWinningMessage()
{
    //your code here
}
public boolean isValid(int r, int c)
{
    if(r<NUM_ROWS && c<NUM_COLS && r>=0 && c>=0)
    return true;
    return false;
}
public int countMines(int row, int col)
{
    int numMines = 0;
    for(int i = row-1; i<row+2; i++){
      for(int j = col-1; j<col+2; j++){
        if(isValid(i,j)==true && mines.contains(buttons[i][j]))
        numMines++;
      }
    }
    if(mines.contains(buttons[row][col]))
    numMines--;
    return numMines;
}
public class MSButton
{
    private int myRow, myCol;
    private float x,y, width, height;
    private boolean clicked, flagged;
    private String myLabel;
    
    public MSButton ( int row, int col )
    {
        width = 400/NUM_COLS;
        height = 400/NUM_ROWS;
        myRow = row;
        myCol = col; 
        x = myCol*width;
        y = myRow*height;
        myLabel = "";
        flagged = clicked = false;
        Interactive.add( this ); // register it with the manager
    }

    // called by manager
    public void mousePressed () 
    {
        clicked = true;
        if(mouseButton == RIGHT)
        flagged = !flagged;
        else if(mouseButton == LEFT && mines.contains(this))
        displayLosingMessage();
        else if(countMines(myRow, myCol) > 0)
        myLabel = String.valueOf(countMines(myRow, myCol));
        else
        for(int i = myRow-1; i<myRow+2; i++){
          for(int j = myCol-1; j<myCol+2; j++){
            if(isValid(i,j)==true && countMines(i,j) == 0)
            buttons[i][j].mousePressed();
          }
        }
        
    }
    public void draw () 
    {    
        if (flagged)
            fill(0);
        else if( clicked && mines.contains(this) ) 
             fill(255,0,0);
        else if(clicked)
            fill( 200 );
        else 
            fill( 100 );

        rect(x, y, width, height);
        fill(0);
        text(myLabel,x+width/2,y+height/2);
    }
    public void setLabel(String newLabel)
    {
        myLabel = newLabel;
    }
    public void setLabel(int newLabel)
    {
        myLabel = ""+ newLabel;
    }
    public boolean isFlagged()
    {
        return flagged;
    }
}
