function preprocess(testflag)
% -----------------------------------------------------------------------------
% 功能：预处理图像：
%【train.mat/test.mat】trainimgdata/testimgdata
% ctid：CT图像组ID || slid：CT切片ID || img：图像数据 || gt：标签数据
%【trainpatches.mat/testpatches.mat】testpatches
% imgpatch：图像数据 || gtpatch：标签数据 || fileidx：所属文件id || mx：左上x
% || my：左上y || ctrx:中心x || ctry：中心y || gtcl：gt分类标签 || pid：块像素ID
% -----------------------------------------------------------------------------
    clc;
    load '..\0globalset\const.mat'
    %% 生成mat数据文件 trainimgdata{img,gt}
    stdsegout(mfilename,'预处理：生成mat')
    imgext = '.png';
    if (testflag == 0) %训练
        makemat(FP_TR_IMG,FP_TR_GT,FP_TR_ORI,imgext,'trainimgdata','train.mat',1,25);
    else %测试
        makemat(FP_TE_IMG,FP_TE_GT,FP_TE_ORI,imgext,'testimgdata','testsmall.mat',35,40);
    end
    %% 分割patches
    stdsegout(mfilename,'预处理：分割patches')   %显示分割线以及日期
     if (testflag == 0) %训练
       load([FP_TR_ORI 'train.mat'])
       makepatches(NPX,NPY,NIX,NIY,trainimgdata,'trainpatches','trainpatches.mat',FP_TR_ORI);
     else %测试
       load([FP_TE_ORI 'testsmall.mat'])
       makepatches(NPX,NPY,NIX,NIY,testimgdata,'testpatches','testpatches.mat',FP_TE_ORI);
     end
end