function NAFtree = makeNAFtree(Is,mnum,tper,delta,maxL   ,pairdist,features,fidx,   curL)
% -----------------------
% ���ܣ��ݹ�����NAF����
% -----------------------
    if (curL >= maxL || length(Is) < delta)%ֹͣ����1���ﵽ������ || ֹͣ����3��Is����С��delta
        NAFtree.m = -1;
        NAFtree.t = -1;
        NAFtree.Is = Is;
        NAFtree.child = [];
    else
        % -- Ѱ�һ�����������ֵ
        midx = randi([1,size(features,2)],1,mnum); %���ѡ��mnum����������������ﵽ����G�Ĳ��� m �� t
        bestG = -1;
        bestIsl = [];
        bestIsr = [];
        for i = 1:mnum%ɨ����ʵ�mʹ��G���i�ǵ�i������
            %disp(['i = ' num2str(i) 'midx = ' num2str(midx(i))]);
            minMval = max(-0.01,min(features(:,midx(i))));
            maxMval = max(features(:,midx(i)));
            if (minMval == maxMval)%ȫ����ȣ��������ҳ����ʵĻ��ֵ�
                continue;
            else
                stepL = (maxMval - minMval)/tper;
                CpIs = Cp(1:size(Is,1),pairdist);%���ÿ�μ��㶼��һ���ģ���˿�����ǰ���㡣Cp:����AvgDist
                for t = minMval:stepL:maxMval%����������ֵ
                    Isl = find(features(:,midx(i)) <= t);  %�ҵ�����ֵ<=����ֵ��������������
                    Isr = find(features(:,midx(i)) > t);   %�ҵ�����ֵ>����ֵ��������������
                    lensl = length(Isl);
                    lensr = length(Isr);
                    if (lensl <= 0 ||  lensr <= 0)%���ֵ���һ�࣬û������
                        continue;
                    else%����G
                        lens = length(Is);
                        %disp([datestr(now,31) '�����ڼ����' num2str(curL) '�㣬Is=' num2str(lens) '��Isl=' num2str(lensl) '��Isr=' num2str(lensr) '����' num2str(i) '/20��������t=' num2str(t) ]);
                        G = CpIs - (lensr/lens) * Cp(Isr,pairdist) - (lensl/lens) * Cp(Isl,pairdist);
                        %disp(['CpIs=' num2str(CpIs) '��G=' num2str(G)]);
                        if (G >= bestG)%�ҵ����õĻ��ֵ㣬��¼������m����ֵt�����G��>=����˼�ǣ����������ѣ���ôȡ���õ�ֵ����ȡ0��
                            NAFtree.m = fidx(midx(i));  %�����±�
                            NAFtree.t = t;
                            bestG = G;
                            bestIsl = Isl;
                            bestIsr = Isr;
                            disp(['��' num2str(curL) '��bestG�����bestG=' num2str(bestG)  '��m=' num2str(midx(i)) '��t=' num2str(t) ])
                        end
                    end
                end
            end
        end
        %��ʼͳ��
        if ( bestG< 0 )%ֹͣ����2�� v m ,t����G<0
            NAFtree.m = -1;
            NAFtree.t = -1;
            NAFtree.Is = Is;
            NAFtree.child = [];
        else%�ݹ齨��
            NAFtree.Is = [];
            NAFtree.child(1) = makeNAFtree(Is(bestIsl),mnum,tper,delta,maxL   ,pairdist(bestIsl,bestIsl),features(bestIsl,:),fidx,   curL+1);
            NAFtree.child(2) = makeNAFtree(Is(bestIsr),mnum,tper,delta,maxL   ,pairdist(bestIsr,bestIsr),features(bestIsr,:),fidx,   curL+1);
        end
        
    end
        
end