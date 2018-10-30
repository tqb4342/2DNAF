 function NAFtest
% -------------
% 功能：测试NAF
% -------------
    clc;clear;
    load '..\0globalset\const.mat'
    
    % 提取测试patch特征
%     load([FP_FEAAUX 'NAFfpos.mat'])
%     load([FP_TE_ORI 'test.mat'])
      load([FP_TE_ORI 'testpatches.mat']);
%     extNAFFeature(testimgdata,testpatches,NAFfpos,OVH,FP_TE_FEA,'test');
    
    
    % 测试patch的KNN
    load([FP_ROOT 'NAFrn ode.mat']);
    load([FP_TE_FEA 'testFea.mat']);
    len = length(testpatches); 
    for i = 1:len %遍历所有测试patches
        disp(['正在测试第' num2str(i) '/' num2str(len) '张patches' ]);
        pc = [];%计数桶
        for j = 1:TN%遍历所有的树
             pidx = NAFmatch(rnode{j,1},fea(i,:)); %把测试的feature向量进行遍历
             pc = [pc,pidx'];
        end
        tcount = tabulate(pc);
        tsort = sortrows(tcount,-2);
        pidxs(i).pidx = tsort(1:min(length(pc),KNN_K),1);
    end
    saveMatFile(mfilename,pidxs,'pidxs','testpidxs.mat',FP_RESULT,'');
    
    % 覆盖回图形上
    load([FP_TE_ORI 'test.mat'])
    for i = 1:length(testimgdata) %建立空白的0矩阵
        testimgdata(i).nafgt = zeros(size(testimgdata(i).gt));
    end
    load([FP_RESULT 'testpidxs.mat']) %pidxs
    disp('正在缓慢加载训练patch文件...')
    load([FP_TR_ORI 'trainpatches.mat']);%这里直接加载整个trainpatches到内存，如果不够可以改成要哪个加载哪个，不过这样测试会更慢。
    load ([FP_TE_ORI 'testpatches.mat'])%testpatches imgpatch fileidx mx my
    len = length(testpatches);
    for j = 1:len%遍历批次内所有testpatches
        disp([num2str(j) '/' num2str(len)]) 
        pidx = pidxs(j).pidx;
        for k = 1:KNN_K %只采用前五个
            a = trainpatches(pidx(k)).imgpatch;
            b = testpatches(j).imgpatch;
            if max(a(:)) == min(a(:))
                a(1,1) = a(1,1)+0.0001;
            end
            if max(b(:)) == min(b(:))
                b(1,1) = b(1,1)+0.0001;
            end

            nccvalue(k) = abs(corr2( a  ,  b ));               % CC
            nccvalue(k) = max(max(abs(normxcorr2(a,b))));       % NCC
        end
        [nccval,nccidx] = max(nccvalue);
        idx = testpatches(j).fileidx;
        mx = testpatches(j).mx;
        my = testpatches(j).my;
        nccgt = double(trainpatches(pidx(nccidx)).gtpatch);
        nccgt(nccgt==0) = -1;
        testgt = double(testimgdata(idx).nafgt(mx:mx+NPX-1,my:my+NPY-1));
        testimgdata(idx).nafgt(mx:mx+NPX-1,my:my+NPY-1) = testgt + nccgt;
    end
    
    disp('正在保存可视化图像')
    saveMatFile(mfilename,testimgdata,'NAFgt','NAFgt.mat',FP_FIG,'');

    %% 查看结果
    load([FP_FIG 'NAFgt.mat']);
    figure;
    for i = 1:length(NAFgt)
        subplot(1,3,1)
        imshow(NAFgt(i).img)
        title('彩色图像')
        subplot(1,3,2)
        imagesc(NAFgt(i).gt)
        title('标准gt')
        subplot(1,3,3)
        imagesc(NAFgt(i).nafgt)
        title('NAFgt')
        disp(num2str(i)) %这里加断点看结果 
        pause();
    end
end