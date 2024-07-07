function save_figure(hfig, imageFileName)
%SAVE_FIGURE saves the 3d room as a .fig file; create the output folder if
% necessary

% Extract image name from file path
[~, imageName, ~] = fileparts(imageFileName);

mfolder = fileparts(which(mfilename));
% Split the path into its components
pathComponents = split(mfolder, filesep);

mainFolder = fullfile(pathComponents{1:length(pathComponents)-2});

% Create 'output' directory if it doesn't exist
if ~exist([mainFolder, '/output'], 'dir')
    mkdir([mainFolder, '/output']);
end

% Check for existing files and update the filename accordingly
counter = 1;
saveFilename = [mainFolder, '/output/', imageName, '_3Dplot_', sprintf('%03d', counter), '.fig'];
while exist(saveFilename, 'file')
    % Update the filename with the counter
    saveFilename = [mainFolder, '/output/', imageName, '_3Dplot_', sprintf('%03d', counter), '.fig'];
    counter = counter + 1;
end

% Save the figure to a .fig file
savefig(hfig, saveFilename);

end