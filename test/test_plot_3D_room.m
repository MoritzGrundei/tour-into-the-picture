%% 3D plot of image
% run this script to generate 3D plot of a test image, Points are manually
% implemented and later on received by gen12Points function


% assign 2D parameters, later calculated
roomDepth = 500;
roomHeight = 500;
roomWidth = 100;


% manually assign Points 
Points = zeros(12, 2);

Points(1, :) = [290, 412];
Points(2, :) = [570, 412];
Points(3, :) = [1, 620];
Points(4, :) = [848, 620];
Points(5, :) = [1, 620];
Points(6, :) = [848, 620];
Points(7, :) = [290, 206];
Points(8, :) = [570, 206];
Points(9, :) = [0, 0];
Points(10, :) = [848, 0];
Points(11, :) = [0, 0];
Points(12, :) = [848, 0];

% insert image 
input_image = imread('static/images/simple-room.png');

% add a foreground object
fg_points = [
    350,460; %TR
    495,460; %TL
    300,590; %BR
    540,590; %BL
    ];

% transformation usually not necessary
foreground_object = projective_transformation(input_image, fg_points(1, :), fg_points(2, :), fg_points(3, :), fg_points(4, :), 150, 100);

fg_points = [
    350,460; %TR
    495,460; %TL
    540,590; %BL
    300,590; %BR
    ];

fg_points = [
    300,420; %TR
    550,420; %TL
    600,650; %BL
    250,650; %BR
    ];

inpaintedImage = retouch_background(input_image, fg_points);


fg_points = [

    495,460; %TL
    350,460; %TR
    300,590; %BR
    540,590; %BL
    ];

fg_points = [

    495,460; %TL
    800,460; %TR
    800,400; %BR
    540,400; %BL
    ];

%wallnumber = get_wall_number(Points, fg_points);
% function that generates 3D plot with given dummy data



            roomDepth = 500;
            roomHeight = 400;
            roomWidth = 500;

            % cut foreground objects (+retouching)
            

            % redefine 12 points for perspective

            % calculate each wall perspective
            % init array 
            tform = cell(5);
            walls = cell(5);
            % floor cell{1}
            % left wall  cell{2}
            % right wall cell{3}
            % ceiling cell{4}
            % rear wall cell{5}

            [walls{1}, tform{1}] = projective_transformation(input_image,Points(1, :),Points(2, :),Points(3, :),Points(4, :),roomWidth,roomDepth);
            [walls{2}, tform{2}] = projective_transformation(input_image,Points(11, :),Points(7, :),Points(5, :),Points(1, :),roomDepth,roomHeight);
            [walls{3}, tform{3}] = projective_transformation(input_image,Points(8, :),Points(12, :),Points(2, :),Points(6, :),roomDepth,roomHeight);
            [walls{4}, tform{4}] = projective_transformation(input_image,Points(9, :),Points(10, :),Points(7, :),Points(8, :),roomWidth,roomDepth);
            [walls{5}, tform{5}] = projective_transformation(input_image,Points(7, :),Points(8, :),Points(1, :),Points(2, :),roomWidth,roomHeight);
            
            % construct room
            plot_3D_room(walls);
            

% rectangle for couch
rectangle = [
    350,460; %TL
    495,460; %TR
    540,590; %BR
    300,590; %BL
    ];

rectangle = [
    150,300; %TL
    300,300; %TR
    300,400; %BR
    150,400; %BL
    ];


polygon = [
    350,460; %TL
    495,460; %TR
    540,590; %BR
    300,590; %BL
    250,500; %ML
    ];

% add foreground objects
plot_foreground_object(Points, 1, rectangle, 1, tform, walls, foreground_object)



% add to plot

%plot_foreground_object(foreground_object, 150, 50, 0, 200, 100);