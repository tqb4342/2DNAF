function NAFtrain
% -------------
% ���ܣ�ѵ��NAF
% -------------
    clc;clear;
    load '..\0globalset\const.mat'
        
    %% ��ȡpatches����������
    load([FP_FEAAUX 'NAFfpos.mat'])
    load([FP_TR_ORI 'train.mat'])
    for i = 1:11
        load([FP_TR_ORI num2str(i) '_trainpatches.mat']);
        extNAFFeature(trainimgdata,trainpatches,NAFfpos,OVH,FP_TR_FEA,[num2str(i) '_train']);
    end
    %% Ԥ����һ��GTMAT���Ѿ����Ϊ���������ڼ���pairdist
    w =  NPX*NPY;  %��Ĵ�С
    k = 1;
    for i = 1:11
        load([FP_TR_ORI num2str(i) '_trainpatches.mat']);
        len = length(trainpatches);
        for j = 1:len
            disp(['�����' num2str(i) '��ĵ�' num2str(j) '/' num2str(len) '��gtͼ��']);
            gtmat(k,:) = reshape(trainpatches(i).gtpatch,1,w);
            k = k+1;
        end
        clear trainpatches;
    end
    saveMatFile(mfilename,gtmat,'gtmat','gtmat.mat',FP_FEAAUX,'');  %��11��label�ľ��������������ڴ���
    
    %% ����NAF
    disp('����NAFS...')
    rnode = cell(TN,1);
    for i = 1:TN
        % 1��ѡ������
        fidx = randi([2,F_ALL+F_SIG+1],1,F_SEL);%��1��,F_ALL+F_SIG+1�������ȡF_SEL����������������
        % 2��ѡ������
        features = [];
        Is = [];
        sp = [0,0,0,0,0,0,0,0,0,0,0];   %һ��Ҫ�Լ����������Ƭ
        for j = 1:11
            disp(['��ȡ����' num2str(j) '/11']);
            for k = 0:sp(j)
                if k == 0
                    load([FP_TR_FEA num2str(j) '_trainFea.mat']);
                    disp(['����' num2str(j) '_trainFea'])
                else
                    load([FP_TR_FEA num2str(j) '_trainFea_sp' num2str(k) '.mat']);
                    disp(['����' num2str(j) '_trainFea_sp' num2str(k)])
                end

                if (size(fea,1) > ceil(S_EACH_SEL/(sp(j)+1)))  %fea��ʾÿһ��gtͼ��ĸ���*157
                    sidx = randi([1,size(fea,1)],1, ceil(S_EACH_SEL/(sp(j)+1)));   %��������������±꣨��˼�������ѡ������ֵ��
                    features = [features;fea(sidx,fidx)];  %���ѡ�������
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
        % 3������pairdist
        load([FP_FEAAUX 'gtmat.mat'])
        gtmat = gtmat(Is,:);  %gtmat.mat�е�ÿһ�ж�����һ��patch�����ѡ��patch
        len = length(gtmat);
        pairdist = zeros(len,len);
        for j = 1:len
            disp([num2str(j) '/' num2str(len)])
            andmat = xor(gtmat(j),gtmat);
            pairdist(j,:) = sum(andmat,2)/size(gtmat,2);   %�������ص�KNN����
        end
        
        % 4��������
        curL = 1;%��ǰ����
        stdout(mfilename,['���ɵ�' num2str(i) '����...']);
        [NAFtree] = makeNAFtree(Is,F_SCANNUM,SPLIT_STEP,LEAFNUM,MAXL,   pairdist,features,fidx,   curL);
        rnode{i,1} = NAFtree;
        saveMatFile(mfilename,NAFtree,'NAFtree',['NAF' num2str(i) '.mat'],FP_ROOT,'-v7.3');
    end
    
    saveMatFile(mfilename,rnode,'rnode','NAFrnode.mat',FP_ROOT,'-v7.3');
end