function [roomVertices] = get12Points(image, vanishingPoint, backgroundRectangle)
    % input:
    % vp_coords: coordinates of the vanishing point
    % ir_coords: coordinates of the vertices of the inner rectangle
    %            bottom left (1), bottom right (2), top left
    %            (3), top right (4)
    % image: 2D image
    %
    % output: 
    % roomVertices: 2D coordinates of the 12 vertices
    %     

    % extract size of the image: 
    % n = width, number of columns 
    % m = height, number of rows
    [m, n, ~] = size(image);

    ir_coords = zeros(4, 2);
    ir_coords(1, :) = [backgroundRectangle(4, 2), backgroundRectangle(4, 1)];
    ir_coords(2, :) = [backgroundRectangle(3, 2), backgroundRectangle(3, 1)];
    ir_coords(3, :) = [backgroundRectangle(1, 2), backgroundRectangle(1, 1)];
    ir_coords(4, :) = [backgroundRectangle(2, 2), backgroundRectangle(2, 1)];

    vp_coords = [vanishingPoint(2), vanishingPoint(1)];

    roomVertices = zeros(12, 2);

    % load coordinates of vertices we already know
    roomVertices(1, :) = ir_coords(1, :); % vertix 1
    roomVertices(2, :) = ir_coords(2, :); % vertix 2
    roomVertices(7, :) = ir_coords(3, :); % vertix 7
    roomVertices(8, :) = ir_coords(4, :); % vertix 8

    % define borders
    borders = cell(1, 4);
    borders{1} = [m, 1];
    borders{2} = [m, n];
    borders{3} = [1, 1];
    borders{4} = [1, n];

    for i = 1:4
        % Note:
        % bottom left radial line will intersect with x = 1 or y = m
        % bottom right radial line will intersect with x = n or y = m
        % top left radial line will intersect with x = 1 or y = 1
        % top right radial line will intersect with x = n or y = 1
        if mod(i, 2) ~= 0
            [a, b] = lineEquation(ir_coords(i, :), vp_coords);
        else
            [a, b] = lineEquation(vp_coords, ir_coords(i, :));
        end

        y = a * borders{i}(2) + b;
        x = (borders{i}(1) - b) / a;

        if mod(i, 2) ~= 0
            roomVertices(3*i, :) = [borders{i}(1), x];
            roomVertices(3*i + 2, :) = [y, borders{i}(2)];
        else
            roomVertices(3*i, :) = [y, borders{i}(2)];
            roomVertices(3*i - 2, :) = [borders{i}(1), x];
        end
    end

end

function [m, b] = lineEquation(P1, P2)
    m = (P2(1) - P1(1)) /(P2(2) - P1(2)); % slope
    b = P1(1) - m * P1(2); % y-intercept
end