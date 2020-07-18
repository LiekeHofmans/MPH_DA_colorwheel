% Dual-coded map (contrast estimates and t-statistics) overlaid on an anatomical image

clear; clc;

% Define directories
% -------------------------------------------------------------------------
if ispc
    projectDir = 'P:\3017048.01';
    addpath H:\common\matlab\spm12
elseif isunix
    projectDir = '/project/3017048.01';
    addpath /home/common/matlab/spm12
else
    error('Unknown OS')
end

% Slice display and panel code directory
sd_dir      = fullfile(projectDir,'code','analysis','slice_display');
panel_dir   = fullfile(sd_dir,'panel');

% Data directory with PET-CW correlation results
data_dir    = fullfile(projectDir,'bids','derivatives','beh','color_wheel','pet');

% Statistics settings to plot
% -------------------------------------------------------------------------
p_thresh = 0.001;
fwe      = true;
if fwe
   p_thresh = 0.05; 
end

% Which effect to plot (Ki effects on PBO, drug x Ki effects and effects 
% which were significant in ROI analysis)
% -------------------------------------------------------------------------

% ratio redo
todo.ratioRedo_PBO                              = true;
todo.MPH_effect_on_ratioRedo                    = false;
todo.SUL_effect_on_ratioRedo                    = false;
todo.MPH_vs_SUL_effect_on_ratioRedo             = false;

% IP
% todo.IP_PBO                                     = false;
todo.MPH_effect_on_IP                           = false;
todo.SUL_effect_on_IP                           = false;
todo.MPH_vs_SUL_effect_on_IP                    = false;

% RT choice
todo.RTchoice_PBO                               = false;
todo.MPH_effect_on_RTchoice                     = false;
todo.SUL_effect_on_RTchoice                     = false;
todo.MPH_vs_SUL_effect_on_RTchoice              = false;




%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Make sure directory containing slice display functions is on path
addpath(genpath(sd_dir));


% Get custom colormaps
load(fullfile(sd_dir,'colormaps.mat'));

% Loop over contrasts to plot
cons = fieldnames(todo);

for icon = 1:numel(cons)
    
    
    contrast = cons{icon};
    
    if todo.(contrast)
     
   
        % Define contrast data directory
        con_dir = fullfile(data_dir,contrast);
        
        
        % Add escape character in contrast name to prevent part of it
        % becoming subscript in figure title and legend
        contitle = strrep(contrast, '_', '\_');

        % Step 1: Initialize empty layers and settings variables
        % -----------------------------------------------------------------
        layers                              = sd_config_layers('init',{'truecolor','dual','contour'});
        settings                            = sd_config_settings('init');

        % Step 2: Define layers
        % -----------------------------------------------------------------

        % Layer 1: Anatomical map
        layers(1).color.file                = fullfile(spm('Dir'),'canonical','single_subj_T1.nii');
        layers(1).color.map                 = gray(256);

        % Layer 2: Dual-coded layer (contrast estimates color-coded; 
        % t-statistics opacity-coded)
        layers(2).color.file                = fullfile(con_dir,'con_0001.nii');
        layers(2).color.map                 = CyBuGyRdYl;
        layers(2).color.label               = '\bf \beta';
        layers(2).opacity.file              = fullfile(con_dir,'spmT_0001.nii');
        layers(2).opacity.label             = '| t |';
%         layers(2).opacity.range             = [0 3.286]; % 46 subjects 
        layers(2).opacity.range             = [0 4.23]; % 46 subjects SVC FWEp
        
        % Additional range setting for color map to fix/match them 
        % (make narrower when beta values are relatively small)
        layers(2).color.range               = [-0.0069 0.0069]; 

        % Layer 3: Contour of significantly activated voxels
        p = regexp(num2str(p_thresh), '\.', 'split');
        p = p{2};
        if fwe
            layers(3).color.file            = fullfile(con_dir,sprintf('sigClust_p%s_fwe_corrected_binary.nii',p));
        else
            layers(3).color.file            = fullfile(con_dir,sprintf('combPosNeg_sigClust_p%s_uncorrected_binary.nii',p));
        end
        layers(3).color.map                 = [1,1,1]; % line color
        layers(3).color.line_width          = 1; % line thickness
        % Check if the saved significant cluster file exists
        if ~exist(layers(3).color.file, 'file')
            warning('The file %s does not exist. Skipping contrast %s.',layers(3).color.file,contrast)
            continue
        end

        % Specify settings
        settings.slice.orientation          = 'axial';
%         settings.slice.disp_slices          = -18:6:12;
        settings.slice.disp_slices          = -16:6:2;
        settings.fig_specs.n.slice_column   = 2;
%         settings.fig_specs.title            = contitle;

        % Figure size
        settings.fig_specs.width.figure     = 180;
        
        % Display the layers
        [settings,p_ax] = sd_display(layers,settings);
        
        settings.slice.orientation          = 'sagittal';
        settings.slice.disp_slices          = -26:4:-12;
%         [settings,p_sag] = sd_display(layers,settings);
        
        settings.slice.orientation          = 'coronal';
        settings.slice.disp_slices          = -10:4:2;
%         [settings,p_cor] = sd_display(layers,settings);


        % Create figure dir if it doesn't exist
        if ~exist(fullfile(data_dir,'1_figures_dual_coding', 'bitmap'),'dir')
            mkdir(fullfile(data_dir,'1_figures_dual_coding', 'bitmap'));
        end
        if ~exist(fullfile(data_dir,'1_figures_dual_coding_fwe_corrected', 'bitmap'),'dir')
            mkdir(fullfile(data_dir,'1_figures_dual_coding_fwe_corrected', 'bitmap'));
        end
        if ~exist(fullfile(data_dir,'1_figures_dual_coding', 'tiff'),'dir')
            mkdir(fullfile(data_dir,'1_figures_dual_coding', 'tiff'));
        end
        if ~exist(fullfile(data_dir,'1_figures_dual_coding_fwe_corrected', 'tiff'),'dir')
            mkdir(fullfile(data_dir,'1_figures_dual_coding_fwe_corrected', 'tiff'));
        end

        % save figure as png
        set(gcf,'color','w');
        fig = gcf;
        fig.InvertHardcopy = 'off'; % make sure text is not removed with background. 
        if fwe
            print(fullfile(data_dir,'1_figures_dual_coding_fwe_corrected', 'bitmap', contrast),'-dpng','-r300');
        else
            print(fullfile(data_dir,'1_figures_dual_coding', 'bitmap', contrast),'-dpng','-r300');
        end 
        
        % save figure as tiff
        set(gcf,'color','w');
        fig = gcf;
        fig.InvertHardcopy = 'off'; % make sure text is not removed with background. 
        if fwe
            print(fullfile(data_dir,'1_figures_dual_coding_fwe_corrected', 'tiff', contrast),'-dsvg','-r1000');
        else
            print(fullfile(data_dir,'1_figures_dual_coding', 'tiff', contrast),'-dsvg','-r1000');
        end 
        
    end
    

end