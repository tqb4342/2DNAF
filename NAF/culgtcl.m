function gtcl = culgtcl(gtpatch,lb)
% ------------------------
% 功能：计算gt图像所属类别
% ------------------------
    lbnum = numel(gtpatch(gtpatch==lb));
    gtcl = lbnum / size(gtpatch,1) /size(gtpatch,2);
end