% Data analysis for FADE-BMS
% _
% This script performs the entire data analysis for the FADE-BMS study.
% 
% written by Joram Soch <Joram.Soch@DZNE.de>, 07/08/2020, 13:28


%%% Step 0: analysis parameters %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% directories and subjects
stud_dir   =  'C:\Joram\projects\DZNE\FADE\sharing\FADE_BMS\';
subj_file  =  'subjects/subjects_FADE_BMS.xls';
subj_files = {'subjects/subjects_FADE_BMS_young.xls';
              'subjects/subjects_FADE_BMS_old.xls'};
stat_suffs = {'young', 'old'};

% create analysis super-folders
if ~exist(strcat(stud_dir,'MACS_analyses/'),'dir')
    mkdir(strcat(stud_dir,'MACS_analyses/'));
end;
if ~exist(strcat(stud_dir,'SPM_analyses/'),'dir')
    mkdir(strcat(stud_dir,'SPM_analyses/'));
end;

% specify analyses to perform
thx2do = [1:3, 4.1, 4.2, 5:10, 11];


%%% Analysis 1: GLMs_PE vs. GLMs_TD %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if ismember(1,thx2do)

% run BMS and SMM
MS_file = 'models/MS_FADE_04_00_0.mat';
family.mods = [1 1 1 1 2 2 2 2];
family.fams = {'GLMs_PE', 'GLMs_TD'};
for i = 1:numel(subj_files)
    load(cvBMS_analysis_batch(stud_dir, subj_files{i}, MS_file, 'MA_cvLME.nii', strcat('00_0_PE_vs_TD_', stat_suffs{i})));
    MS_BMS_group_fams(matlabbatch{1}.spm.tools.MACS.MS_BMS_group_man, 'RFX-VB', family, true);
    load(strcat(matlabbatch{1}.spm.tools.MACS.MS_BMS_group_man.dir{1},'BMS.mat'));
    MS_SMM_BMS_fams(BMS);
end;

end;


%%% Analysis 2: GLMs_00 vs. GLMs_0 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if ismember(2,thx2do)

% run BMS and SMM
MS_file = 'models/MS_FADE_04_00_0.mat';
family.mods = [1 1 2 2 1 1 2 2];
family.fams = {'GLMs_00', 'GLMs_0'};
for i = 1:numel(subj_files)
    load(cvBMS_analysis_batch(stud_dir, subj_files{i}, MS_file, 'MA_cvLME.nii', strcat('00_0_00_vs_0_', stat_suffs{i})));
    MS_BMS_group_fams(matlabbatch{1}.spm.tools.MACS.MS_BMS_group_man, 'RFX-VB', family, true);
    load(strcat(matlabbatch{1}.spm.tools.MACS.MS_BMS_group_man.dir{1},'BMS.mat'));
    MS_SMM_BMS_fams(BMS)
end;

end;


%%% Analysis 3: GLMs_x1 vs. GLMs_x2 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if ismember(3,thx2do)

% run BMS and SMM
MS_file = 'models/MS_FADE_04_00_0.mat';
family.mods = [1 2 1 2 1 2 1 2];
family.fams = {'GLMs_x1', 'GLMs_x2'};
for i = 1:numel(subj_files)
    load(cvBMS_analysis_batch(stud_dir, subj_files{i}, MS_file, 'MA_cvLME.nii', strcat('00_0_x1_vs_x2_', stat_suffs{i})));
    MS_BMS_group_fams(matlabbatch{1}.spm.tools.MACS.MS_BMS_group_man, 'RFX-VB', family, true);
    load(strcat(matlabbatch{1}.spm.tools.MACS.MS_BMS_group_man.dir{1},'BMS.mat'));
    MS_SMM_BMS_fams(BMS)
end;

end;


%%% Analysis 4a: GLM_0 vs. GLMs_1/2 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if ismember(4.1,thx2do)

% calculate cvLFEs
MS_file = 'models/MS_FADE_04_TD_0_1_2.mat';
fam_vec = [1 0 2 2 2 2 2 2 3 3 3];
fam_nam = {'GLMs_TD_0', 'GLMs_TD_1', 'GLMs_TD_2'};
cvLFE_meta_batch(stud_dir, subj_file, MS_file, fam_vec, fam_nam);

