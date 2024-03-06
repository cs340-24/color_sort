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