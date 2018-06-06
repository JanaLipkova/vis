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


addpath('../lib/vi')

patientsList = [1, 2, 3, 4, 5, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 19, 20];

for pID = patientsList
    
    sprintf('Processing case %s \n', num2str(pID))
    
    vis.InputFolder  = ['../../../data/apt',num2str(pID,'%03d'),'/Registered/'];
    vis.OutputFolder = [vis.InputFolder,'Visualisation/'];
    
    vis.Modalities = {'MPR_KM_res.nii.gz','MPR_reg.nii.gz','FLAIR_reg.nii.gz', 'T2_reg.nii.gz', ...
        'FET_reg.nii.gz', 'APT_reg.nii.gz', 'MD_reg.nii.gz', 'MD_fwe_reg.nii.gz', ...
        'FA_reg.nii.gz', 'FA_fwe_reg.nii.gz', 'TissueVolume_reg.nii.gz', 'B0_reg.nii.gz', ...
        'nCBV_reg.nii.gz', 'PWI_reg.nii.gz','seg.nii.gz'};
    
    vis.Colormap   = {'gray', 'gray', 'gray', 'gray', ...
        'hot',  'jet',  'jet',  'jet',  ...
        'jet',  'jet',  'jet', 'jet', ...
        'jet',  'jet', 'jet'  };
    
    vis.nCols      = 4;
    vis.nRows      = 4;
    
    vis.bPositive  = 1; % keep only positive values
    vis.NameCutBy  = 4;
    
    
    
    % NEED TO BE SCALED FOR GIVEN DISPLAY
    vis.FigPosition = [0.1,0.1,0.4,0.89]; % 24''
    
    
    % Load segmentation, select nSlices uniformly spaced across tumour to be visualised
    nSlices = 3;
    segm = MRIread([vis.InputFolder,'seg.nii.gz']);
    ind = find(segm.vol);
    [i1, i2, i3] = ind2sub(size(segm.vol), ind);  % indecies of non-zero elements in each dimension
    
    step = floor((i3(end) - i3(1)) / (nSlices + 1));
    
    for i = 1:nSlices
        vis.Slide = i3(1) - 1 + i * step;
        vis.OutputName   = ['apt',num2str(pID,'%03d'),'_slide_',num2str(vis.Slide)];
        visualise_multimodal_data(vis)
    end;
    
    close all
    
end;