<h1>Tour-Into-The-Picture (TIP)</h1>


<h2>Demo</h2>


<h2>Assignments</h2>


<h2>How to use? - Quick Start</h2>


<h2>Workflow</h2>


<h2>Step-by-Step</h2>

<h3>User Interaction</h3>

<h3>Foreground Object Segmentation</h3>

<h3>12-Points Estimation</h3>

  - Estimate the 12 vertices of the 3D room using the 2D pixel coordinates of the vanishing point and the inner rectangle
  - draw 4 radial lines where each radial line starts at the vanishing point and intersects one of the vertices of the inner rectangle
  - the intersections of the radial lines with the image borders on the top, right, left and at the bottom yield the 12 coordinates of the room vertices described in the paper
  - Step-by-Step:
    1. compute slope and y-intercept using the given coordinates of the inner rectangle and the vanishing point
    2. assuming that the height of the image is n and the width of the image is m, calculate the corresponding coordinates of the intersections using the linear functions where
      - top left radial line intersects with x=1 and y=1
      - top right radial line intersects with x=n and y=1
      - bottom left radial line intersects with x=1 and y=m
      - bottom right radial line intersects with x=n and y=m

<h3>Compute Room Dimensions</h3>

  - Room width and room heigth get defined by the number of pixels in the background rectangle
  - Compute the euclidean distances between the 12 points and the vanishing point
  - Define the z-coordinate of point 4 as one in order to have a referenz in the z-dimension
  - Compute the relative z-coordinates of points 2,5,6 and 10 with the distance ratios and referens of point 4
  - Scale the resulting relative z-coordinates based on the pixel number in the image and a constant factor to improve the quality in the 3D-plot


<h3>Foreground Positioning  
  
  - The foreground rectangular frame defines the position in the 3D room
     1. Calculate the wall the foreground object is attached to by checking the cross product of the foreground points with the four vertices of each trapezoid
     2. Use the projective transformation function to calculate the 3D foreground rectangle points attached to the corresponding wall from 2D coordinates

<h3>Foreground Plotting

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

<h2>Challenges</h2>o
