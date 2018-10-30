function makemat(filedir,gtdir,outpath,imgext,dataname,filename,stnum,ednum)
% -------------------------------
% 如果有变化，提取方式建议自己重写
% -------------------------------

    fileidx = 1;
    
    for i = stnum:ednum
        dirname = [filedir num2str(i) '\'];
        filelist = dir(dirname);
        len = length(filelist)-2; %除去.和..
        stdout(mfilename,['正在预处理第' num2str(i-stnum+1) '/' num2str(ednum-stnum+1)  '个CT文件...']);
        for j = 0: len-1
            name = [num2str(i) '-' num2str(j) imgext];
            imgdata(fileidx).ctid = i;
            imgdata(fileidx).slid = j;
            imgdata(fileidx).img = imread([dirname 'img-' name]);
            gtfile = [gtdir num2str(i) '\label-' name];
            gtdata = imread(gtfile);
            gtdata(gtdata == 255)=1; %把255的都变1
            imgdata(fileidx).gt = gtdata;
            fileidx = fileidx + 1;
        end
    end
    
    saveMatFile(mfilename,imgdata,dataname,filename,outpath,'');
    stdout(mfilename,['共计 ' num2str(fileidx-1) ' 个图像文件']);
end