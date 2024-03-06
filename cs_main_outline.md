## Color Sort Godot Main Program Outline
### Set up the game
* **load up the root scene:**
    * background node
        * colorRec for a solid color
        * textureRec if we wanna use a picture
    * container for the bottles 
        * grid for now but maybe a flow container would be better - maybe experiment with this more when we starting adding more bottles
    * button toolbar:
        * undo 
        * reset
        * help (show gameplay instructions)
        * maybe a pull down or pop up menu with options to change difficulty or change to different level sets
* **create level list:**
    * open game file
    * get_line through the file 
    * parse each line from string into an array
    *  error check the input
        * does the number of color vals == (num_blocks * num_bottles) 
        * are there num_blocks blocks of each color
        * are num_blocks and num_bottles in range (3 - 14 bottles. like 4 - 6 probably for num_blocks)
        * bottles need to be completely empty or completely full
        * correct number of empty bottles (one if 3 or 4 bottles, 2 if 5 or more bottles)
    *  push_back array to level_list

### While there are levels to play
* while level_list.is_empty() == false
* iterate through the list of levels starting from the top of the list (list[0])

### Play a level
* **Load the level data:**
    * level_info array = level_list.pop_front()
    * create num_bottles (level_info[0]) instances of bottle scenes
    * possibly resize number of columns in grid depending on number of bottles there are gonna be?
    * Add num_blocks blocks (level_info[1]) to the bottle scenes, setting the color vals (level_info[2] - level_info[level_info.size() - 1])
    * see if any bottles are already complete = bottles_completed (generator doesn't check if any bottles are already complete after it shuffles)
* **While game is not complete: (level_complete == false)**
    * get user input:
        * record where they touched the screen
        * if they touch a bottle, need to get the 2nd bottle input
    * apply user input:
        * undo move
        * reset level
        * make move
* **Clear the level:**
    * clear list of moves
    * reset level_complete to false
    * reset bottles_completed counter
    * maybe free bottles? tree free?

### variables/methods for the overall game:
*  list of levels (array of arrays)

### variables/methods for an individual level. put these functions in the process delta section:
#### methods:
*  **(bool) make move**
    * true if bottles are valid,
        * see how many blocks can be moved
            * number of empty blocks in destination or number of consecutive top blocks in source, whichever is smaller
        * swap_blocks
        * add the move to the list of moves
        * return true
    * false if can't make a move
        * have some kind of "invalid move" alert or visual if false?

*  **(bool) are the bottles valid:**
    * false if:
        * Destination bottle is full (if get_empty_blocks == 0)
        * Source bottle is empty (if get_top_color() == 0/null/empty color)
        * Either bottle is already complete (if _get_complete() == true)
        * Top colors in source and destination bottle don't match (get_top_color)

* **swap_blocks:**
    * make_move and undo_move call this to swap the blocks
    * change the empties in the destination to source.top_color and the consecutive top blocks in source to empties

*  **reset level:**
    * push_front the level_info string back onto level_list
    * break the inner while loop, clear the level, go to the next iteration (which will load the same level since we pushed it back on top of the list)  
*  **undo move:**
    *  pop the last move off the list
*  **(bool) is bottle_complete:**
    *  true if bottle is full and are all the blocks the same color
    * num_empties = 0, consec_blocks == num_blocks
*  **(bool) level_complete:**
    * return true if bottles_completed so far == num_colors in the level
    
#### variables:
* (array) list of moves so far:
    * maybe an array of info you need to swap them back
    * which bottles you moved to/from and how many blocks you moved, then swap them back
* (int) bottles_completed so far
* (int) num_colors in the level
    * num_colors = num_bottles - 1 if num_bottles <= 4 
    * num_colors = num_bottles - 2 if num_bottles > 4
    * or i could just put it back in the generator output string
* (int) num_bottles 
    * level_info[0]
* (int) num_blocks
    * level_info[1]

