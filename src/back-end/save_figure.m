function save_figure(hfig, imageFileName)
% SAVE_FIGURE saves the 3D room as a .fig file; create the output folder if necessary

% Extract image name from file path
[~, imageName, ~] = fileparts(imageFileName);

% Get the directory of the main.m script
mainFilePath = which('main');
if isempty(mainFilePath)
    error('Cannot find main.m file.');
end
mainFolder = fileparts(mainFilePath);

% Define the output folder name
outputFolder = 'output';

% Construct the directory path using fullfile
outputDir = fullfile(mainFolder, outputFolder);

% Check if the directory exists, and create it if it does not
if ~exist(outputDir, 'dir')
    mkdir(outputDir);
end

% Initialize the counter for file name uniqueness
counter = 1;

% Construct the initial file path using fullfile
saveFilename = fullfile(outputDir, [imageName, '3Dplot', sprintf('%03d', counter), '.fig']);

% Loop to ensure the filename is unique
while exist(saveFilename, 'file')
    counter = counter + 1;
    saveFilename = fullfile(outputDir, [imageName, '3Dplot', sprintf('%03d', counter), '.fig']);
end

% Save the figure to a .fig file
savefig(hfig, saveFilename);

end
