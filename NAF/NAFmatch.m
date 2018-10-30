function [pidx] = NAFmatch(node,features)
% -------------------------------------------
% 功能：遍历NAF树，匹配与其特征类似的所有Patches
% 输入：当前节点node，测试特征：features
% 输出：patches在训练集中的下标位置pidx
% -------------------------------------------
    if (node.m == -1)%叶子节点
        pidx = node.Is;
    else
        if (features(node.m)<= node.t)
            pidx = NAFmatch(node.child(1),features); %左子树
        else
            pidx = NAFmatch(node.child(2),features);%右子树
        end
    end
end