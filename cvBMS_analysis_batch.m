function design_mat = cvBMS_analysis_batch(stud_dir, subj_file, MS_file, LME_img, stat_suff)
% _
% Create batch for manual cvBMS analysis using MACS toolbox
% 
%     stud_dir   - study directory in data/analyses are located
%     subj_file  - an XLS file containing subject IDs and covariates
%     MS_file    - a  MAT file containg model space name and GLM names
%     LME_img    - filename of LME images collected from GLM directory
%     stat_suff  - a string appended as suffix to analysis directory
% 
%     design_mat - filename of the SPM Batch Editor job file
% 
% written by Joram Soch <Joram.Soch@DZNE.de>, 30/01/2020, 18:25;
% adapted: 17/04/2020, 19:33; edited for upload: 06/08/2020, 12:22


%%% Step 0: Study parameters %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% list of subjects
[num, txt, raw] = xlsread(subj_file);
subj_ids = raw(2:end,1);
load(MS_file);
clear num txt

% study dimensions
N = numel(subj_ids);
M = numel(GLM_names);


%%% Step 1: Create model space job %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% working directory
job_dir = strcat(stud_dir,'MACS_analyses/',MS_name,'_',stat_suff,'/');
matlabbatch{1}.spm.tools.MACS.MS_BMS_group_man.dir = {job_dir};

% assemble LME images
for i = 1:N
    for j = 1:M
        lme_img = strcat(stud_dir,'cvLME_maps/',subj_ids{i},'_',GLM_names{j},'_',LME_img);
        matlabbatch{1}.spm.tools.MACS.MS_BMS_group_man.models{i}{j} = {lme_img};
    end;
end;

% assemble model names
for j = 1:M
    matlabbatch{1}.spm.tools.MACS.MS_BMS_group_man.names{j} = GLM_names{j};
end;

% specify everything else
matlabbatch{1}.spm.tools.MACS.MS_BMS_group_man.inf_meth = 'RFX-VB';
matlabbatch{1}.spm.tools.MACS.MS_BMS_group_man.EPs      = 0;
matlabbatch{2}.spm.tools.MACS.MS_SMM_BMS.BMS_mat(1)     = cfg_dep('MS: perform BMS (manually): BMS results (BMS.mat file)', substruct('.','val', '{}',{1}, '.','val', '{}',{1}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('.','BMS_mat'));
matlabbatch{2}.spm.tools.MACS.MS_SMM_BMS.extent         = 10;


%%% Step 2: Execute model space job %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% save batch
if ~exist(job_dir,'dir'), mkdir(job_dir); end;
filename = strcat(job_dir,'design.mat');
save(filename,'matlabbatch');
design_mat = filename;

% display message
fprintf('\n');
fprintf('-> Thank you! The following files have been created:\n');
fprintf('   - SPM batch: %s.\n', strcat(job_dir,'design.mat'));
fprintf('\n');