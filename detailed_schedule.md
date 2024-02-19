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
1. Start integrating the Color Sort code with Godot, reworking in GDScript if necessary
2. Sucessfully display one Color Sort level to the screen:
    * Read level input file and load the level's data into the game
    * Create godot objects for the bottles
    * Display the bottles to the screen with our designed layout
    * Load the color files and display the colors for each block

### 2/26 - 3/3
**GOALS:**
1. Write status report 1
2. Implement "make move" function  
3. Touch-screen integration, so the user can select the bottles they'd like to move to/from with their finger 
4. Successfully complete a level and load the next level
5. Add "reset level" option


### 3/4 - 3/10
**DEADLINES:**
* 3/4: Iteration 1 status report: Design and implement minimal viable system

**GOALS:**
1. Add options to change difficulty level
    * Maybe start with 3 level sets, "easy", "medium", and "difficult"?
2. Add "undo move" option
    * Need to add code that keeps some kind of list of the user's moves 
    * Pop the last move off the list and swap the blocks back to where they were
3. Add some kind of visual cue when the user tries to make an invalid move
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
2. Add increased difficulty option: hide the color on all blocks except the top block. After user moves top block, the color on the block that was beneath it will be exposed
3. Add level timer

### 4/1 - 4/7
**DEADLINES:**
* Monday 4/1 - Iteration 3 status report: Iteratively test and refine solution

**GOALS:**
1. Add animations when transferring color from one bottle to another
2. Animation when selecting a bottle

### 4/8 - 4/14
**GOALS:**
1. Write report and prepare presentation
2. Complete any final adjustments


### 4/15 - 4/21
**DEADLINES:**
* Monday 4/15: Present and submit report of our completed project implementation  