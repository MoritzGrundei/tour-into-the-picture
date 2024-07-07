<h1>Tour-Into-The-Picture (TIP)</h1>


<h2>Demo</h2>


<h2>Assignments</h2>


<h2>How to use? - Quick Start</h2>


<h2>Workflow</h2>


<h2>Step-by-Step</h2>

<h3>User Interaction</h3>

<h3>Foreground Object Segmentation</h3>

<h3>12-Points Estimation</h3>

<h3>Compute Room Dimensions</h3>

  - Room width and room heigth get defined by the number of pixels in the background rectangle
  - Compute the euclidean distances between the 12 points and the vanishing point
  - Define the z-coordinate of point 4 as one in order to have a referenz in the z-dimension
  - Compute the relative z-coordinates of points 2,5,6 and 10 with the distance ratios and referens of point 4
  - Scale the resulting relative z-coordinates based on the pixel number in the image and a constant factor to improve the quality in the 3D-plot

<h3>3D Room Reconstruction</h3>

<h2>Challenges</h2>
