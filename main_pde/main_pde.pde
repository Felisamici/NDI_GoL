final int NB_LINES = 20;
final int NB_COLUMNS = 20;

int CASE_WIDTH = width / NB_COLUMNS;
int CASE_HEIGHT = height / NB_LINES ;

class Case {
  
  boolean living = false;
  
  boolean newState = false;
  
  int i;
  int j;
   Case(int line, int column) {
       this.i = line;
       this.j = column;
   }
   
   void display() {
     if(this.living) {
       fill(0);
     } else {
       fill(255);
     }
      rect(this.j * CASE_WIDTH, this.i * CASE_HEIGHT, CASE_WIDTH, CASE_HEIGHT);
   }
   
   void changeLiveState() {
       this.living = this.living == true ? false : true;
       this.newState = this.living;
   }
   
   int nbLivingNeighbours() {
      int nb = 0;
      int[][] coords = {{i-1,j-1}, {i-1, j}, {i-1, j+1}, {i, j-1}, {i, j+1}, {i+1, j-1}, {i+1, j}, {i+1, j+1}};
      for(int[] a : coords) {
        if(a[0] >= 0 && a[0] < NB_LINES) {
          if(a[1] >= 0 && a[1] < NB_COLUMNS) {
            if(grid[a[0]][a[1]].living) {
              nb++;
            }
          }
        }
      }      
      return nb;
   }
   
   void live() {
       int nb = this.nbLivingNeighbours();
       if(this.living) {
           if(nb != 2 && nb != 3) {
               this.newState = false;     
           }
       } else {
           if(nb == 3) {
               this.newState = true;
           }
       }
   }

}

Case[][] grid;
boolean started = false;

void setup() {
  frameRate(10);
  size(800, 800);
  CASE_WIDTH = width / NB_COLUMNS;
  CASE_HEIGHT = height / NB_LINES;
  background(0);
  grid = new Case[20][20];
    for(int i=0; i<20; i++) {
        for(int j=0; j<20; j++) {
          grid[i][j] = new Case(i, j);
        }
    }
    
    // Créer BATO
    
    grid[0][1].changeLiveState();
    grid[1][2].changeLiveState();
    grid[2][2].changeLiveState();
    grid[2][1].changeLiveState();
    grid[2][0].changeLiveState();
}

void mousePressed() {
    int x = mouseY / CASE_WIDTH;
    int y = mouseX / CASE_HEIGHT;
    
    Case clickedCase = grid[x][y];
    clickedCase.changeLiveState();
}

void keyPressed() {
  started = started == true ? false : true;
}

void draw() {
  for(int i=0; i<20; i++) {
        for(int j=0; j<20; j++) {
          if(started) {
              grid[i][j].live();
          }
          grid[i][j].display();
        }
    }
    
    if(started) {
      for(int i=0; i<20; i++) {
          for(int j=0; j<20; j++) {
            grid[i][j].living = grid[i][j].newState;
          }
        }
      }
    
    
    
}
