function NAFtest_knn
% ---------------------------------------------------------------------
% 功能：提前测试NAF出来的KNNpatch是否相似，如果不相似，尽快调整参数重新训练
% ----------------------------------------------------------------------
    clc;%clear;
    load '..\0globalset\const.mat'
    
    
    %% 提取测试patch特征
    load([FP_FEAAUX 'NAFfpos.mat'])
    load([FP_TE_ORI 'test.mat'])
    load([FP_TE_ORI '4_testpatches.mat']);   %11类应该都要load吧
    extNAFFeature(testimgdata,testpatches,NAFfpos,OVH,FP_TEMPDATA,'test');
    
    %% 测试patch的KNN
    load([FP_ROOT 'NAFrnode.mat']);
    load([FP_TEMPDATA 'testFea.mat']);
    disp('正在缓慢加载训练patch文件...')
    load([FP_TR_ORI 'trainpatches.mat']);  %load这个干嘛
    len = length(testpatches);
    figure();
    for i = 1:len %遍历所有测试patches
        disp(['正在测试第' num2str(i) '/' num2str(len) '张patches' ]);
        pc = [];%计数桶
        for j = 1:TN%遍历所有的树
             pidx = NAFmatch(rnode{j,1},fea(i,:)); %把测试的feature向量进行遍历
             pc = [pc,pidx'];
        end
        tcount = tabulate(pc);   %tabulate是一个频率统计的函数
        tsort = sortrows(tcount,-2);   %排序，出现次数多的排在前面
        pidxs(i).pidx = tsort(1:min(length(pc),KNN_K),1);  %取前KNN_K个
        subplot(1,KNN_K+2,1);
        imshow(testpatches(i).imgpatch);
        title('测试img')
        subplot(1,KNN_K+2,2);
        imshow(testpatches(i).gtpatch*255);
        title('测试gt')
        for j = 1:KNN_K
            subplot(1,KNN_K+2,j+2);
            imshow(trainpatches(pidxs(i).pidx(j)).gtpatch*255);
        end
        pause();
    end
    
end