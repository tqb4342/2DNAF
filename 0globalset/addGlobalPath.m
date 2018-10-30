function addGlobalPath
% -----------------------------------
% 功能：把不常见代码文件夹加入工作路径
% -----------------------------------
    clc;clear;
    load const.mat
    
    addpath(genpath(FP_UTIL));
    savepath;
    
    disp([ datestr(now,31) ' 路径更新成功，重启matlab生效'])
end