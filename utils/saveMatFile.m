function saveMatFile(mname,data,dataname,filename,filepath,fileargv)
%���ã������ļ�
%����ʾ����saveMatFile(mfilename,a,'bala','a.mat','G:\��-����ҵ���\������\code\utils\','');
    disp('********************************************************************')
    disp(['**  ' datestr(now,31) '��' mname '.m�������ڱ����ļ�...' ])
    if (~strcmp(dataname,''))
        eval([dataname '=data;']);%�������������޸�
    end
    eval(['save ' filepath filename ' ' dataname ' ' fileargv]);%�����ļ�
    disp(['** ���ļ��Ѵ�����' filepath filename])
    disp(['** ��������Ϊ��' dataname])
    disp('********************************************************************')
end

% function test
%     a = 1;
%     saveMatFile(mfilename,a,'bala','a.mat','G:\��-����ҵ���\������\code\utils\','');
% end