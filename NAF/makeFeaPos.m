function makeFeaPos
% ----------------------------
% ���ܣ������������������λ��
% ----------------------------
    clc;clear;
    load '..\0globalset\const.mat'
    
    hffwx = floor(FW/2);
    hffwy = floor(FW/2);
    [fx,fy] = meshgrid(-hffwx:hffwx, -hffwy:hffwy);  %meshgrid �������������������
    fpos = [fx(:),fy(:)];%����x,y�ĵѿ���������
    posidx = randperm(size(fpos,1)); %������У�x,y��
    NAFfpos = fpos(posidx(1:F_ALL),:);%��ȡǰF_ALL��
    saveMatFile(mfilename,NAFfpos,'NAFfpos','NAFfpos.mat',FP_FEAAUX,'');
end