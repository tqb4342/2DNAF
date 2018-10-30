function extNAFFeature(imgdata,patches,fpos,ovh,outpath,prename)
% --------------------------------------------------------------------------
% patchID / ��ֵ / ��׼�� / ��Сֵ / ���ֵ / ��λ�� / ����3��3��LBP / ��������
% --------------------------------------------------------------------------
    clc
    load '..\0globalset\const.mat'
    
    len = length(patches);
    feaidx = 1;
    sp = 0;
    feature = [];
    for i = 1:len
        disp(['������ȡ��' num2str(i) '/' num2str(len) '��patches������' ]);
        patchdata = double(patches(i).imgpatch)/255;  %����ֵ��һ��
        ctrx = patches(i).ctrx;
        ctry = patches(i).ctry;
        fileidx = patches(i).fileidx;
        img = double(imgdata(fileidx).img)/255;      %����ֵ��һ��
        dl = length(patchdata(:));
    %% ��ȡ�ڲ�����
        %% ��ȡ��ɫ��
        ui = mean(mean(patchdata)); %��ֵ
        mi = ones(size(patchdata))*ui; %��patchһ����С�ľ�������Ԫ��ֵ��Ϊpatch�ľ�ֵ
        ti = (sum(sum((patchdata-ui).^2))/dl).^(1/2); %����,����ֵ��׼��
        %% ��ȡ��ɫ��ֵ����ֵ
        hmin = min(min(patchdata));
        hmax = max(max(patchdata));
        hmid = median(patchdata(:));
        %% ��ȡ��LBP����
        binstr = '';
        jknum = [-1,-1;  -1,0;  -1,1;  0,1;  1,1;  1,0;  1,-1;  0,-1];
        jknum = [ctrx+jknum(:,1),ctry+jknum(:,2)];  
        for j = 1:length(jknum)
            if (img(jknum(j,:))>img(ctrx,ctry))   %������������ʱ���Ҿ���Ӧ����patchdata(jknum(j,:))�����Ҵ�СӦ��Ҫ��3*3
                binstr = [binstr '1'];
            else
                binstr = [binstr '0'];
            end
        end
        clbp = bin2dec(binstr)/255;    %�������ַ���ת��Ϊʮ���ƣ�LBP����������/255��Ϊ�˹�һ����
        %% �ڲ���ɫֵ
    %% ��ȡ�ⲿ����
      %% �ⲿ��ɫֵ
        [sx,sy,sz] = size(img);   %����ط�Ӧ��Ҳ��patchdata������img
        for j = 1:length(fpos)
         x = ctrx + fpos(j,1);
         y = ctry + fpos(j,2);
         if (x>sx || y > sy || x <= 0 || y <= 0)    %�����߽������ֵ����Ϊ-1
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