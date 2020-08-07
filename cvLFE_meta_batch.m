function cvLFE_meta_batch(stud_dir, subj_file, MS_file, fam_vec, fam_nam)
% _
% cvLFE meta batch for analysis of the FADE data set
%     stud_dir  - study directory in data/analyses are located
%     subj_file - an XLS file containing subject IDs and covariates
%     MS_file   - a  MAT file containg model space name and GLM names
%     fam_vec   - a 1 x M vector defining family affiliation
%     fam_nam   - a 1 x F cell array defining family names
% 
% written by Joram Soch <Joram.Soch@DZNE.de>, 03/02/2020, 08:01;
% edited for upload: 06/08/2020, 13:59


% list of subjects
[num, txt, raw] = xlsread(subj_file);
subj_ids = raw(2:end,1);
load(MS_file);
clear num txt

% study dimensions
stat_dir = strcat(stud_dir,'cvLME_maps/');
num_subj = numel(subj_ids);
num_mods = numel(GLM_names);
num_fams = numel(fam_nam);
fprintf('\n');

% for all subjects
for i = 1:num_subj
    
    % display subject
    fprintf('-> Calculate cvLFEs for subject "%s" (%d out of %d) ... ', subj_ids{i}, i, num_subj);
    
    % get input variables
    LMEs = cell(num_mods,1);
    for j = 1:num_mods
        LMEs{j} = strcat(stat_dir,'/',subj_ids{i},'_',GLM_names{j},'_MA_cvLME.nii');
    end;
    
    % calculate cvLFE images
    MA_LFE_uniform(LMEs, fam_vec, fam_nam, stat_dir);
    fprintf('successful!\n');
    
    % move cvLFE images
    for k = 1:num_fams
        srce_img = strcat(stat_dir,'MA_LFE_uniform/',fam_nam{k},'_LFE.nii');
        dest_img = strcat(stat_dir,'/',subj_ids{i},'_',fam_nam{k},'_MA_cvLFE.nii');
        movefile(srce_img, dest_img, 'f');
    end;
    
end;

% remove LFE folder
fprintf('\n');
cd(strcat(stud_dir,'FADE_BMS/'));
rmdir(strcat(stat_dir,'MA_LFE_uniform/'),'s');