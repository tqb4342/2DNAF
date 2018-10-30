 function makepatches(px,py,ix,iy,imgdata,dataname,filename,outpath) %30 30 8 8
% ---------------------
% 功能：制作块像素patch
% ---------------------
    len = length(imgdata);
    patchidx = 1;
    for fileidx = 1:len
        img = imgdata(fileidx).img;
        gt = imgdata(fileidx).gt;
         [sx,sy,sz]=size(img);
         for x = 1:ix:sx %原点在左上角，X轴向下，Y轴向右
                if  (sx-x < px)  
                    mx = sx - px +1; 
                else
                    mx = x; 
                end
                for y = 1:iy:sy%横向扫描
                    if (sy - y < py)
                        my = sy - py+1;
                    else
                        my = y;
                    end
                    %操作
                    imgpatch = img(mx:mx+px-1,my:my+py-1,1:sz);
                    gtpatch = gt(mx:mx+px-1,my:my+py-1);
                    patches(patchidx).imgpatch = imgpatch;%彩色图像
                    patches(patchidx).gtpatch = gtpatch;%gt图像
                    patches(patchidx).fileidx = fileidx;%所属的图像文件ID
                    patches(patchidx).mx = mx;%相对左上坐标X
                    patches(patchidx).my = my;%相对左上坐标Y
                    patches(patchidx).ctrx = ceil(mx+px/2 -1);%相对中心X坐标
                    patches(patchidx).ctry = ceil(my+py/2 -1);%相对中心Y坐标
                    patches(patchidx).gtcl = culgtcl(gtpatch,1);%对应存入的标签，返回像素为1的像素值个数占总像素个数的比例
                    patches(patchidx).pid = patchidx;%PID
                    patchidx = patchidx +1;
                    if (sy - y < py) %当不够时，只取一个了
                        break
                    end
                end
                if  (sx-x < px)  %当不够时，只取一个了
                    break
                end
         end
         stdout(mfilename,['第' num2str(fileidx) '幅图切分完成'])
    end
    %分开存
     gtcl = [patches.gtcl];
     for i = 1:11 %%11类
         idx = (gtcl >= (i-1)/10 & gtcl < i/10);
         if (i == 1)
            saveMatFile(mfilename,patches(idx),dataname,[num2str(i) '_' filename],outpath,'-v7.3');
         else
            saveMatFile(mfilename,patches(idx),dataname,[num2str(i) '_' filename],outpath,'-v7.3');
         end
     end
     %混合存
    saveMatFile(mfilename,patches,dataname,filename,outpath,'-v7.3');
end