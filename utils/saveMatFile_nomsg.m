function saveMatFile(mname,data,dataname,filename,filepath,fileargv)
%���ã������ļ�
%����ʾ����saveMatFile(mfilename,a,'bala','a.mat','G:\��-����ҵ���\������\code\utils\','');
    if (~strcmp(dataname,''))
        eval([dataname '=data;']);%�������������޸�
    end
    eval(['save ' filepath filename ' ' dataname ' ' fileargv]);%�����ļ�
    
%     if (strcmp(fileargv,'-append'))
%         if (~exist([filepath filename],'file'))
%             eval(['save ' filepath filename ' ' dataname]);%�����ļ�
%         else
%             eval(['save ' filepath filename ' ' dataname ' ' fileargv]);%�����ļ�
%         end
%     else
%         
%     end
   
end

% function test
%     a = 1;
%     saveMatFile(mfilename,a,'bala','a.mat','G:\��-����ҵ���\������\code\utils\','');
% end