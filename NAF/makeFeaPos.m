function makeFeaPos
% ----------------------------
% 功能：生成随机的邻域特征位置
% ----------------------------
    clc;clear;
    load '..\0globalset\const.mat'
    
    hffwx = floor(FW/2);
    hffwy = floor(FW/2);
    [fx,fy] = meshgrid(-hffwx:hffwx, -hffwy:hffwy);  %meshgrid 函数用来生成网格矩阵
    fpos = [fx(:),fy(:)];%生成x,y的笛卡尔积矩阵
    posidx = randperm(size(fpos,1)); %随机排列（x,y）
    NAFfpos = fpos(posidx(1:F_ALL),:);%抽取前F_ALL个
    saveMatFile(mfilename,NAFfpos,'NAFfpos','NAFfpos.mat',FP_FEAAUX,'');
end