function remkdir(dirname)
%���ã����´����ļ��У�����ɾ����
    if exist(dirname) 
        rmdir(dirname,'s')
    end 
    mkdir(dirname);
end