<h1>Tour-Into-The-Picture (TIP)</h1>

Computer Vision Challenge SoSe 2024

Contributor: Martin Ausborn, Moritz Grundei, Kevin Hu, Thomas Schwarzfischer, Andreas Umlauf, Chien-Chun Wang

Implementation based on: Youichi Horry, Ken-Ichi Anjyo, and Kiyoshi Arai. Tour into the picture: using a spidery mesh interface to make animation from a single image. In Proceedings of the 24th annual conference on Computer graphics and interactive techniques, pages 225-232, 1997.

[![Poster](https://github.com/MoritzGrundei/cv-challenge/blob/main/img_poster/Poster.png)](https://github.com/MoritzGrundei/cv-challenge/blob/main/img_poster/Poster.png)

<h2>Demo</h2>

[![YouTube Video](https://img.youtube.com/vi/Qzywup2Et_M/0.jpg)](https://youtu.be/Qzywup2Et_M)

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
    3. run main.m
    4. select image of the 2D room that should be reconstructed by clicking on "Upload new image"
       - if the selection was successful, the light of "Upload a image" will turn to green
    5. select the vanishing point of the image by clicking on the "Select vanishing point" button and clicking onto the image where the vanishing point should be
       - the light next to "select the vanishing point" will turn green in case the selection was successful
    6. select the background rectangle by pressing on the "Select Background Rectangle" button and manually drawing the rectangle onto the image
       - the light for "Select the background rectangle" will turn green afterwards
    7. the radial lines through the vanishing points and the vertices of the inner rectangle are displayed, the vanishing point and the inner rectangle can still be adjusted
    8. (optional) if there are foreground objects in the image, one can press "Optional: Select Foreground Rectangle" to draw a polygon around the object or multiple polygons around objects
       - enable "Foreground Segmentation" in case the selection of the object is not well defined
    9. once the configuration is done, press "Start 3D Tour" to start
    10. one can always reset the configuration by pressing "Reset" to repeat steps 4 - 8
    11. after a successful 3D reconstruction, a window with the Tour into the reconstructed room will open
    12. after the video, the user may move the camera to move freely in the room by going forward/backward, to the right/left or rotate the room
    13. the figure is saved automatically into the output folder. To reopen it, double click in Matlab
    14. to control the camera, select "View" -> "Camera"

<h2>Workflow</h2>

![Workflow image](https://github.com/MoritzGrundei/cv-challenge/blob/main/img_poster/Workflow_plot.png)

<h2>Detailed Data Processing Flow</h2>

<h3>User Interaction</h3>
  - The vanishing point and the background rectangle are selected by the user.
  - The vanishing lines are aligned with the edges of the scene.
  - A polygon is drawn around each foreground object. If only a rough selection is made, segmentation is switched on.

<h3>Foreground Object Segmentation</h3>
  - The foreground polygon is fitted into a rectangle.
  - Foreground/background segmentation is computed using grabcut on superpixels.

<h3>12-Points Estimation</h3>

  ![12 Point image](https://github.com/MoritzGrundei/cv-challenge/blob/main/img_poster/12_Point_Plot.png)

  - The 12 vertices of the 3D room are estimated using the 2D pixel coordinates of the vanishing point and the inner rectangle.
  - Four radial lines are drawn where each radial line starts at the vanishing point and intersects one of the vertices of the inner rectangle.
  - The intersections of the radial lines with the image borders on the top, right, left, and bottom yield the 12 coordinates of the room vertices described in the paper.
  - Step-by-Step:
    1. The slope and y-intercept are computed using the given coordinates of the inner rectangle and the vanishing point.
    2. Assuming that the height of the image is n and the width of the image is m, the corresponding coordinates of the intersections are calculated using the linear functions where:
        - The top left radial line intersects with x=1 and y=1.
        - The top right radial line intersects with x=n and y=1.
        - The bottom left radial line intersects with x=1 and y=m.
        - The bottom right radial line intersects with x=n and y=m.

<h3>Compute Room Dimensions</h3>

  - The room width and height are defined by the number of pixels in the background rectangle.
  - The Euclidean distances between the 12 points and the vanishing point are computed.
  - The z-coordinate of point 4 is defined as one to have a reference in the z-dimension.
  - The relative z-coordinates of points 2, 5, 6, and 10 are computed with the distance ratios and the reference of point 4:
    $$\displaystyle z_6 = \frac{\left \lVert v_{vp}-v_4 \right \rVert_2}{\left \lVert v_{vp}-v_6 \right \rVert_2} *z_4$$
  - The resulting relative z-coordinates are scaled based on the pixel number in the image and a constant factor to improve the quality in the 3D-plot while keeping a low runtime.

<h3>Foreground Positioning</h3>  
  
  - The rectangular frame of the foreground object defines its position in the 3D room.
    1. The wall where the foreground object is attached to is calculated. An object is assigned to a wall if the cross products of its corners with the vertices of a trapezoid are positive.
    2. The projective transformation function is used to calculate the 3D foreground rectangle points from the 2D coordinates.

<h3>Foreground Plotting</h3>

  - Each foreground object is iterated through individually.
  - The mask of the foreground image is used and the mask is made transparent.

<h3>3D Room Reconstruction</h3>

  - The five walls are defined from the 12 points, consisting of four trapezoidal shapes and one background rectangle.
  - The trapezoidal shapes are transformed into rectangles:
    1. The transformation matrix is calculated with fitgeotrans and the corresponding room dimensions of the image.
    2. The transformation is applied with the Image Processing Toolbox function imwarp.
  - Each wall is returned separately.
  - A 3D plot is created with the properties:
    1. The x and y plane define the background wall.
    2. The z dimension defines the depth of the plot.
  - The camera perspective and toolbar are defined to create a 3D view.
  - A 3D room tour is created by continuously updating the camera position, including the foreground position in the tour.

