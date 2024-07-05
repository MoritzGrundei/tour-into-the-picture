% Create a 10x10 grid for the surface
[X, Y] = meshgrid(1:10, 1:10);
Z = zeros(size(X));  % Flat surface at Z = 0

% Create a texture image (e.g., a gradient)
textureImage = uint8(repmat(linspace(255, 255, 10), 10, 1));

% Create an alpha mask with different transparency values
alphaMask = linspace(0, 1, 10);  % Gradient alpha values from 0 (transparent) to 1 (opaque)
alphaMask = repmat(alphaMask, 10, 1);  % Repeat the gradient for each row

% Create a figure with a 3D plot
f = figure;
hSurf = surf(X, Y, Z);  % Create the surface plot
colormap gray;  % Set colormap to grayscale
shading interp;  % Interpolate shading for smooth appearance
axis equal;  % Make axes aspect ratio equal
axis vis3d;  % Freeze aspect ratio for better panning/rotation
colorbar;  % Show colorbar

% Enable 3D rotation and panning
rotate3d on;

% Apply the texture and alpha mask to the surface
hSurf.FaceColor = 'texturemap';
hSurf.EdgeColor = 'none';
hSurf.CData = textureImage;  % Apply the texture image
hSurf.FaceAlpha = 'texturemap';
hSurf.AlphaData = alphaMask;  % Apply the alpha mask

% Set axis labels and title
xlabel('X-axis');
ylabel('Y-axis');
zlabel('Z-axis');
title('10x10 Surface with Textured Transparency');

cameratoolbar(f);


% Ensure the plot is interactive
grid on;  % Show grid for better reference
view(3);  % Set the default 3D view
