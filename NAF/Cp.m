function [val] = Cp(Is,pdist)
% ----------------
% π¶ƒ‹£∫º∆À„Cp
% ----------------
    npdist = pdist(Is,Is);
    val = sum(npdist(:))/(length(Is) * length(Is));
end