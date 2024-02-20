## Project DEADLINES:
2/14 - Present project proposal
2/19 - Final proposal due
3/4 - Iteration 1 status report: Design and implement minimal viable system
3/18 - Iteration 2 status report: Iteratively improve minimal viable system
4/1 - Iteration 3 status report: Iteratively test and refine solution
4/15 - Present and submit report of our completed project implementation  


## Weekly Timeline:
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



### 2/26 - 3/3
**GOALS:**
1. Write status report 1
2. Implement "make move" function:
   * Need to add function to check if a bottle is complete:
      * Need to check bottles for completeness when the initial state of the level is loaded since the generator doesn't check if generated bottles are alerady sorted. 
   * Add function to check if level is complete (if number of bottles complete == number of colors) 
   * Functions to check for top color in a bottle, number of consecutive top color blocks, number of empty blocks
   * Boolean function is_valid to check if a move is valid:
      * false if:
         * Destination bottle is full (if get_empty_blocks == 0)
         * Source bottle is empty (if get_top_color() == 0)
         * Either bottle is already complete (if _get_complete() == true)
         * Top colors in source and destination bottle don't match (if bottle1._get_complete() != bottle2._get_complete())
   * Boolean make_move function:
      * Calls is_valid(bottle1, bottle2) to verify the move is possible
      * Determine number of blocks being moved (either the number of empty blocks in the destination bottle or number of consecutive top blocks in source bottle, whichever is smaller.
      * Make the move by swapping the colors on the blocks
      * return true if move was made or false if not       
4. Touch-screen integration, so the user can select the bottles they'd like to move to/from with their finger:
   * Do we need to add some kind of button functionality to the bottles?
   * Do we need to add anything special to the bottle nodes for them to recieve touch screen input?  
6. Successfully complete a level and load the next level:
   * How to load next level:
      * Should all the levels for a set be in one file? Maybe some kind of special character inbetween the levels in the input file to signal the end of each level?
      * Or should we have each level in an individual file? Can we load individual files in a directory in a particular order? 
8. Add "reset level" option:
   * Store initial state or just reload the file?
9. Add animation when a bottle is selected 


### 3/4 - 3/10
**DEADLINES:**
* 3/4: Iteration 1 status report: Design and implement minimal viable system

**GOALS:**
1. Load levels with varying number of colors and figure out how to adjust the layout as more bottles are added
2. Add "undo move" option
    * Need to add code that keeps some kind of list of the user's moves 
    * Pop the last move off the list and swap the blocks back to where they were
    * Make sure pressing "undo" button triggers this function to run
3. Add some kind of visual cue when the user tries to make an invalid move, like an animation or popup message
4. Write status report 2

### 3/11 - 3/17
SPRING BREAK!


### 3/18 - 3/24
**DEADLINES:**
* Monday 3/18 - Iteration 2 status report: Iteratively improve minimal viable system

**GOALS:**
1. Save the game state, so if user leaves the app and comes back later, it will load the level they were playing last
2. Save progress on incomplete levels, so user doesn't have to start over if they leave the app and come back in the middle of a level


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
