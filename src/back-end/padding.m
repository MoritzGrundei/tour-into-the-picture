function [padded_image,roomVectrices_with_padding] = padding(image,roomVectrices)
    %input: image and coordinates of 12 Points

    %compute the size of the image
    [m, n] = size(image);

    %initialize dif
    dif=0;
    %compute the biggest negative value
    for i=1:length(roomVectrices)
        for k=1:2
            if(-roomVectrices{i}(k)>dif && roomVectrices{i}(k)<0)
                dif = -roomVectrices{i}(k);
            end
        end
    end
    
    %pad with a border with with dif in to eliminate negative values of
    %roomVectricies
    padded_image = zeros(m+2*dif,n+2*dif,3);
    padded_image((dif+1):(end-dif),(dif+1):(end-dif),:) = image;

    %compute updated values for the roomVectices of the padded image
    roomVectrices_with_padding = cell(1,12);
    
    for i=1:length(roomVectrices)
        roomVectrices_with_padding{i} = roomVectrices{i} + [dif,dif];
    end

end

