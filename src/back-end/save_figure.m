function save_figure(hfig, imageFileName)
%SAVE_FIGURE saves the 3d room as a .fig file; create the output folder if
% necessary

% Extract image name from file path
[~, imageName, ~] = fileparts(imageFileName);

mfolder = fileparts(which(mfilename));
% Split the path into its components
pathComponents = split(mfolder, filesep);

mainFolder = fullfile(pathComponents{1:length(pathComponents)-2});
outputFolder = 'output';

% Construct the directory path using fullfile
outputDir = fullfile(mainFolder, outputFolder);

% Check if the directory exists, and create it if it does not
if ~exist(outputDir, 'dir')
    mkdir(outputDir);
end

% Check for existing files and update the filename accordingly
counter = 1;
%saveFilename = ['/', mainFolder, '/output/', imageName, '_3Dplot_', sprintf('%03d', counter), '.fig'];
saveFilename = fullfile(outputDir, [imageName, '_3Dplot_', sprintf('%03d', counter), '.fig']);

while exist(saveFilename, 'file')
    % Update the filename with the counter
    saveFilename = fullfile(outputDir, [imageName, '_3Dplot_', sprintf('%03d', counter), '.fig']);
    counter = counter + 1;
end

% Save the figure to a .fig file
savefig(hfig, saveFilename);

end