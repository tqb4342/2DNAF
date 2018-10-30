function resetDatabase
% -----------------------------------
% 功能：重新创建database文件夹结构
% -----------------------------------
    clc;clear;
    load const.mat
    %% 重新创建database文件夹
    dirname = FP_DATABASE;
    if exist(dirname,'dir') 
        rmdir(dirname,'s')
    end
    
    %% 创建全部目录
    dirnames = {FP_DATABASE,...
                FP_FEATURE,FP_RAWDATA,FP_ORIDATA,FP_TEMPDATA,FP_FEAAUX,FP_ROOT,FP_RESULT,FP_FIG...
                FP_TR_FEA,FP_TE_FEA,FP_TR_IMG,FP_TR_GT,FP_TE_IMG,FP_TE_GT,FP_TR_ORI,FP_TE_ORI};
    for i = 1:length(dirnames)
        mkdir(dirnames{i});
    end
    
    disp([ datestr(now,31) ' database目录结构成功更新'])
end