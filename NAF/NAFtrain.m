function NAFtrain
% -------------
% 功能：训练NAF
% -------------
    clc;clear;
    load '..\0globalset\const.mat'
        
    %% 提取patches的特征向量
    load([FP_FEAAUX 'NAFfpos.mat'])
    load([FP_TR_ORI 'train.mat'])
    for i = 1:11
        load([FP_TR_ORI num2str(i) '_trainpatches.mat']);
        extNAFFeature(trainimgdata,trainpatches,NAFfpos,OVH,FP_TR_FEA,[num2str(i) '_train']);
    end
    %% 预处理一下GTMAT，把矩阵变为向量，便于计算pairdist
    w =  NPX*NPY;  %块的大小
    k = 1;
    for i = 1:11
        load([FP_TR_ORI num2str(i) '_trainpatches.mat']);
        len = length(trainpatches);
        for j = 1:len
            disp(['处理第' num2str(i) '类的第' num2str(j) '/' num2str(len) '个gt图像']);
            gtmat(k,:) = reshape(trainpatches(i).gtpatch,1,w);
            k = k+1;
        end
        clear trainpatches;
    end
    saveMatFile(mfilename,gtmat,'gtmat','gtmat.mat',FP_FEAAUX,'');  %把11类label的矩阵变成向量，便于处理
    
    %% 生成NAF
    disp('生成NAFS...')
    rnode = cell(TN,1);
    for i = 1:TN
        % 1、选择特征
        fidx = randi([2,F_ALL+F_SIG+1],1,F_SEL);%从1至,F_ALL+F_SIG+1内随机抽取F_SEL个特征，这是坐标
        % 2、选择样本
        features = [];
        Is = [];
        sp = [0,0,0,0,0,0,0,0,0,0,0];   %一定要自己调整这个分片
        for j = 1:11
            disp(['提取样本' num2str(j) '/11']);
            for k = 0:sp(j)
                if k == 0
                    load([FP_TR_FEA num2str(j) '_trainFea.mat']);
                    disp(['加载' num2str(j) '_trainFea'])
                else
                    load([FP_TR_FEA num2str(j) '_trainFea_sp' num2str(k) '.mat']);
                    disp(['加载' num2str(j) '_trainFea_sp' num2str(k)])
                end

                if (size(fea,1) > ceil(S_EACH_SEL/(sp(j)+1)))  %fea表示每一类gt图像的个数*157
                    sidx = randi([1,size(fea,1)],1, ceil(S_EACH_SEL/(sp(j)+1)));   %生成随机的特征下标（意思就是随机选择特征值）
                    features = [features;fea(sidx,fidx)];  %随机选择的特征
                    Is = [Is;fea(sidx,1)];
                else
                    if (isempty(fea))
                        continue
                    else
                        features = [features;fea(:,fidx)];
                        Is = [Is;fea(:,1)];
                    end
                   
                end
            end
        end
        % 3、生成pairdist
        load([FP_FEAAUX 'gtmat.mat'])
        gtmat = gtmat(Is,:);  %gtmat.mat中的每一行都代表一个patch，随机选择patch
        len = length(gtmat);
        pairdist = zeros(len,len);
        for j = 1:len
            disp([num2str(j) '/' num2str(len)])
            andmat = xor(gtmat(j),gtmat);
            pairdist(j,:) = sum(andmat,2)/size(gtmat,2);   %计算像素的KNN距离
        end
        
        % 4、生成树
        curL = 1;%当前层深
        stdout(mfilename,['生成第' num2str(i) '棵树...']);
        [NAFtree] = makeNAFtree(Is,F_SCANNUM,SPLIT_STEP,LEAFNUM,MAXL,   pairdist,features,fidx,   curL);
        rnode{i,1} = NAFtree;
        saveMatFile(mfilename,NAFtree,'NAFtree',['NAF' num2str(i) '.mat'],FP_ROOT,'-v7.3');
    end
    
    saveMatFile(mfilename,rnode,'rnode','NAFrnode.mat',FP_ROOT,'-v7.3');
end