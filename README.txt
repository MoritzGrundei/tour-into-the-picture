Tour-Into-The-Picture (TIP)
============================

Computer Vision Challenge SoSe 2024

Contributors: Martin Ausborn, Moritz Grundei, Kevin Hu, Thomas Schwarzfischer, Andreas Umlauf, Chien-Chun Wang

Implementation based on: Youichi Horry, Ken-Ichi Anjyo, and Kiyoshi Arai. Tour into the picture: using a spidery mesh interface to make animation from a single image. In Proceedings of the 24th annual conference on Computer graphics and interactive techniques, pages 225-232, 1997.

Goals
-----

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
-----------

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
    14. To control the camera, select "View" -> "Camera Toolbar."