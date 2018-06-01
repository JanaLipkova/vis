%=======================================
%
% Visualise multimodal medical data
%
% @author: Jana Lipkova
% Created on 01.06.2018
%
%---------------------------------------
% 
% InputFolder = folder with the input modalities (assume all modalities are in the folder)
% OuputFolder = folder where the final visualisaiton will be stored
% OutputName  = name of the output image that will be stored in the OutputFolder
% Modalities  = list of file names of modalities that shoule be visualised
% Colormap    = color map to be used for each modality (order same as in Modalities) (see matlab colormap options)
% nCols       = number of columns of the final image
% nRows       = number of rows in the final image
% Slide       = slide of the data to be visualised
% bPositive   = set negative values to zero if 1, else nothing
% NameCutBy = use to cut not needed subscritps from modality name like _reg
% FifPosition = figure scaling and positioning on screen, - set w.r. to
% final image, i.e.  [0.1,0.1,0.4,0.95] ir [0.1,0.1,0.4,0.4]
%=======================================


vis.InputFolder  = '../testdata/P01/';
vis.OutputFolder = [vis.InputFolder,'Visualisation/'];

vis.Modalities = {'T1c.nii.gz',   'FLAIR.nii.gz', 'PET.nii.gz', ...
                  'T1c.nii.gz',   'FLAIR.nii.gz', 'PET.nii.gz', ...
                  'T1c.nii.gz',   'FLAIR.nii.gz', 'PET.nii.gz', ...
    };


vis.Colormap   = {'gray',    'bone',    'hot', ...
                  'parula',  'spring',  'summer', ...
                  'winter',  'copper', 'pink'  };

vis.nCols      = 3;
vis.nRows      = 3;


vis.bPositive  = 1; % keep only positive values  
vis.Slide      = 78; 
vis.OutputName   = ['slide_',num2str(vis.Slide)];
vis.NameCutBy  = 0;

vis.FigPosition = [0.1,0.1,0.4,0.89];


visualise_multimodal_data(vis)

