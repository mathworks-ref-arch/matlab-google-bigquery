function startup(varargin)
%% STARTUP - Script to add my paths to MATLAB path
% This script will add the paths below the root directory into the MATLAB
% path. It will omit the SVN and other crud.  You may modify undesired path
% filter to your desire.

%                 (c) 2020 MathWorks, Inc. 
%% Adding folders to path
appStr = 'Adding MATLAB-GBQ-SDK Paths';
disp(appStr);
disp(repmat('-',1,numel(appStr)));

%% Set up the paths to be added to the MATLAB path
% This should be the only section of the code that you need to modify
% The second argument specifies whether the given directory should be
% scanned recursively
here = fileparts(mfilename('fullpath'));

rootDirs={fullfile(here,'app'),true;...
    fullfile(here,'lib'),false;...
    fullfile(here,'config'),false;...
    fullfile(here,'script'),true;...
    fullfile(here,'test'),true;...
    fullfile(here,'sys','modules'),true;...
    fullfile(here,'public'),true;...
    };

%% Add the framework to the path
iAddFilteredFolders(rootDirs);

%% Handle the modules for the project.
disp('Initializing all modules');
modRoot = fullfile(here,'sys','modules');

% Get a list of all modules
mList = dir(fullfile(modRoot,'*.'));
for mCount = 1:numel(mList)
    % Only add proper folders
    dName = mList(mCount).name;
    if ~strcmpi(dName(1),'.')
        % Valid Module name
        candidateStartup = fullfile(modRoot,dName,'startup.m');
        if exist(candidateStartup,'file')
            % We have a module with a startup
            run(candidateStartup);
        else
            % Create a cell and add it recursively to the path
            iAddFilteredFolders({fullfile(modRoot,dName), true});
        end
    end
    
end

%% Find if matlab-gcp-common package is accessible

% Change directory to GBQ project root under software MATLAB
cd(gbqroot)

% Get current folder path
f = fileparts(pwd);

% Constructing relative path to matlab-gcp-common
parts = strsplit(string(f),filesep);
parts_needed = parts(1:end-2);
top_dir = strjoin(parts_needed,filesep);

% matlab-gcp-common top level directory ../../../matlab-gcp-common
gcp_commons_dir = strcat(top_dir, filesep, 'matlab-gcp-common');

% Check if matlab-gcp-common directory exists in the same directory as
% matlab-google-bigquery
if exist(gcp_commons_dir,'dir')
    
    % Create jar path under Software/MATLAB/lib/jar for matlab-gcp-common
    path_to_gcp_jar = strcat(gcp_commons_dir, filesep, 'Software', filesep, 'MATLAB', filesep, 'lib', filesep, 'jar',filesep,'google-gcp-common-sdk-0.1.0.jar');
    
    % Look for jar on the path (i.e. is build process complete)
    if exist(path_to_gcp_jar,'file')
        
        % Get current java class path dynamic
        jpath = javaclasspath('-dynamic');
        
        % Check if jar already exists on path
        if ~any(strcmp(jpath,path_to_gcp_jar))
            
            % add jar to classpath
            javaaddpath(path_to_gcp_jar)
            
            disp(strcat("google-gcp-common-sdk-0.1.0.jar was not on path. Adding ",string(path_to_gcp_jar)," to the path"));
        else
            % jar already on class path
            disp('google-gcp-common-sdk-0.1.0.jar library exists in path.');
        end
        
    else
        % jar does not exist
        disp(strcat(string(path_to_gcp_jar), " cannot be found."," Consider building the jar using maven and the pom.xml file within matlab-gcp-common\Software\Java"));
       
    end
    
else
    disp('matlab-gcp-common does not exist at the same directory level as matlab-google-bigquery. Please refer Documentation\Installation.md for instructions regarding package installation and directory structure.');
end


end

%% iAddFilteredFolders Helper function to add all folders to the path
function iAddFilteredFolders(rootDirs)
% Loop through the paths and add the necessary subfolders to the MATLAB path
for pCount = 1:size(rootDirs,1)
    
    rootDir=rootDirs{pCount,1};
    if rootDirs{pCount,2}
        % recursively add all paths
        rawPath=genpath(rootDir);
        
        if ~isempty(rawPath)
            rawPathCell=textscan(rawPath,'%s','delimiter',pathsep);
            rawPathCell=rawPathCell{1};
        else
            rawPathCell = {rootDir};
        end
        
    else
        % Add only that particular directory
        rawPath = rootDir;
        rawPathCell = {rawPath};
    end
    
    % remove undesired paths
    svnFilteredPath=strfind(rawPathCell,'.svn');
    gitFilteredPath=strfind(rawPathCell,'.git');
    slprjFilteredPath=strfind(rawPathCell,'slprj');
    sfprjFilteredPath=strfind(rawPathCell,'sfprj');
    rtwFilteredPath=strfind(rawPathCell,'_ert_rtw');
    
    % loop through path and remove all the .svn entries
    if ~isempty(svnFilteredPath)
        for pCount=1:length(svnFilteredPath) %#ok<FXSET>
            filterCheck=[svnFilteredPath{pCount},...
                gitFilteredPath{pCount},...
                slprjFilteredPath{pCount},...
                sfprjFilteredPath{pCount},...
                rtwFilteredPath{pCount}];
            if isempty(filterCheck)
                iSafeAddToPath(rawPathCell{pCount});
            else
                % ignore
            end
        end
    else
        iSafeAddToPath(rawPathCell{pCount});
    end
    
end

end

%% Helper function to add to MATLAB path.
function iSafeAddToPath(pathStr)

% Add to path if the file exists
if exist(pathStr,'dir')
    disp(['Adding ',pathStr]);
    addpath(pathStr);
else
    disp(['Skipping ',pathStr]);
end

end

