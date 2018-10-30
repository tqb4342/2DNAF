function saveMatFile(mname,data,dataname,filename,filepath,fileargv)
%作用：保存文件
%调用示例：saveMatFile(mfilename,a,'bala','a.mat','G:\【-】毕业设计\正在做\code\utils\','');
    disp('********************************************************************')
    disp(['**  ' datestr(now,31) '（' mname '.m）：正在保存文件...' ])
    if (~strcmp(dataname,''))
        eval([dataname '=data;']);%变量名不进行修改
    end
    eval(['save ' filepath filename ' ' dataname ' ' fileargv]);%保存文件
    disp(['** 【文件已存至】' filepath filename])
    disp(['** 【数据名为】' dataname])
    disp('********************************************************************')
end

% function test
%     a = 1;
%     saveMatFile(mfilename,a,'bala','a.mat','G:\【-】毕业设计\正在做\code\utils\','');
% end