function makeGlobalConst
% -----------------------------------
% ���ܣ�����ȫ�ֳ����������ڵ�ǰĿ¼��
% ע�⣺
%      ��1��Ŀ¼������ʽ��FP_XXX
%      ��2��Ŀ¼��β������ָ���'\'
% -----------------------------------
    clc;clear;
    load const.mat
    %% ��Ŀ¼
    FP_WORK = 'E:\����\2DNAF\';
    
    %% һ��Ŀ¼
    FP_DATABASE = [FP_WORK 'database\'];
    FP_LOG = [FP_WORK 'log\'];
    FP_UTIL = [FP_WORK 'utils\']; %���ù��ߺ������������޸�
    
    %% ����Ŀ¼
    FP_FEATURE = [FP_DATABASE 'feature\'];    %������������
    FP_RAWDATA = [FP_DATABASE 'rawdata\'];    %�����ݣ�jpg
    FP_ORIDATA = [FP_DATABASE 'oridata\'];    %��ʼ���ݣ�mat
    FP_TEMPDATA = [FP_DATABASE 'tempdata\'];  %��ʱ����
    FP_FEAAUX = [FP_DATABASE 'feature_aux\']; %�����������ݣ����������С��һ����PS
    FP_ROOT = [FP_DATABASE 'root\'];          %NAF���ݽṹ����
    FP_RESULT = [FP_DATABASE 'result\'];      %NAF���Խ��
    FP_FIG = [FP_DATABASE 'figure\'];         %NAF���Խ��ͼ�λ�
    
    %% ����Ŀ¼
    FP_TR_FEA = [FP_FEATURE 'feature_train\'];
    FP_TE_FEA = [FP_FEATURE 'feature_test\'];
    
    FP_TR_IMG = [FP_RAWDATA '039_train\'];
    FP_TR_GT = [FP_RAWDATA '039_train_gt\'];
    FP_TE_IMG = [FP_RAWDATA '039_test\'];
    FP_TE_GT = [FP_RAWDATA '039_test_gt\'];
    
    FP_TR_ORI = [FP_ORIDATA 'oritrain\'];
    FP_TE_ORI = [FP_ORIDATA 'oritest\'];
    
    
    %%  NAFS����
    NPX = 20; %�зֳɸ�С��patches���̶�Ϊ����������ϸ��
    NPY = 20;
    NIX = 10;%patch�ص��������س���
    NIY = 10;
    
    FW = 15;%������ȡ�Ŀ��
    F_ALL = 150;%����������
    F_SIG = 6; %�ڲ���������
    F_SEL = 100;%�����ȡ��������������   �Ƽ���floor(0.5*sqrt(Q));
    OVH=-1;%�����߽���Ĭ��ֵ
  
    TEST_SPLEN = 50000; %�������ݷֶ�
    FEA_SPLEN = 500000; %������Ƭ
    
    S_EACH_SEL = ceil(30000/11);%�ֲ����
    F_SCANNUM = 50;%�ɨ���������Ŀ
    SPLIT_STEP = 100;%ѡ�񻮷ֵ�ļ������
    TN = 20;%������Ŀ 20
    LEAFNUM = 20;%�ڵ�����Ҫ�е�ͼƬ��Ŀ
    MAXL = 10;%������ 25 2^25 = 33554432

    %% KNN����
     KNN_K = 5;
    %% ���浽const.mat
    save('const.mat')
    disp([ datestr(now,31) ' �������³ɹ�'])
end