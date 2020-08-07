% 4th model space
MS_name   = 'MS_FADE_04';
MS_axis1  = {'PE', 'TD'};
MS_axis2  = {'00x1', '00x2', '0x1', '0x2', '1dd-ip', '1dd-cp', '1dd-lr', '1th-l', '1th-a', '1th-s', '2nf', '2nr', '2ns', '3', '5'};
GLM_names = cell(numel(MS_axis1)*numel(MS_axis2),1);
for i1 = 1:numel(MS_axis1)
    for i2 = 1:numel(MS_axis2)
        GLM_names{(i1-1)*numel(MS_axis2)+i2} = strcat('GLM_',MS_axis1{i1},'_',MS_axis2{i2});
    end;
end;
save('MS_FADE_04.mat', 'MS_name', 'GLM_names');

% 4th model space (00/0 models)
MS_name   = 'MS_FADE_04';
MS_axis1  = {'PE', 'TD'};
MS_axis2  = {'00x1', '00x2', '0x1', '0x2'};
GLM_names = cell(numel(MS_axis1)*numel(MS_axis2),1);
for i1 = 1:numel(MS_axis1)
    for i2 = 1:numel(MS_axis2)
        GLM_names{(i1-1)*numel(MS_axis2)+i2} = strcat('GLM_',MS_axis1{i1},'_',MS_axis2{i2});
    end;
end;
save('MS_FADE_04_00_0.mat', 'MS_name', 'GLM_names');

% 4th model space (TD-0/1/2 models)
MS_name   = 'MS_FADE_04';
MS_axis1  = {'TD'};
MS_axis2  = {'0x1', '0x2', '1dd-ip', '1dd-cp', '1dd-lr', '1th-l', '1th-a', '1th-s', '2nf', '2nr', '2ns'};
GLM_names = cell(numel(MS_axis1)*numel(MS_axis2),1);
for i1 = 1:numel(MS_axis1)
    for i2 = 1:numel(MS_axis2)
        GLM_names{(i1-1)*numel(MS_axis2)+i2} = strcat('GLM_',MS_axis1{i1},'_',MS_axis2{i2});
    end;
end;
save('MS_FADE_04_TD_0_1_2.mat', 'MS_name', 'GLM_names');

% 4th model space (TD-0/1/2 families)
MS_name   = 'MS_FADE_04';
GLM_names = {'GLMs_TD_0', 'GLMs_TD_1', 'GLMs_TD_2'}';
save('MS_FADE_04_TD_0_1_2_fams.mat', 'MS_name', 'GLM_names');

% 4th model space (TD-1/2 models)
MS_name   = 'MS_FADE_04';
MS_axis1  = {'TD'};
MS_axis2  = {'1dd-ip', '1dd-cp', '1dd-lr', '1th-l', '1th-a', '1th-s', '2nf', '2nr', '2ns'};
GLM_names = cell(numel(MS_axis1)*numel(MS_axis2),1);
for i1 = 1:numel(MS_axis1)
    for i2 = 1:numel(MS_axis2)
        GLM_names{(i1-1)*numel(MS_axis2)+i2} = strcat('GLM_',MS_axis1{i1},'_',MS_axis2{i2});
    end;
end;
save('MS_FADE_04_TD_1_2.mat', 'MS_name', 'GLM_names');

% 4th model space (TD-1 models)
MS_name   = 'MS_FADE_04';
MS_axis1  = {'TD'};
MS_axis2  = {'1dd-ip', '1dd-cp', '1dd-lr', '1th-l', '1th-a', '1th-s'};
GLM_names = cell(numel(MS_axis1)*numel(MS_axis2),1);
for i1 = 1:numel(MS_axis1)
    for i2 = 1:numel(MS_axis2)
        GLM_names{(i1-1)*numel(MS_axis2)+i2} = strcat('GLM_',MS_axis1{i1},'_',MS_axis2{i2});
    end;
end;
save('MS_FADE_04_TD_1.mat', 'MS_name', 'GLM_names');

% 4th model space (TD-2 models)
MS_name   = 'MS_FADE_04';
GLM_names = {'GLM_TD_2nf', 'GLM_TD_2nr', 'GLM_TD_2ns'}';
save('MS_FADE_04_TD_2.mat', 'MS_name', 'GLM_names');

% 4th model space (TD-1dd models)
MS_name   = 'MS_FADE_04';
GLM_names = {'GLM_TD_1dd-ip', 'GLM_TD_1dd-cp', 'GLM_TD_1dd-lr'}';
save('MS_FADE_04_TD_1dd.mat', 'MS_name', 'GLM_names');

% 4th model space (TD-1th models)
MS_name   = 'MS_FADE_04';
GLM_names = {'GLM_TD_1th-l', 'GLM_TD_1th-a', 'GLM_TD_1th-s'}';
save('MS_FADE_04_TD_1th.mat', 'MS_name', 'GLM_names');

% 4th model space (TD-3/5 models)
MS_name   = 'MS_FADE_04';
GLM_names = {'GLM_TD_3', 'GLM_TD_5'}';
save('MS_FADE_04_TD_3_5.mat', 'MS_name', 'GLM_names');

% 4th model space (TD-3/5 families)
MS_name   = 'MS_FADE_04';
GLM_names = {'GLMs_TD_3', 'GLMs_TD_5'}';
save('MS_FADE_04_TD_3_5_fams.mat', 'MS_name', 'GLM_names');

% 4th model space (TD-0/1/2/3/5 families)
MS_name   = 'MS_FADE_04';
GLM_names = {'GLMs_TD_0', 'GLMs_TD_1', 'GLMs_TD_2', 'GLMs_TD_3', 'GLMs_TD_5'}';
save('MS_FADE_04_TD_0-5_fams.mat', 'MS_name', 'GLM_names');

% 4th model space (3 winning models)
MS_name   = 'MS_FADE_04';
GLM_names = {'GLM_TD_1dd-ip', 'GLM_TD_1th-a', 'GLM_TD_2nf'};
save('MS_FADE_04_TD_WM3.mat', 'MS_name', 'GLM_names');

% 4th model space (2 winning models)
MS_name   = 'MS_FADE_04';
GLM_names = {'GLM_TD_1dd-ip', 'GLM_TD_1th-a'};
save('MS_FADE_04_TD_WM2.mat', 'MS_name', 'GLM_names');