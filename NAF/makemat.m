function makemat(filedir,gtdir,outpath,imgext,dataname,filename,stnum,ednum)
% -------------------------------
% ����б仯����ȡ��ʽ�����Լ���д
% -------------------------------

    fileidx = 1;
    
    for i = stnum:ednum
        dirname = [filedir num2str(i) '\'];
        filelist = dir(dirname);
        len = length(filelist)-2; %��ȥ.��..
        stdout(mfilename,['����Ԥ�����' num2str(i-stnum+1) '/' num2str(ednum-stnum+1)  '��CT�ļ�...']);
        for j = 0: len-1
            name = [num2str(i) '-' num2str(j) imgext];
            imgdata(fileidx).ctid = i;
            imgdata(fileidx).slid = j;
            imgdata(fileidx).img = imread([dirname 'img-' name]);
            gtfile = [gtdir num2str(i) '\label-' name];
            gtdata = imread(gtfile);
            gtdata(gtdata == 255)=1; %��255�Ķ���1
            imgdata(fileidx).gt = gtdata;
            fileidx = fileidx + 1;
        end
    end
    
    saveMatFile(mfilename,imgdata,dataname,filename,outpath,'');
    stdout(mfilename,['���� ' num2str(fileidx-1) ' ��ͼ���ļ�']);
end