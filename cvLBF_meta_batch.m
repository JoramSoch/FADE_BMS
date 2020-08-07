function cvLBF_meta_batch(stud_dir, subj_file, MS_file, mod_vec, LME_img, LBF_name)
% _
% cvLBF meta batch for analysis of the FADE data set
%     stud_dir  - study directory in data/analyses are located
%     subj_file - an XLS file containing subject IDs and covariates
%     MS_file   - a  MAT file containg model space name and GLM names
%     mod_vec   - a 1 x M vector defining which models are subtracted
%     LME_img   - a string indicating the filename of the LME image
%     LBF_name  - a string indicating the name of the LBF image
% 
% written by Joram Soch <Joram.Soch@DZNE.de>, 07/02/2020, 08:15;
% adapted: 10/02/2020, 15:05; 21/02/2020, 11:49;
% edited for upload: 06/08/2020, 14:27


% list of subjects
[num, txt, raw] = xlsread(subj_file);
subj_ids = raw(2:end,1);
load(MS_file);
clear num txt

% study dimensions
stat_dir = strcat(stud_dir,'cvLME_maps/');
num_subj = numel(subj_ids);
num_mods = numel(GLM_names);

% determine model names
GLM1_name = GLM_names{mod_vec==1};
GLM2_name = GLM_names{mod_vec==2};
mkdir(strcat(stat_dir,'MC_LBF_group/'));
fprintf('\n');

% for all subjects
for i = 1:num_subj
    
    % display subject
    fprintf('-> Calculate cvLBFs for subject "%s" (%d out of %d) ... ', subj_ids{i}, i, num_subj);
    
    % set directory
    job_dir = strcat(stat_dir,'MC_LBF_group/');
    matlabbatch{1}.spm.tools.MACS.MC_LBF_group_man.dir = {job_dir};
    
    % input cvLME images
    if ~iscell(LME_img)
        m1_img = strcat(stat_dir,'/',subj_ids{i},'_',GLM1_name,'_',LME_img);
        m2_img = strcat(stat_dir,'/',subj_ids{i},'_',GLM2_name,'_',LME_img);
    else
        m1_img = strcat(stat_dir,'/',subj_ids{i},'_',GLM1_name,'_',LME_img{1});
        m2_img = strcat(stat_dir,'/',subj_ids{i},'_',GLM2_name,'_',LME_img{2});
    end;
    matlabbatch{1}.spm.tools.MACS.MC_LBF_group_man.models{1}{1} = {m1_img};
    matlabbatch{1}.spm.tools.MACS.MC_LBF_group_man.models{1}{2} = {m2_img};
    
    % specify model names
    matlabbatch{1}.spm.tools.MACS.MC_LBF_group_man.names = {'GLM_1', 'GLM_2'}';
    
    % calculate cvLBF image
    MC_LBF_group(matlabbatch{1}.spm.tools.MACS.MC_LBF_group_man);
    fprintf('successful!\n');
    
    % move cvLBF image
    srce_img = strcat(stat_dir,'MC_LBF_group/','LBF_GLM_1_vs_GLM_2_sub1.nii');
    dest_img = strcat(stat_dir,'/',subj_ids{i},'_',LBF_name,'_MC_cvLBF.nii');
    movefile(srce_img, dest_img, 'f');
    
end;

% remove LBF folder
fprintf('\n');
cd(strcat(stud_dir,'FADE_BMS/'));
rmdir(strcat(stat_dir,'MC_LBF_group/'),'s');