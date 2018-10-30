function saveh5File(mname,data,dataname,filename,filepath,fileargv)
%���ã������ļ�
%����ʾ����saveMatFile(mfilename,a,'bala','a.mat','G:\��-����ҵ���\������\code\utils\','');
    disp('********************************************************************')
    disp(['**  ' datestr(now,31) '��' mname '.m�������ڱ����ļ�...' ])
    
    if (isstruct(data))
        names = fieldnames(data);
        for i = 1:length(names)
            fieldname = ['/' names{i}];
            h5create([filepath filename],fieldname,sizeof(getfield(data,names{i})));
            h5write([filepath filename],fieldname,getfield(data,names{i}));
        end
    else
        h5create([filepath filename],['/' dataname]);
        h5write([filepath filename],['/' dataname],data);
    end
    
    disp(['** ���ļ��Ѵ�����' filepath filename])
    disp(['** �����ݼ�Ϊ��' dataname])
    disp('********************************************************************')
end

% function test
%     a = 1;
%     saveMatFile(mfilename,a,'bala','a.mat','G:\��-����ҵ���\������\code\utils\','');
% end