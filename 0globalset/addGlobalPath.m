function addGlobalPath
% -----------------------------------
% ���ܣ��Ѳ����������ļ��м��빤��·��
% -----------------------------------
    clc;clear;
    load const.mat
    
    addpath(genpath(FP_UTIL));
    savepath;
    
    disp([ datestr(now,31) ' ·�����³ɹ�������matlab��Ч'])
end