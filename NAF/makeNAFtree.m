function NAFtree = makeNAFtree(Is,mnum,tper,delta,maxL   ,pairdist,features,fidx,   curL)
% -----------------------
% 功能：递归生成NAF的树
% -----------------------
    if (curL >= maxL || length(Is) < delta)%停止条件1：达到最大层深 || 停止条件3：Is个数小于delta
        NAFtree.m = -1;
        NAFtree.t = -1;
        NAFtree.Is = Is;
        NAFtree.child = [];
    else
        % -- 寻找划分特征和阈值
        midx = randi([1,size(features,2)],1,mnum); %随机选择mnum个特征进行穷尽搜索达到最大的G的参数 m 和 t
        bestG = -1;
        bestIsl = [];
        bestIsr = [];
        for i = 1:mnum%扫描合适的m使得G最大，i是第i个特征
            %disp(['i = ' num2str(i) 'midx = ' num2str(midx(i))]);
            minMval = max(-0.01,min(features(:,midx(i))));
            maxMval = max(features(:,midx(i)));
            if (minMval == maxMval)%全部相等，不可能找出合适的划分点
                continue;
            else
                stepL = (maxMval - minMval)/tper;
                CpIs = Cp(1:size(Is,1),pairdist);%这个每次计算都是一样的，因此可以提前计算。Cp:计算AvgDist
                for t = minMval:stepL:maxMval%遍历各个阈值
                    Isl = find(features(:,midx(i)) <= t);  %找到特征值<=分裂值的样本的索引们
                    Isr = find(features(:,midx(i)) > t);   %找到特征值>分裂值的样本的索引们
                    lensl = length(Isl);
                    lensr = length(Isr);
                    if (lensl <= 0 ||  lensr <= 0)%划分到了一侧，没有意义
                        continue;
                    else%计算G
                        lens = length(Is);
                        %disp([datestr(now,31) '：正在计算第' num2str(curL) '层，Is=' num2str(lens) '，Isl=' num2str(lensl) '，Isr=' num2str(lensr) '，第' num2str(i) '/20个特征，t=' num2str(t) ]);
                        G = CpIs - (lensr/lens) * Cp(Isr,pairdist) - (lensl/lens) * Cp(Isl,pairdist);
                        %disp(['CpIs=' num2str(CpIs) '，G=' num2str(G)]);
                        if (G >= bestG)%找到更好的划分点，记录下特征m，阈值t，最佳G，>=的意思是，如果都是最佳，那么取更好的值而不取0。
                            NAFtree.m = fidx(midx(i));  %特征下标
                            NAFtree.t = t;
                            bestG = G;
                            bestIsl = Isl;
                            bestIsr = Isr;
                            disp(['第' num2str(curL) '层bestG变更：bestG=' num2str(bestG)  '，m=' num2str(midx(i)) '，t=' num2str(t) ])
                        end
                    end
                end
            end
        end
        %开始统计
        if ( bestG< 0 )%停止条件2： v m ,t都有G<0
            NAFtree.m = -1;
            NAFtree.t = -1;
            NAFtree.Is = Is;
            NAFtree.child = [];
        else%递归建树
            NAFtree.Is = [];
            NAFtree.child(1) = makeNAFtree(Is(bestIsl),mnum,tper,delta,maxL   ,pairdist(bestIsl,bestIsl),features(bestIsl,:),fidx,   curL+1);
            NAFtree.child(2) = makeNAFtree(Is(bestIsr),mnum,tper,delta,maxL   ,pairdist(bestIsr,bestIsr),features(bestIsr,:),fidx,   curL+1);
        end
        
    end
        
end