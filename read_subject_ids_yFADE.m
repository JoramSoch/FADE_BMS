function [subj_ids, dzne_ids, mbm_nos, subj_info, tab_hdr] = read_subject_ids(subj_file, varargin)
% _
% Read Subject IDs and DZNE IDs from Excel or text file
% 
%     subj_file - an XLS or TXT file containing subject information
%     property  - (optional) property to select sub-set of subjects
%     value     - (optional) property value to select sub-set
% 
%     subj_ids  - an n x 1 cell array of Subject IDs (e.g. 'xy99')
%     dzne_ids  - an n x 1 cell array of DZNE IDs (e.g. 'XYZ123')
%     mbm_nos   - an n x 1 cell array of mbm Nos. (e.g. 'mbm_1234')
%     subj_info - an n x p cell array of all subject information
%     tab_hdr   - a  1 x p cell vector with the table header
% 
% written by Joram Soch <Joram.Soch@DZNE.de>, 25/04/2020, 16:02


% get subject file
[folder, name, ext] = fileparts(subj_file);
clear folder name

% load XLS file
if strcmp(ext,'.xls')
    % read file
    [num, txt, raw] = xlsread(subj_file);
    clear num txt
    % extract variables
    header    = raw(1,:);
    subj_info = raw(2:end,:);
    subj_ids  = raw(2:end,1);
    dzne_ids  = raw(2:end,2);
    mbm_nos   = raw(2:end,3);
    num_subj  = numel(subj_ids);
    tab_hdr   = header;
end;

% load TXT file
if strcmp(ext,'.txt')
    % read header
    del = char(9);
    fid = fopen(subj_file);
    head_line = fgetl(fid);
    header    = textscan(head_line,'%s','delimiter','\t');
    header    = header{1}';
    num_cols  = numel(strfind(head_line,del))+1;
    % read subjects
    i = 0;
    while ~feof(fid)
        i = i + 1;
        subj_line = fgetl(fid);
        subject   = textscan(subj_line,'%s','delimiter','\t');
        for j = 1:num_cols
            if ~isempty(str2num(subject{1}{j}))
                subj_info{i,j} = str2num(subject{1}{j});
            else
                subj_info{i,j} = subject{1}{j};
            end;
        end;
    end;
    % extract variables
    subj_ids = subj_info(:,1);
    dzne_ids = subj_info(:,2);
    mbm_nos  = subj_info(:,3);
    num_subj = numel(subj_ids);
    tab_hdr  = header;
end;

% apply constraints
if nargin > 1
    num_cons = (nargin-1)/2;
    k = false(num_subj,num_cons);
    for i = 1:num_cons
        property = varargin{(i-1)*2+1};
        value    = varargin{(i-1)*2+2};
        j = find(strcmp(header,property));
        if ischar(value)
            k(:,i) = strcmp(subj_info(:,j),value);
        else
            k(:,i) = cell2mat(subj_info(:,j))==value;
        end;
    end;
    k = sum(k,2)==num_cons;
    subj_ids  = subj_ids(k);
    dzne_ids  = dzne_ids(k);
    mbm_nos   = mbm_nos(k);
    subj_info = subj_info(k,:);
end;