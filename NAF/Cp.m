function [val] = Cp(Is,pdist)
% ----------------
% ���ܣ�����Cp
% ----------------
    npdist = pdist(Is,Is);
    val = sum(npdist(:))/(length(Is) * length(Is));
end