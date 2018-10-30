function remkdir(dirname)
%作用：重新创建文件夹（有则删除）
    if exist(dirname) 
        rmdir(dirname,'s')
    end 
    mkdir(dirname);
end