% run BMS and SMM
MS_file = 'models/MS_FADE_04_TD_0_1_2_fams.mat';
family.mods = [1 2 2];
family.fams = {'GLMs_TD_0', 'GLMs_TD_12'};
for i = 1:numel(subj_files)
    load(cvBMS_analysis_batch(stud_dir, subj_files{i}, MS_file, 'MA_cvLFE.nii', strcat('TD_0_1_2_12_vs_0_', stat_suffs{i})));
    MS_BMS_group_fams(matlabbatch{1}.spm.tools.MACS.MS_BMS_group_man, 'RFX-VB', family, true);
    load(strcat(matlabbatch{1}.spm.tools.MACS.MS_BMS_group_man.dir{1},'BMS.mat'));
    MS_SMM_BMS_fams(BMS)
end;

end;


%%% Analysis 4b: number of regressors %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if ismember(4.2,thx2do)

% calculate cvLFEs
subj_GLM5 = 'subjects/subjects_FADE_BMS_GLM_5.xls';
MS_file   = 'models/MS_FADE_04_TD_3_5.mat';
fam_vec   = [1 2];
fam_nam   = {'GLMs_TD_3', 'GLMs_TD_5'};
cvLFE_meta_batch(stud_dir, subj_GLM5, MS_file, fam_vec, fam_nam);

% calculate cvLBFs
MS_file  = 'models/MS_FADE_04_TD_0-5_fams.mat';
mod_vecs = [2 1 0 0 0;
            2 0 1 0 0;
            2 0 0 1 0;
            2 0 0 0 1];
cvLBF_meta_batch(stud_dir, subj_GLM5, MS_file, mod_vecs(1,:), 'MA_cvLFE.nii', 'GLMs_TD_1_vs_0');
cvLBF_meta_batch(stud_dir, subj_GLM5, MS_file, mod_vecs(2,:), 'MA_cvLFE.nii', 'GLMs_TD_2_vs_0');
cvLBF_meta_batch(stud_dir, subj_GLM5, MS_file, mod_vecs(3,:), 'MA_cvLFE.nii', 'GLMs_TD_3_vs_0');
cvLBF_meta_batch(stud_dir, subj_GLM5, MS_file, mod_vecs(4,:), 'MA_cvLFE.nii', 'GLMs_TD_5_vs_0');

% run BMS and SMM
subjs_GLM5= {'subjects/subjects_FADE_BMS_GLM_5_young.xls';
             'subjects/subjects_FADE_BMS_GLM_5_old.xls'};
MS_file   =  'models/MS_FADE_04_TD_0-5_fams.mat';
img_paths = {'cvLME_maps/*_GLMs_TD_1_vs_0_MC_cvLBF.nii';
             'cvLME_maps/*_GLMs_TD_2_vs_0_MC_cvLBF.nii';
             'cvLME_maps/*_GLMs_TD_3_vs_0_MC_cvLBF.nii';
             'cvLME_maps/*_GLMs_TD_5_vs_0_MC_cvLBF.nii'};
var_names = {};
cov_names = {'sex (1=male, 2=female)'};
job_list  = cell(size(subjs_GLM5));
for i = 1:numel(subjs_GLM5)
    job_list{i} = fact_des_full_fact(stud_dir, subjs_GLM5{i}, MS_file, img_paths, var_names, cov_names, strcat('LBF_GLMs_TD_1235_vs_0_', stat_suffs{i}));
end;
spm_exec_mult_jobs(job_list);

end;


%%% Analysis 5: GLMs_1 vs. GLMs_2 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if ismember(5,thx2do)

% run BMS and SMM
MS_file = 'models/MS_FADE_04_TD_1_2.mat';
family.mods = [1 1 1 1 1 1 2 2 2];
family.fams = {'GLMs_TD_1', 'GLMs_TD_2'};
for i = 1:numel(subj_files)
    load(cvBMS_analysis_batch(stud_dir, subj_files{i}, MS_file, 'MA_cvLME.nii', strcat('TD_1_2_1_vs_2_', stat_suffs{i})));
    MS_BMS_group_fams(matlabbatch{1}.spm.tools.MACS.MS_BMS_group_man, 'RFX-VB', family, true);
    load(strcat(matlabbatch{1}.spm.tools.MACS.MS_BMS_group_man.dir{1},'BMS.mat'));
    MS_SMM_BMS_fams(BMS)
end;

end;


