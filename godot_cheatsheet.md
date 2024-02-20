# Godot Cheat Sheet
## SETTING UP A NEW PROJECT
* Create the Project:
    * |+| New
    * Pick a folder
    * Renderer: Mobile
    * Version Control Metadata: Git
* Create the Root Node: 
    * 2DScene Node
    * Control Node (User Interface)
* Save project after creating root node to get your main .tscn project file
* Set the size for the level's display (called the "**Viewport**"):<br> 
    * Top Toolbar -> Project -> Project Settings -> Display -> Window -> Viewport Width and Viewport Height
    * 720 x 1280 (16:9) is a pretty typical aspect ratio for a smartphone display 

## GODOT'S TOOLBARS AND PANELS
#### Viewing the Scene (window in center of screen)
* Select "**2D**" at the top for 2D game display
    * The Viewport is the area inside the blue borders on the 2D display screen
* Select "**Script**" to open a text editor for any project scripts. 
    * There will be a list of any you've added to the left of the editor.
    * Can also view documentation you've opened here
* The toolbar above the window:
    * Use arrow to select nodes
    * Use move mode (button to right of arrow) if you wanna move a node around
    * Rotate mode to rotate a node
    * Pan mode (hand icon) to move the window around
    * Ruler mode to measure an exact amount of pixels or angles
    * Grid snap: can hide or display the grid in the background 
    * Lock: prevent node from being selected or moved
    * The little green square has options for horizontal and vertical alignment
    * The green circle with a plus sign has anchor options: can anchor node to the center, right edge, top edge, etc 


#### Node List (top left side of screen)
* Can click and drag nodes to a different place in the tree to re-order them or reassign to a different parent node
* Dragging Node 1 on top of Node 2 will make Node 1 a child node of Node 2
* Click the eyeball icon next to a node to hide it
* |+| button to add a new node 
* Right-click node for options:
    * Rename
    * Change the type of the node
    * Open the Godot documentation page for the node type
    * Add scripts - add a script to a node to add special properties
    * Copy/cut/paste/delete the node
#### FileSystem (bottom left side of screen)
* List of files in your project folder
* You can drag-and-drop files from this list
    * For example, if you want to add a picture to a texture box node, you can click the picture's filename then drag it into the texture box for the node

#### Inspector Tab (right side of screen)
* Here's where you find all the customization options for the node, like themes, sizing, visibility
* **Layout**:
    * **Anchor**: 
        * Can anchor the node to a certain point in the Viewport - side, bottom, center, top, etc
        * Select "**Custom**" to manually set anchor values
            * "**Anchor Points**":
                * Values from 0 - 1
                * Values outside of that range will be outside of Viewport  
                * Everything is relative to the top left corner
                * Anchor points to have the node fill the Viewport:
                    * Left:0
                    * Top: 0
                    * Right: 1
                    * Bottom: 1
                * If you changed Bottom to 0.5, the node will cover the top half of the Viewport. Bottom = 0.75, it'll cover the top 3/4ths of the Viewport
            * "**Anchor Offsets**":
                * Offset the node a certain number of pixels from the edges of the Viewport
                * Left: 100px will move the left border of the node 100px to the right of the left border of the Viewport
    * **Transform**:
        *  Size: 
            * Change the size of the node
            * x: width
            * y: height
        * Position:
            * This is offset from the top left corner
            * Increasing x will move the node to the right
            * increasing y moves it down
        * Rotation:
            * Slider bar for rotating the node, or you can type a specific number of degrees
    * **Container Sizing**:
        * Options for filling/shrinking vertically/horizontally
        * "Expand" to have the node fill out the area
        * **Stretch Ratio**: 
            * You can use this to change the size of nodes in a container relative to one another
            * For example, if you have a vertical box container with 3 nodes and you want the top node to be 3x bigger than the other two nodes, you would set Stretch Ratio = 3 for the top node and Stretch Ratio = 1 for the bottom 2 nodes
* **Theme**: 
    * Can drag-and-drop pictures over the theme box to add a picture to a node
    * Can also create or load custom themes
* **Ordering**:
    * Nodes with a higher Z index will be shown on top of nodes with a lower Z index
    * So to have the bottle nodes show on top of the background nodes, we set background's Z index to 0 and the bottle and block nodes to 1
* **Metadata**:
    * I thiiiiiink this might be how you can add properties to nodes instead of manually defining them in a script?
    * So we might be able to add the properties like "bool is_complete", "int top_color" etc here instead of in a script? maybe?
    * not sure if we would still need to manually define getter/setter functions to work with our game script tho 
#### Node Tab (right side of screen)
* Shows a list of methods for the node
#### History Tab (right side of screen .. might have to use the lil > button to see it)
* See list of the changes made
* Can click on them to go back

## NODE TYPES
### Control Nodes
* Control nodes have a bounding rectangle and is anchored relative to it's parent node or the current viewport
* Offsets update automatically if the size of the screen, the node, or the node's parent node changes

#### Container Nodes:
* **Container**
    * General container type
* **BoxContainer**
    * Arrange nodes beside/on top of each other in a box
    * Child nodes will automatially anchor to the parent and move/resize with it if the box is moved or resized
    * When you add a child node, need to fix size:
        * Inspector -> Layout -> Container Sizing 
        * Set both horizontal and vertical sizes to "fill" and check the "Expand" box
    * The first child node will fill the full size of the container
    * When you add subsequent nodes, the parent node will resize the children automatically 
    * **HBoxContainer:** Arrange nodes side by side
    * **VBoxContainer:** Arrange nodes vertically 
* **GridContainer:** Arranges child nodes in a grid
* **FlowContainer** 
    * Arranges child nodes horizontally/vertically and wraps at the edges
    * **HFlowContainer**: Will arrnage nodes side by side like a HBoxContainer until it runs out of room, then it will wrap around to a new row underneath
    * **VFlowContainer**: Will arrnage nodes on top of each other like a VBoxContainer until it runs out of room, then it will wrap around and create a new column

#### ColorRect
* Rectangular shaped node that displays a solid color
* Can use the color wheel to pick a color or input hex values or RGB numbers. There's also an eyedropper you can use to select colors from the screen
* has a **Color** value:
    * Color color(r,g,b,a)
    * each value is a float, usually between 0.0 and 1.0
    * getter: get_color()
    * setter: set_color(value)
    * boolean: Color(0, 0, 0, 1) will evaluate to false while any other color gives true
#### TextureRect
* Node that can display a picture
* settings for stretching the picture,  adjusting it to fit, tiling it
* Can drag-and-drop pics from the FileSystem on the left to the Texture box in the Inspector panel
#### Buttons
                