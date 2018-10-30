function saveMatFile(mname,data,dataname,filename,filepath,fileargv)
%作用：保存文件
%调用示例：saveMatFile(mfilename,a,'bala','a.mat','G:\【-】毕业设计\正在做\code\utils\','');
    if (~strcmp(dataname,''))
        eval([dataname '=data;']);%变量名不进行修改
    end
    eval(['save ' filepath filename ' ' dataname ' ' fileargv]);%保存文件
    
%     if (strcmp(fileargv,'-append'))
%         if (~exist([filepath filename],'file'))
%             eval(['save ' filepath filename ' ' dataname]);%保存文件
%         else
%             eval(['save ' filepath filename ' ' dataname ' ' fileargv]);%保存文件
%         end
%     else
%         
%     end
   
end

% function test
%     a = 1;
%     saveMatFile(mfilename,a,'bala','a.mat','G:\【-】毕业设计\正在做\code\utils\','');
% end