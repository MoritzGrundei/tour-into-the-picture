function [threeD_points] = get_threeD_points(roomVertices,vanishingPoint)
    %initialisations
    threeD_points = [roomVertices,zeros(12,1)];
    vp_coords = [vanishingPoint(2), vanishingPoint(1)];
    distances = zeros(12,1);
    %compute distances of the 12 points to the vanishing point
    for i = 1:12
        distances(i) = norm(vp_coords'-roomVertices(i,:)');
    end
    %set z coordinate of point 4 to one to get the others in relation for
    %the others
    threeD_points(4,3) = 1;
    %compute relative z coordinates of all other points
    threeD_points(6,3) = distances(4)/distances(6);
    threeD_points(2,3) = distances(4)/distances(2);
    threeD_points(1,3) = threeD_points(2,3);
    threeD_points(7,3) = threeD_points(2,3);
    threeD_points(8,3) = threeD_points(2,3);
    threeD_points(3,3) = (distances(1)/distances(3)) * threeD_points(2,3);
    threeD_points(5,3) = (distances(1)/distances(5)) * threeD_points(2,3);
    threeD_points(9,3) = (distances(7)/distances(9)) * threeD_points(2,3);
    threeD_points(11,3) = (distances(7)/distances(11)) * threeD_points(2,3);
    threeD_points(10,3) = (distances(8)/distances(10)) * threeD_points(2,3);
    threeD_points(12,3) = (distances(8)/distances(12)) * threeD_points(2,3);

    %adjust x and y coordinate
    threeD_points(:,[1,2]) = (threeD_points(:,[1,2])-vp_coords).*threeD_points(:,3);
end