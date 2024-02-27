## Project DEADLINES:
2/14 - Present project proposal<br>
2/19 - Final proposal due<br>
3/4 - Iteration 1 status report: Design and implement minimal viable system<br>
3/18 - Iteration 2 status report: Iteratively improve minimal viable system<Br>
4/1 - Iteration 3 status report: Iteratively test and refine solution<br>
4/15 - Present and submit report of our completed project implementation <Br> 


## Weekly Timeline:
### 2/26 - 3/3
**GOALS:**
1. Write status report 1
2. Read input file and successfully load 1 level with correct colors (3 colors 4 bottles)
   * **Shanna:** Read and parse input file strings into arrays and put the arrays in a list. check each level array for errors. pop 1st level off list and extract the data from it to initialize the level
   * **Boone:** Keep working on getting the main program set up  
3. Start implementing game play functions:
   * **Coleman:** Work on the undo function. Keep looking into animation for the nodes when bottles are selected/colors transfered
   * **Logan:** Create the undo, make move, and reset level functions and maybe just have them print some kind of alert like "undoing move" for now when bottons are pressed, so we can check that the buttons are calling the functions correctly.  


### 3/4 - 3/10
**DEADLINES:**
* 3/4: Iteration 1 status report: Design and implement minimal viable system

**GOALS:**
1. Game play functions working correctly
2. Play level, clear the level data, then load the next level. Make sure this loop is working like it should.
3. Add undo move function
4. Add reset move function

### 3/11 - 3/17
SPRING BREAK!


### 3/18 - 3/24
**DEADLINES:**
* Monday 3/18 - Iteration 2 status report: Iteratively improve minimal viable system

**GOALS:**
1. Saving the game: save the level file list so they can start on the level they were on when the game is reloaded. Save progress on incomplete levels. 
2. Add more bottles, figure out if adjustments to grid container will be necessary as more bottles are added


### 3/25 - 3/31
**GOALS:**
1. Write status report 3
2. Add options to change difficulty level
    * Maybe have "easy", "medium", and "difficult" sets of levels to choose from?
3. Add increased difficulty option: hide the color on all blocks except the top block. After user moves top block, the color on the block that was beneath it will be exposed
4. Add level timer

### 4/1 - 4/7
**DEADLINES:**
* Monday 4/1 - Iteration 3 status report: Iteratively test and refine solution

**GOALS:**
1. Add animations when transferring color from one bottle to another
2. Background music and sound effects

### 4/8 - 4/14
**GOALS:**
1. Write report and prepare presentation
2. Complete any final adjustments


### 4/15 - 4/21
**DEADLINES:**
* Monday 4/15: Present and submit report of our completed project implementation  


## Past Weeks
### 2/5 - 2/11
**GOALS:** 
1. Finalize team selection
2. C++ Color Sort game files completed, documented, and posted to Color Sort repo
3. Begin outlining and drafting proposal

### 2/12 - 2/18
**DEADLINES:**
* 2/14 Wednesday: Proposal presentation

**GOALS:**
1. Complete project proposal:
    * **Shanna:** Write introduction with short description of the game. Create project timeline and add to Project Management section
    * **Boone:** Write Section 3: Proposed solution and technology
    * **Logan:** Section 2: Customer value and Project Management section
    * **Coleman:** Create a diagram of the system
    * **All:** Add background information to section 4
2. Create a schedule of tasks, goals, and deadlines
3. Install and setup software/tools necessary for project:
    * Install Godot 
    * C++ Godot extention installed and working
    * Find some good tutorials on getting starting with Godot
    * Create directory for our godot files on the project repo

4. Begin app development process:
    * **Logan:** Figure out a good layout for displaying 3 - 14 bottles on a phone screen, with some kind of toolbar or buttons for the reset and undo options
    * **Coleman:** Choose 12 colors to use for the game that look nice together and aren't too similar to one another. Make 12 image files to load for the block objects. Square, solid color images, with a separate file for each color.
    * **Shanna**: Add error-checking to play.cpp so the game will not attempt to load bad level data input files. Start figuring out how to test levels for solvability so we don't put any unsolvable levels in the app
    * **Boone:** Figure out if the existing C++ Color Sort code can be integrated with Godot or if it would be better to translate the code to something else


### 2/19 - 2/25
**DEADLINES:**
* 2/19 Monday: Final proposal complete

**GOALS:**
1. Decide on basic tree and node structure for the level:
    * Create a simple level in Godot
2. Input level data file and create the level:
    * **Shanna:** Adjust level generator to output in new format. Create level sets with the new file format. 
    * **Shanna:** Write Bottle and Block scripts to add properties to bottle and block nodes 
    * **Boone:** Write GDScript code to parse the input file
    * Create the number of bottle and block nodes indicated in the input file (4 bottles with 4 blocks each and  3 colors to sort for the initial level)
    * **Coleman:** Get the RBG values for the 12 colors. Add the color numbers to the blocks (set_color()) depending on the color_num value that was loaded from the input file (whether _get_color_num == 1, 2, etc) 
    * **Logan:** Work on button design for the "Undo"/"Reset level"/"Help" buttons. Work on writing script to load the buttons and assigning action to execute when they're pressed. 
3. Sucessfully display one 3 color Color Sort level that was loaded from an input file