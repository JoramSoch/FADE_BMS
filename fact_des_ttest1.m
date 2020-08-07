function design_mat = fact_des_ttest1(stud_dir, subj_file, MS_file, img_path, cov_names, stat_suff)
% _
% Create batch for factorial design one-sample t-test analysis
% 
%     stud_dir   - study directory in data/analyses are located
%     subj_file  - an XLS file containing subject IDs and covariates
%     MS_file    - a  MAT file containg model space name and GLM names
%     img_path   - image path name specifying the image to be tested
%     cov_names  - covariate names specifying confounding factors
%     stat_suff  - a string appended as suffix to analysis directory
% 
%     design_mat - filename of the SPM Batch Editor job file
% 
% written by Joram Soch <Joram.Soch@DZNE.de>, 24/02/2020, 11:40;
% adapted: 09/03/2020, 12:19; edited for upload: 07/08/2020, 11:22


% list of subjects
[num, txt, raw] = xlsread(subj_file);
subj_ids = raw(2:end,1);
num_subj = numel(subj_ids);
load(MS_file);
clear num txt
clear GLM_names

% get covariates
num_covs = numel(cov_names);
cov_vals = zeros(num_subj,num_covs);
for j = 1:num_covs
    cov_vals(:,j) = cell2mat(raw(2:end,strcmp(raw(1,:),cov_names{j})));
    cov_names{j}(strfind(cov_names{j},'_')) = '-';
end;

% specify directory
if ~isempty(strfind(img_path,'con_images'))
    ana_type = 'SPM_analyses';
elseif ~isempty(strfind(img_path,'cvLME_maps'))
    ana_type = 'MACS_analyses';
end;
ana_dir = strcat(stud_dir,ana_type,'/',MS_name,'_',stat_suff,'/');
matlabbatch{1}.spm.stats.factorial_design.dir = {ana_dir};

% specify scans
subj_scans = cell(numel(subj_ids),1);
for i = 1:num_subj
    rp = img_path;
  % rp = strcat(rp(1:strfind(rp,'+')-1),MS_name,rp(strfind(rp,'+')+1:end));
    rp = strcat(rp(1:strfind(rp,'*')-1),subj_ids{i},rp(strfind(rp,'*')+1:end));
    subj_scans{i} = strcat(stud_dir,rp);
end;
matlabbatch{1}.spm.stats.factorial_design.des.t1.scans = subj_scans;
clear subj_scans rp

% specify covariates
if num_covs > 0
    for j = 1:num_covs
        matlabbatch{1}.spm.stats.factorial_design.cov(j).c     = cov_vals(:,j);
        matlabbatch{1}.spm.stats.factorial_design.cov(j).cname = cov_names{j};
        matlabbatch{1}.spm.stats.factorial_design.cov(j).iCFI  = 1; % no interactions
        matlabbatch{1}.spm.stats.factorial_design.cov(j).iCC   = 1; % subtract mean
    end;
    clear cov_vect
else
    matlabbatch{1}.spm.stats.factorial_design.cov = struct('c', {}, 'cname', {}, 'iCFI', {}, 'iCC', {});
end;

% specify all the rest
matlabbatch{1}.spm.stats.factorial_design.multi_cov              = struct('files', {}, 'iCFI', {}, 'iCC', {});
matlabbatch{1}.spm.stats.factorial_design.masking.tm.tm_none     = 1;
matlabbatch{1}.spm.stats.factorial_design.masking.im             = 1;
matlabbatch{1}.spm.stats.factorial_design.masking.em             = {''};
matlabbatch{1}.spm.stats.factorial_design.globalc.g_omit         = 1;
matlabbatch{1}.spm.stats.factorial_design.globalm.gmsca.gmsca_no = 1;
matlabbatch{1}.spm.stats.factorial_design.globalm.glonorm        = 1;

% specify model estimation
matlabbatch{2}.spm.stats.fmri_est.spmmat(1)        = cfg_dep('Factorial design specification: SPM.mat File', substruct('.','val', '{}',{1}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('.','spmmat'));
matlabbatch{2}.spm.stats.fmri_est.write_residuals  = 0;
matlabbatch{2}.spm.stats.fmri_est.method.Classical = 1;

% specify contrast manager
matlabbatch{3}.spm.stats.con.spmmat(1)               = cfg_dep('Model estimation: SPM.mat File', substruct('.','val', '{}',{2}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('.','spmmat'));
matlabbatch{3}.spm.stats.con.consess{1}.fcon.name    = 'EOI';
matlabbatch{3}.spm.stats.con.consess{1}.fcon.weights = eye(1);
matlabbatch{3}.spm.stats.con.consess{1}.fcon.sessrep = 'none';
matlabbatch{3}.spm.stats.con.consess{2}.tcon.name    = 'pos';
matlabbatch{3}.spm.stats.con.consess{2}.tcon.weights = +1;
matlabbatch{3}.spm.stats.con.consess{2}.tcon.sessrep = 'none';
matlabbatch{3}.spm.stats.con.consess{3}.tcon.name    = 'neg';
matlabbatch{3}.spm.stats.con.consess{3}.tcon.weights = -1;
matlabbatch{3}.spm.stats.con.consess{3}.tcon.sessrep = 'none';
for j = 1:num_covs
    matlabbatch{3}.spm.stats.con.consess{3+j}.fcon.name    = cov_names{j};
    matlabbatch{3}.spm.stats.con.consess{3+j}.fcon.weights = [zeros(1,1+j-1), 1];
    matlabbatch{3}.spm.stats.con.consess{3+j}.fcon.sessrep = 'none';
end;
matlabbatch{3}.spm.stats.con.delete = 0;

% save batch
if ~exist(ana_dir,'dir'), mkdir(ana_dir); end;
filename = strcat(ana_dir,'design.mat');
save(filename,'matlabbatch');
design_mat = filename;

% display message
fprintf('\n');
fprintf('-> Thank you! The following files have been created:\n');
fprintf('   - SPM batch: %s.\n', strcat(ana_dir,'design.mat'));
fprintf('\n');