/***************************************************************************
 * Color Sort: playjgraph.cpp
 * Shanna Wallace
 * 
 * This program allows you to play multiple levels of Color Sort. It 
 * uses jgraph to generate a jpg of the game (colorsort.jpg)
 * 
 * It takes the following command line arguments:
 * bin/playj.cpp <input_file>
 * input_file: the name of a file containing data for the Color Sort levels.
 * This file should have one line in the format:
 *   num_bottles, num_blocks, then the values for each block in the bottles, 
 *   starting with the top block in the 1st bottle and ending with the bottom 
 *   block in the last bottle, each separated by a space. 
 * 
 * To play the game, the user may enter:
 *   H to see instructions on how to play Color Sort
 *   R to reset the level
 *   Q to quit.
 *   n1 n2 to make a move, where n1 is the number of the source bottle and 
 *       n2 is the number of the destination bottle, separated by a space.
 * 
 * You will need to open colorsort.jpg in an application that automatically
 * refreshes when the file is changed or manually refresh the .jpg after 
 * you make a move.
*****************************************************************************/
#include <iostream>
#include <vector>
#include <fstream>
#include <cstring>
#include "../include/ColorSort.hpp"
using namespace std;

// Files containing messages to be displayed in the game
string WELCOME_MSG = "game_msgs/welcome.txt";
string INSTR = "game_msgs/how_to.txt";


int main(int argc, char *argv[]) {

    string input;        // User's input for game action
    int from, to;        // Number of the bottles color is being moved from and to    
    int level_num;       // Number of the level user is on
    ifstream input_file; // File containing game data
    string level;        // Data for individual level
    ColorSort *game = new ColorSort; // Game level 

    if (argc != 2){
        cerr << "Usage: " << argv[0] << " <input_file>\n";
        return -1;
    }


    // Open file with game data
    input_file.open(argv[1]);
    if (input_file.fail()){
        cerr << argv[1] << ": " << strerror(errno) << endl; 
        cerr << "Could not load game data.\n";
        return -1;
    }


    // Print welcome message
    cout << "Hello, welcome to Color Sort! \nOpen the file colorsort.jpg to see the game. You may need to manually refresh the picture after you make a move if the app you're using does not manually refresh.\n";
    cout << "Enter H to see instructions on how to play the game.\n\n";

    // Load each level
    level_num = 1;
    while (getline(input_file, level)){
       
        // Play level
        if (game->load_level(level)){     
            cout << "LEVEL " << level_num << ":\n";

            while (game->level_complete() == false){
            //game->create_jgraph();
            game->print_bottles();

                cin.clear();
                cout << "ENTER MOVE: ";
                getline(cin, input);

                // Reset level
                if (input == "R" || input == "r"){
                    game->reset_level();
                
                // Quit game
                } else if (input == "Q" || input == "q"){
                    cout << "\nThanks for playing Color Sort!\nGoodbye\n";
                    return 0;
                
                // Print instructions
                } else if (input == "H" || input == "h"){
                    game->print_msg_file(INSTR);

                // Make move
                } else if (sscanf(input.c_str(), "%d %d", &from, &to) == 2){
                    if (game->make_move(from, to) == false){ 
                        cerr << "Cannot move from " << from << " to " << to << ".\n";
                    }

                } else {
                    cerr << "Invalid input.\n";
                }
            
            }

            //game->create_jgraph();
            game->print_bottles();

            cout << "\n**********  LEVEL COMPLETE!  **********\n\n";
            return 0;

        }
    }
    cout << "\n\n**********  CONGRATS! YOU HAVE COMPLETED ALL LEVELS  **********\n";
    input_file.close();
    return 0;
}