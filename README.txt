Tour-Into-The-Picture (TIP)
===========================

Computer Vision Challenge SoSe 2024

Contributors: Martin Ausborn, Moritz Grundei, Kevin Hu, Thomas Schwarzfischer, Andreas Umlauf, Chien-Chun Wang

Implementation based on: Youichi Horry, Ken-Ichi Anjyo, and Kiyoshi Arai. Tour into the picture: using a spidery mesh interface to make animation from a single image. In Proceedings of the 24th annual conference on Computer graphics and interactive techniques, pages 225-232, 1997.

Demo
====

Goals
=====

- Create a Graphical User Interface which enables:
  - Selecting a 2D image from the device
  - Defining the vanishing point and inner rectangle
  - Changing the perspective of the room
- Reconstruct a 3D image from a single 2D image
- The algorithm should:
  - Handle different image sizes
  - Handle images where the planes are not clearly defined
  - Handle images without a clear vanishing point
  - Handle unknown images (test images)

How to use?
===========

- **Software requirements**:
  - MATLAB R2024a
  - MATLAB Toolboxes:
    - Computer Vision Toolbox
    - Image Processing Toolbox
    - Statistics and Machine Learning Toolbox
- **Step-by-Step manual**:
  1. Clone the repository onto your local machine.
  2. Open the project in MATLAB.
  3. Run main.m.
  4. Select the image of the 2D room that should be reconstructed by clicking on "Upload new image."
     - If the selection is successful, the light of "Upload an image" will turn green.
  5. Select the vanishing point of the image by clicking on the "Select vanishing point" button and clicking on the image where the vanishing point should be.
     - The light next to "Select the vanishing point" will turn green if the selection is successful.
  6. Select the background rectangle by pressing the "Select Background Rectangle" button and manually drawing the rectangle onto the image.
     - The light for "Select the background rectangle" will turn green afterwards.
  7. The radial lines through the vanishing points and the vertices of the inner rectangle are displayed. The vanishing point and the inner rectangle can still be adjusted.
  8. (Optional) If there are foreground objects in the image, you can press "Optional: Select Foreground Rectangle" to draw a polygon around the object or multiple polygons around objects.
     - Enable "Foreground Segmentation" if the selection of the object is not well defined.
  9. Once the configuration is done, press "Start 3D Tour" to start.
  10. You can always reset the configuration by pressing "Reset" to repeat steps 4 - 8.
  11. After a successful 3D reconstruction, a window with the tour into the reconstructed room will open.
  12. After the video, you may move the camera to move freely in the room by going forward/backward, to the right/left, or rotating the room.
  13. The figure is saved automatically into the output folder. To reopen it, double-click in MATLAB.
  14. To control the camera, select "View" -> "Camera."

Workflow
========

Detailed Data Processing Flow
=============================

User Interaction
----------------

- The vanishing point and the background rectangle are selected by the user.
- The vanishing lines are aligned with the edges of the scene.
- A polygon is drawn around each foreground object. If only a rough selection is made, segmentation is switched on.

Foreground Object Segmentation
------------------------------

- The foreground polygon is fitted into a rectangle.
- Foreground/background segmentation is computed using grabcut on superpixels.

12-Points Estimation
--------------------

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

Compute Room Dimensions
-----------------------

- The room width and height are defined by the number of pixels in the background rectangle.
- The Euclidean distances between the 12 points and the vanishing point are computed.
- The z-coordinate of point 4 is defined as one to have a reference in the z-dimension.
- The relative z-coordinates of points 2, 5, 6, and 10 are computed with the distance ratios and the reference of point 4:
  \(z_6 = \frac{\left \lVert v_{vp}-v_4 \right \rVert_2}{\left \lVert v_{vp}-v_6 \right \rVert_2} *z_4\)
- The resulting relative z-coordinates are scaled based on the pixel number in the image and a constant factor to improve the quality in the 3D-plot while keeping a low runtime.

Foreground Positioning
----------------------

- The rectangular frame of the foreground object defines its position in the 3D room.
  1. The wall where the foreground object is attached to is calculated. An object is assigned to a wall if the cross products of its corners with the vertices of a trapezoid are positive.
  2. The projective transformation function is used to calculate the 3D foreground rectangle points from the 2D coordinates.

Foreground Plotting
-------------------

- Each foreground object is iterated through individually.
- The mask of the foreground image is used and the mask is made transparent.

3D Room Reconstruction
----------------------

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