 function makepatches(px,py,ix,iy,imgdata,dataname,filename,outpath) %30 30 8 8
% ---------------------
% ���ܣ�����������patch
% ---------------------
    len = length(imgdata);
    patchidx = 1;
    for fileidx = 1:len
        img = imgdata(fileidx).img;
        gt = imgdata(fileidx).gt;
         [sx,sy,sz]=size(img);
         for x = 1:ix:sx %ԭ�������Ͻǣ�X�����£�Y������
                if  (sx-x < px)  
                    mx = sx - px +1; 
                else
                    mx = x; 
                end
                for y = 1:iy:sy%����ɨ��
                    if (sy - y < py)
                        my = sy - py+1;
                    else
                        my = y;
                    end
                    %����
                    imgpatch = img(mx:mx+px-1,my:my+py-1,1:sz);
                    gtpatch = gt(mx:mx+px-1,my:my+py-1);
                    patches(patchidx).imgpatch = imgpatch;%��ɫͼ��
                    patches(patchidx).gtpatch = gtpatch;%gtͼ��
                    patches(patchidx).fileidx = fileidx;%������ͼ���ļ�ID
                    patches(patchidx).mx = mx;%�����������X
                    patches(patchidx).my = my;%�����������Y
                    patches(patchidx).ctrx = ceil(mx+px/2 -1);%�������X����
                    patches(patchidx).ctry = ceil(my+py/2 -1);%�������Y����
                    patches(patchidx).gtcl = culgtcl(gtpatch,1);%��Ӧ����ı�ǩ����������Ϊ1������ֵ����ռ�����ظ����ı���
                    patches(patchidx).pid = patchidx;%PID
                    patchidx = patchidx +1;
                    if (sy - y < py) %������ʱ��ֻȡһ����
                        break
                    end
                end
                if  (sx-x < px)  %������ʱ��ֻȡһ����
                    break
                end
         end
         stdout(mfilename,['��' num2str(fileidx) '��ͼ�з����'])
    end
    %�ֿ���
     gtcl = [patches.gtcl];
     for i = 1:11 %%11��
         idx = (gtcl >= (i-1)/10 & gtcl < i/10);
         if (i == 1)
            saveMatFile(mfilename,patches(idx),dataname,[num2str(i) '_' filename],outpath,'-v7.3');
         else
            saveMatFile(mfilename,patches(idx),dataname,[num2str(i) '_' filename],outpath,'-v7.3');
         end
     end
     %��ϴ�
    saveMatFile(mfilename,patches,dataname,filename,outpath,'-v7.3');
end