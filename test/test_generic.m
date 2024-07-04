% Function to check if point is to the left of a directed edge (cross product method)
    function result = is_right_of_edge(edgeStart, edgeEnd, point)
        edgeVector = edgeEnd - edgeStart;
        pointVector = point - edgeStart;
        crossProd = edgeVector(1) * pointVector(2) - edgeVector(2) * pointVector(1);
        result = crossProd < 0
    end




    is_right_of_edge([0,0], [10,10], [4.9, 5])