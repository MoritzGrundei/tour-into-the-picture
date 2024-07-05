function [ceilingDepth, floorDepth, rightWallDepth, leftWallDepth, roomHeight, roomWidth] = get_room_dimensions(input_image, roomVertices,vanishingPoint)
    [image_height, image_width, ~] = size(input_image);
    roomWidth = ceil(roomVertices(2,2)-roomVertices(1,2));
    roomHeight = ceil(roomVertices(1,1)-roomVertices(7,1));
    ref=0;
    side=0;
    % links
    if roomVertices(1,2)>ref
        ref=roomVertices(1,2);
        side=5;
    end
    % rechts
    if image_width-roomVertices(2,2)>ref
        ref=image_width-roomVertices(2,2);
        side=6;
    end
    % unten
    if image_height-roomVertices(1,1)>ref
        ref=image_height-roomVertices(1,1);
        side=4;
    end
    %oben
    if roomVertices(7,1)>ref
        ref=roomVertices(7,1);
        side=10;
    end
    
    %initialisations
    threeD_points = [roomVertices,zeros(12,1)];
    vp_coords = [vanishingPoint(2), vanishingPoint(1)];
    distances = zeros(12,1);
    %compute distances of the 12 points to the vanishing point
    for i = 1:12
        distances(i) = norm(vp_coords'-roomVertices(i,:)');
    end
    %set z coordinate of point 4 to one to get the others in relation
    threeD_points(4,3) = 1;
    %compute relative z coordinates of necessary other points
    threeD_points(6,3) = distances(4)/distances(6);
    threeD_points(2,3) = distances(4)/distances(2);
    threeD_points(5,3) = (distances(1)/distances(5)) * threeD_points(2,3);
    threeD_points(10,3) = (distances(8)/distances(10)) * threeD_points(2,3);
    
    scale = ref/(threeD_points(2,3)-threeD_points(side,3));

    leftWallDepth = ceil((threeD_points(2,3)-threeD_points(5,3))*scale);
    rightWallDepth = ceil((threeD_points(2,3)-threeD_points(6,3))*scale);
    floorDepth = ceil((threeD_points(2,3)-threeD_points(4,3))*scale);
    ceilingDepth= ceil((threeD_points(2,3)-threeD_points(10,3))*scale);
    
    
end