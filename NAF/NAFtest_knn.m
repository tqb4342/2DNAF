function NAFtest_knn
% ---------------------------------------------------------------------
% ���ܣ���ǰ����NAF������KNNpatch�Ƿ����ƣ���������ƣ����������������ѵ��
% ----------------------------------------------------------------------
    clc;%clear;
    load '..\0globalset\const.mat'
    
    
    %% ��ȡ����patch����
    load([FP_FEAAUX 'NAFfpos.mat'])
    load([FP_TE_ORI 'test.mat'])
    load([FP_TE_ORI '4_testpatches.mat']);   %11��Ӧ�ö�Ҫload��
    extNAFFeature(testimgdata,testpatches,NAFfpos,OVH,FP_TEMPDATA,'test');
    
    %% ����patch��KNN
    load([FP_ROOT 'NAFrnode.mat']);
    load([FP_TEMPDATA 'testFea.mat']);
    disp('���ڻ�������ѵ��patch�ļ�...')
    load([FP_TR_ORI 'trainpatches.mat']);  %load�������
    len = length(testpatches);
    figure();
    for i = 1:len %�������в���patches
        disp(['���ڲ��Ե�' num2str(i) '/' num2str(len) '��patches' ]);
        pc = [];%����Ͱ
        for j = 1:TN%�������е���
             pidx = NAFmatch(rnode{j,1},fea(i,:)); %�Ѳ��Ե�feature�������б���
             pc = [pc,pidx'];
        end
        tcount = tabulate(pc);   %tabulate��һ��Ƶ��ͳ�Ƶĺ���
        tsort = sortrows(tcount,-2);   %���򣬳��ִ����������ǰ��
        pidxs(i).pidx = tsort(1:min(length(pc),KNN_K),1);  %ȡǰKNN_K��
        subplot(1,KNN_K+2,1);
        imshow(testpatches(i).imgpatch);
        title('����img')
        subplot(1,KNN_K+2,2);
        imshow(testpatches(i).gtpatch*255);
        title('����gt')
        for j = 1:KNN_K
            subplot(1,KNN_K+2,j+2);
            imshow(trainpatches(pidxs(i).pidx(j)).gtpatch*255);
        end
        pause();
    end
    
end