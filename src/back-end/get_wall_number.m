function wallNumber = get_wall_number(twelvePoints, rect)
%GET_WALL_NUMBER Calculates which wall a foreground object should be attached to
% Checks, whether there are at least 2 corners of the foreground rectangle
% within the corresponding wall trapezoid 
% (i.e. an object on the floor needs its two bottom corners to be
% within the trapezoid of the floor wall; if this only applies for one
% corner, the object will be assigned to left or right wall respectively).
%
% Output: 1 floor, 2 left, 3 right, 4 ceiling, 5 rear (default case)

if(isLineInTrapezoid(rect(4, :), rect(3, :), ...
        twelvePoints(1, :), twelvePoints(2, :), twelvePoints(4, :), twelvePoints(3, :)))
    wallNumber = 1; % bottom
elseif(isLineInTrapezoid(rect(1, :), rect(4, :), ...
        twelvePoints(11, :), twelvePoints(7, :), twelvePoints(1, :), twelvePoints(5, :)))
    wallNumber = 2; % left
elseif(isLineInTrapezoid(rect(2, :), rect(3, :), ...
        twelvePoints(8, :), twelvePoints(12, :), twelvePoints(6, :), twelvePoints(2, :)))
    wallNumber = 3; % right
elseif(isLineInTrapezoid(rect(1, :), rect(2, :), ...
        twelvePoints(9, :), twelvePoints(10, :), twelvePoints(8, :), twelvePoints(7, :)))
    wallNumber = 4; % ceiling
else
    wallNumber = 5; % rear
end
end

function isInside = isLineInTrapezoid(P1, P2, TL, TR, BR, BL)
% Check whether the line specified by P1, P2 (aka both points) lies within 
% a polygon specified by the corners TL, TR, BR, BL

% Check point P against each edge of the trapezoid
isInside = is_right_of_edge(TL, TR, P1) && ...
           is_right_of_edge(TR, BR, P1) && ...
           is_right_of_edge(BR, BL, P1) && ...
           is_right_of_edge(BL, TL, P1) && ...
           is_right_of_edge(TL, TR, P2) && ...
           is_right_of_edge(TR, BR, P2) && ...
           is_right_of_edge(BR, BL, P2) && ...
           is_right_of_edge(BL, TL, P2);
end

function result = is_right_of_edge(edgeStart, edgeEnd, point)
%IS_RIGHT_OF_EDGE checks if point is to the right of a directed edge with
% a cross product method
% output: boolean
edgeVector = edgeEnd - edgeStart;
pointVector = point - edgeStart;
crossProd = edgeVector(1) * pointVector(2) - edgeVector(2) * pointVector(1);
result = crossProd > 0;
end