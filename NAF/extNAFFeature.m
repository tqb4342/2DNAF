function extNAFFeature(imgdata,patches,fpos,ovh,outpath,prename)
% --------------------------------------------------------------------------
% patchID / 均值 / 标准差 / 最小值 / 最大值 / 中位数 / 中心3×3的LBP / 邻域特征
% --------------------------------------------------------------------------
    clc
    load '..\0globalset\const.mat'
    
    len = length(patches);
    feaidx = 1;
    sp = 0;
    feature = [];
    for i = 1:len
        disp(['正在提取第' num2str(i) '/' num2str(len) '张patches的特征' ]);
        patchdata = double(patches(i).imgpatch)/255;  %像素值归一化
        ctrx = patches(i).ctrx;
        ctry = patches(i).ctry;
        fileidx = patches(i).fileidx;
        img = double(imgdata(fileidx).img)/255;      %像素值归一化
        dl = length(patchdata(:));
    %% 提取内部特征
        %% 提取颜色矩
        ui = mean(mean(patchdata)); %均值
        mi = ones(size(patchdata))*ui; %跟patch一样大小的矩阵，所有元素值都为patch的均值
        ti = (sum(sum((patchdata-ui).^2))/dl).^(1/2); %二阶,像素值标准差
        %% 提取颜色极值和中值
        hmin = min(min(patchdata));
        hmax = max(max(patchdata));
        hmid = median(patchdata(:));
        %% 提取简单LBP纹理
        binstr = '';
        jknum = [-1,-1;  -1,0;  -1,1;  0,1;  1,1;  1,0;  1,-1;  0,-1];
        jknum = [ctrx+jknum(:,1),ctry+jknum(:,2)];  
        for j = 1:length(jknum)
            if (img(jknum(j,:))>img(ctrx,ctry))   %提纹理特征的时候我觉得应该是patchdata(jknum(j,:))，而且大小应该要是3*3
                binstr = [binstr '1'];
            else
                binstr = [binstr '0'];
            end
        end
        clbp = bin2dec(binstr)/255;    %二进制字符串转化为十进制，LBP纹理特征（/255是为了归一化）
        %% 内部颜色值
    %% 提取外部特征
      %% 外部颜色值
        [sx,sy,sz] = size(img);   %这个地方应该也是patchdata，不是img
        for j = 1:length(fpos)
         x = ctrx + fpos(j,1);
         y = ctry + fpos(j,2);
         if (x>sx || y > sy || x <= 0 || y <= 0)    %超出边界的特征值设置为-1
             outf(j) = ovh;
         else
             outf(j) = img(x,y);
         end
        end
        feature(feaidx,:) = [patches(i).pid,ui,ti,hmin,hmax,hmid,clbp,outf];
        feaidx = feaidx + 1;
        if (mod(feaidx,FEA_SPLEN) == 0)
            sp = sp + 1;
            saveMatFile_nomsg(mfilename,feature,'fea',[prename 'Fea_sp' num2str(sp) '.mat'],outpath,'-v7.3');
            feaidx = 1;
            clear feature;
        end
        %saveMatFile_nomsg(mfilename,feature,'feature',['train' num2str(i) '.mat'],outpath,'');
    end
    saveMatFile(mfilename,feature,'fea',[prename 'Fea.mat'],outpath,'-v7.3');
end