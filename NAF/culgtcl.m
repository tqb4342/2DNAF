function gtcl = culgtcl(gtpatch,lb)
% ------------------------
% ���ܣ�����gtͼ���������
% ------------------------
    lbnum = numel(gtpatch(gtpatch==lb));
    gtcl = lbnum / size(gtpatch,1) /size(gtpatch,2);
end