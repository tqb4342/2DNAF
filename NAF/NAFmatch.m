function [pidx] = NAFmatch(node,features)
% -------------------------------------------
% ���ܣ�����NAF����ƥ�������������Ƶ�����Patches
% ���룺��ǰ�ڵ�node������������features
% �����patches��ѵ�����е��±�λ��pidx
% -------------------------------------------
    if (node.m == -1)%Ҷ�ӽڵ�
        pidx = node.Is;
    else
        if (features(node.m)<= node.t)
            pidx = NAFmatch(node.child(1),features); %������
        else
            pidx = NAFmatch(node.child(2),features);%������
        end
    end
end