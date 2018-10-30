function preprocess(testflag)
% -----------------------------------------------------------------------------
% ���ܣ�Ԥ����ͼ��
%��train.mat/test.mat��trainimgdata/testimgdata
% ctid��CTͼ����ID || slid��CT��ƬID || img��ͼ������ || gt����ǩ����
%��trainpatches.mat/testpatches.mat��testpatches
% imgpatch��ͼ������ || gtpatch����ǩ���� || fileidx�������ļ�id || mx������x
% || my������y || ctrx:����x || ctry������y || gtcl��gt�����ǩ || pid��������ID
% -----------------------------------------------------------------------------
    clc;
    load '..\0globalset\const.mat'
    %% ����mat�����ļ� trainimgdata{img,gt}
    stdsegout(mfilename,'Ԥ��������mat')
    imgext = '.png';
    if (testflag == 0) %ѵ��
        makemat(FP_TR_IMG,FP_TR_GT,FP_TR_ORI,imgext,'trainimgdata','train.mat',1,25);
    else %����
        makemat(FP_TE_IMG,FP_TE_GT,FP_TE_ORI,imgext,'testimgdata','testsmall.mat',35,40);
    end
    %% �ָ�patches
    stdsegout(mfilename,'Ԥ�����ָ�patches')   %��ʾ�ָ����Լ�����
     if (testflag == 0) %ѵ��
       load([FP_TR_ORI 'train.mat'])
       makepatches(NPX,NPY,NIX,NIY,trainimgdata,'trainpatches','trainpatches.mat',FP_TR_ORI);
     else %����
       load([FP_TE_ORI 'testsmall.mat'])
       makepatches(NPX,NPY,NIX,NIY,testimgdata,'testpatches','testpatches.mat',FP_TE_ORI);
     end
end