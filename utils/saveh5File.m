function saveh5File(mname,data,dataname,filename,filepath,fileargv)
%作用：保存文件
%调用示例：saveMatFile(mfilename,a,'bala','a.mat','G:\【-】毕业设计\正在做\code\utils\','');
    disp('********************************************************************')
    disp(['**  ' datestr(now,31) '（' mname '.m）：正在保存文件...' ])
    
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
    
    disp(['** 【文件已存至】' filepath filename])
    disp(['** 【数据集为】' dataname])
    disp('********************************************************************')
end

% function test
%     a = 1;
%     saveMatFile(mfilename,a,'bala','a.mat','G:\【-】毕业设计\正在做\code\utils\','');
% end