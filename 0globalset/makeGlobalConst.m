function makeGlobalConst
% -----------------------------------
% 功能：定义全局常量，保存在当前目录下
% 注意：
%      （1）目录命名方式：FP_XXX
%      （2）目录结尾必须带分隔符'\'
% -----------------------------------
    clc;clear;
    load const.mat
    %% 根目录
    FP_WORK = 'E:\文献\2DNAF\';
    
    %% 一级目录
    FP_DATABASE = [FP_WORK 'database\'];
    FP_LOG = [FP_WORK 'log\'];
    FP_UTIL = [FP_WORK 'utils\']; %常用工具函数，不建议修改
    
    %% 二级目录
    FP_FEATURE = [FP_DATABASE 'feature\'];    %特征向量数据
    FP_RAWDATA = [FP_DATABASE 'rawdata\'];    %生数据，jpg
    FP_ORIDATA = [FP_DATABASE 'oridata\'];    %初始数据，mat
    FP_TEMPDATA = [FP_DATABASE 'tempdata\'];  %临时数据
    FP_FEAAUX = [FP_DATABASE 'feature_aux\']; %特征辅助数据，比如最大最小归一化的PS
    FP_ROOT = [FP_DATABASE 'root\'];          %NAF数据结构，根
    FP_RESULT = [FP_DATABASE 'result\'];      %NAF测试结果
    FP_FIG = [FP_DATABASE 'figure\'];         %NAF测试结果图形化
    
    %% 三级目录
    FP_TR_FEA = [FP_FEATURE 'feature_train\'];
    FP_TE_FEA = [FP_FEATURE 'feature_test\'];
    
    FP_TR_IMG = [FP_RAWDATA '039_train\'];
    FP_TR_GT = [FP_RAWDATA '039_train_gt\'];
    FP_TE_IMG = [FP_RAWDATA '039_test\'];
    FP_TE_GT = [FP_RAWDATA '039_test_gt\'];
    
    FP_TR_ORI = [FP_ORIDATA 'oritrain\'];
    FP_TE_ORI = [FP_ORIDATA 'oritest\'];
    
    
    %%  NAFS参数
    NPX = 20; %切分成更小的patches，程度为尽量看不出细节
    NPY = 20;
    NIX = 10;%patch重叠步进像素长度
    NIY = 10;
    
    FW = 15;%特征抽取的宽度
    F_ALL = 150;%总特征个数
    F_SIG = 6; %内部特征个数
    F_SEL = 100;%随机抽取的邻域特征个数   推荐：floor(0.5*sqrt(Q));
    OVH=-1;%超出边界后的默认值
  
    TEST_SPLEN = 50000; %测试数据分堆
    FEA_SPLEN = 500000; %特征分片
    
    S_EACH_SEL = ceil(30000/11);%分层抽样
    F_SCANNUM = 50;%穷尽扫描的特征数目
    SPLIT_STEP = 100;%选择划分点的间隔粒度
    TN = 20;%树的数目 20
    LEAFNUM = 20;%节点至少要有的图片数目
    MAXL = 10;%最大层深 25 2^25 = 33554432

    %% KNN参数
     KNN_K = 5;
    %% 保存到const.mat
    save('const.mat')
    disp([ datestr(now,31) ' 常量更新成功'])
end