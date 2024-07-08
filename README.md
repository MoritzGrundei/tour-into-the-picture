<h1>Tour-Into-The-Picture (TIP)</h1>

Computer Vision Challenge SoSe 2024

Contributor: Martin Ausborn, Moritz Grundei, Kevin Hu, Thomas Schwarzfischer, Andreas Umlauf, Chien-Chun Wang

Implementation based on: Youichi Horry, Ken-Ichi Anjyo, and Kiyoshi Arai. Tour into the picture: using a spidery mesh interface to make animation from a single image. In Proceedings of the 24th annual conference on Computer graphics and interactive techniques, pages 225-232, 1997.

// Platzhalter Poster

<h2>Demo</h2>


<h2>Assignments</h2>

  - create Graphical User Interface which enables
      - selecting 2D image from the device
      - define vanishing point and inner rectangle
      - change the perspective of the room
  - reconstruct 3D image from a single 2D image
  - the algorithm should...
      - handle different image sizes
      - handle images where the planes are not clearly defined
      - handle images without a clear vanishing point
      - handle unknown images (test images)

<h2>How to use?</h2>
  
  - **Software requirements**:
      - MATLAB R2024a
      - MATLAB Toolbox:
          - Computer Vision Toolbox
          - Image Processing Toolbox
          - Statistics and Machine Learning Toolbox
  - **Step-by-Step manual**:
    1. clone repository onto your local machine
    2. open project on MATLAB
    3. add src folder and its subfolders to path and run main.m
    4. select image of the 2D room that should be reconstructed by clicking on "Upload new image"
       - if the selection was successful, the light of "Upload a image" will turn to green
    5. select the vanishing point of the image by clicking on the "Select vanishing point" button and clicking onto the image where the vanishing point should be
       - the light next to "select the vanishing point" will turn green in case the selection was successful
    6. select the background rectangle by pressing on the "Select Background Rectangle" button and manually drawing the rectangle onto the image
       - the light for "Select the background rectangle" will turn green afterwards
    7. the radial lines through the vanishing points and the vertices of the inner rectangle are displayed, the vanishing point and the inner rectangle can still be adjusted
    8. (optional) if there are foreground objects in the image, one can press "Optional: Select Foreground Rectangle" to draw a polygon around the object or multiple polygons around objects
       - enable "Foreground Segmentation" in case the selection of the object is not well defined
    9. Once the configuration is done, press "Start 3D Tour" to start
    10. one can always reset the configuration by pressing "Reset" to repeat steps 4 - 8
    11. after a successful 3D reconstruction, a window with the Tour into the reconstructed room will open
    12. after the video, the user may move the camera to move freely in the room by going forward/backward, to the right/left or rotate the room

<h2>Workflow</h2>

![Workflow image](https://github.com/MoritzGrundei/cv-challenge/blob/main/img_poster/Workflow_plot.png)

<h2>Step-by-Step</h2>

<h3>User Interaction</h3>

<h3>Foreground Object Segmentation</h3>

<h3>12-Points Estimation</h3>

  ![12 Point image](https://github.com/MoritzGrundei/cv-challenge/blob/main/img_poster/12_Point_Plot.png)

  - Estimate the 12 vertices of the 3D room using the 2D pixel coordinates of the vanishing point and the inner rectangle
  - draw 4 radial lines where each radial line starts at the vanishing point and intersects one of the vertices of the inner rectangle
  - the intersections of the radial lines with the image borders on the top, right, left and at the bottom yield the 12 coordinates of the room vertices described in the paper
  - Step-by-Step:
    1) compute slope and y-intercept using the given coordinates of the inner rectangle and the vanishing point
    2) assuming that the height of the image is n and the width of the image is m, calculate the corresponding coordinates of the intersections using the linear functions where
        - top left radial line intersects with x=1 and y=1
        - top right radial line intersects with x=n and y=1
        - bottom left radial line intersects with x=1 and y=m
        - bottom right radial line intersects with x=n and y=m

<h3>Compute Room Dimensions</h3>

  - Room width and room heigth get defined by the number of pixels in the background rectangle
  - Compute the euclidean distances between the 12 points and the vanishing point
  - Define the z-coordinate of point 4 as one in order to have a referenz in the z-dimension
  - Compute the relative z-coordinates of points 2,5,6 and 10 with the distance ratios and referens of point 4
    $$\displaystyle z_6 = \frac{\left \lVert v_{vp}-v_4 \right \rVert_2}{\left \lVert v_{vp}-v_6 \right \rVert_2} *z_4$$
  - Scale the resulting relative z-coordinates based on the pixel number in the image and a constant factor to improve the quality in the 3D-plot


<h3>Foreground Positioning</h3>  
  
   - The rectangular frame of the foreground object defines its position in the 3D room
     1. Calculate the wall where the foreground object is attached to. An object is assigned to a wall if the cross products of its corners with the vertices of a trapezoid are positive
     2. Use the projective transformation function to calculate the 3D foreground rectangle points from the 2D coordinates

<h3>Foreground Plotting</h3>

  - Iterate through all foreground objects individually
  - Use the mask of the foreground image and make the mask transparent

<h3>3D Room Reconstruction</h3>

  - From the 12 points the five walls are defined, consisting of four trapezoidal shapes and one background rectangle 
  - Transform the trapezoidal shapes into rectangles:
     1. Calculate the transformation Matrix with fitgeotrans and the according room dimnesions of the image
     2. Apply the transformation with the Image Processing Toolbox function imwarp
  - Return each wall seperately
  - Create 3D plot with the properties: 
     1. The x and y plane define the background wall
     2. The z dimension is defining the depth of the plot 
  - Define the camera perspective and toolbar to create 3D view 
  - Create 3D room tour by continuously updating the camera position, include the foreground position in the tour

