function NAFmain
% -----------------------------------------------------------------------------
% 功能：NAF主程序
% 运行前需要：
%       运行 0globalset → addGlobalPath.m加入全局路径
% 运行前可以：
%      （1）0globalset → makeGlobalConst.m设定参数，生成const.mat文件
%      （2）0globalset → resetDatabase.m重新构建数据库文件目录，生成database目录
%      （3）把训练数据和测试数据放入database相应的目录并命名
% -----------------------------------------------------------------------------

    %% 预处理图像，切分成块像素patch
    %preprocess(0);
    
    %% 生成要采样的邻域特征位置
    %makeFeaPos();
    
    %% 训练NAF
    %NAFtrain();
    
    %% 预处理测试图像，切分成块像素
    %preprocess(1); 
    
    %% 提前简单看看选出的KNN的GT图像和要分割的GT图像差距大不大
    %NAFtest_knn();
    
    %% 测试图像
    NAFtest();
end