%%% Analysis 6: GLMs_1dd vs. GLMs_1th %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if ismember(6,thx2do)

% run BMS and SMM
MS_file = 'models/MS_FADE_04_TD_1.mat';
family.mods = [1 1 1 2 2 2];
family.fams = {'GLMs_TD_1dd', 'GLMs_TD_1th'};
for i = 1:numel(subj_files)
    load(cvBMS_analysis_batch(stud_dir, subj_files{i}, MS_file, 'MA_cvLME.nii', strcat('TD_1_dd_vs_th_', stat_suffs{i})));
    MS_BMS_group_fams(matlabbatch{1}.spm.tools.MACS.MS_BMS_group_man, 'RFX-VB', family, true);
    load(strcat(matlabbatch{1}.spm.tools.MACS.MS_BMS_group_man.dir{1},'BMS.mat'));
    MS_SMM_BMS_fams(BMS)
end;

end;


%%% Analyses 7-9: GLMs_2, GLMs_1dd, GLMs_1th %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if ismember(7,thx2do) || ismember(8,thx2do) || ismember(9,thx2do)

% run BMS and SMM (GLMs_2)
MS_file = 'models/MS_FADE_04_TD_2.mat';
for i = 1:numel(subj_files)
    load(cvBMS_analysis_batch(stud_dir, subj_files{i}, MS_file, 'MA_cvLME.nii', strcat('TD_2_nf_nr_ns_', stat_suffs{i})));
    spm_jobman('run', matlabbatch);
end;

% run BMS and SMM (GLMs_1dd)
MS_file = 'models/MS_FADE_04_TD_1dd.mat';
for i = 1:numel(subj_files)
    load(cvBMS_analysis_batch(stud_dir, subj_files{i}, MS_file, 'MA_cvLME.nii', strcat('TD_1dd_ip_cp_lr_', stat_suffs{i})));
    spm_jobman('run', matlabbatch);
end;

% run BMS and SMM (GLMs_1th)
MS_file = 'models/MS_FADE_04_TD_1th.mat';
for i = 1:numel(subj_files)
    load(cvBMS_analysis_batch(stud_dir, subj_files{i}, MS_file, 'MA_cvLME.nii', strcat('TD_1th_l_a_s_', stat_suffs{i})));
    spm_jobman('run', matlabbatch);
end;

end;


%%% Analysis 10: GLM_1th-a vs. GLM_1dd-ip %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if ismember(10,thx2do)

% run BMS and SMM (2 winning models)
MS_file = 'models/MS_FADE_04_TD_WM2.mat';
for i = 1:numel(subj_files)
    load(cvBMS_analysis_batch(stud_dir, subj_files{i}, MS_file, 'MA_cvLME.nii', strcat('TD_WM2_', stat_suffs{i})));
    spm_jobman('run', matlabbatch);
end;

% run BMS and SMM (3 winning models)
MS_file = 'models/MS_FADE_04_TD_WM3.mat';
for i = 1:numel(subj_files)
    load(cvBMS_analysis_batch(stud_dir, subj_files{i}, MS_file, 'MA_cvLME.nii', strcat('TD_WM3_', stat_suffs{i})));
    spm_jobman('run', matlabbatch);
end;

end;


%%% Analyses A-D: parameter estimates %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if ismember(11,thx2do)

% run one-sample t-tests
MS_file   =  'models/MS_FADE_04.mat';
GLM_names = {'GLM_TD_1th-a', 'GLM_TD_1th-a',  'GLM_TD_1dd-ip', 'GLM_TD_2nf'};
con_names = {'con_0001.nii', 'beta_0002.nii', 'beta_0002.nii', 'con_0002.nii'};
cov_names = {};
job_list  = cell(numel(subj_files)*numel(con_names),1);
for i = 1:numel(subj_files)
    for j = 1:numel(con_names)
        img_path = strcat('con_images/*_',GLM_names{j},'_',con_names{j});
        if j == 1, stat_suff = strcat(GLM_names{j},'_novelty_',stat_suffs{i}); end;
        if j >  1, stat_suff = strcat(GLM_names{j},'_memory_', stat_suffs{i}); end;
        job_list{(i-1)*numel(con_names)+j} = fact_des_ttest1(stud_dir, subj_files{i}, MS_file, img_path, cov_names, stat_suff);
    end;
end;
spm_exec_mult_jobs(job_list);

end;