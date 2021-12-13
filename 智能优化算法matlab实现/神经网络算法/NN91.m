%%%%%%%%%%%%%运用BP网络拟合白噪声的正弦样本数据%%%%%%%%%%%%%%%%
clear all;                      %清除所有变量
close all;                      %清图
clc;                            %清屏
%%%%%%%%%%%%%%%%%%%%%定义训练样本矢量%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%P 为输入矢量%%%%%%%%%%%%%%%%%%%%%%%%%%%%
P = [-1:0.05:1];
%%%%%%%%%%%%%%%%%%%%%%T 为目标矢量(期望输出)%%%%%%%%%%%%%%%%%%%%%%%%%%%%
T = sin(2*pi*P)+0.1*randn(size(P));
%%%%%%%%%%%%%%%%%%%%%%绘制样本数据点%%%%%%%%%%%%%%%%%%%%%%%%%%
figure
plot(P,T,'+');
hold on;
plot(P,sin(2*pi*P),':');
%%%%%%%%%%%%%%%%%%%%%绘制不含噪声的正弦曲线%%%%%%%%%%%%%%%%%%%
net=newff(minmax(P),[20,1],{'tansig','purelin'});
%%%%%%%%%%%%%%%%%%%采用贝叶斯正则化算法 TRAINBR%%%%%%%%%%%%%%%
net.trainFcn='trainbr';
%%%%%%%%%%%%%%%%%%%%%%设置训练参数%%%%%%%%%%%%%%%%%%%%%%%%%%%%
net.trainParam.show = 50;              %显示中间结果的周期
net.trainParam.lr = 0.05;              %学习率
net.trainParam.epochs = 500;           %最大迭代次数
net.trainParam.goal = 1e-3;            %目标误差
%%%%%%%%%%%%%%%%%%%%用相应算法训练 BP 网络%%%%%%%%%%%%%%%%%%%%
[net,tr]=train(net,P,T);
%%%%%%%%%%%%%%%%%%%%%对 BP 网络进行仿真%%%%%%%%%%%%%%%%%%%%%%%
A = sim(net,P);
%%%%%%%%%%%%%%%%%%%%%%计算仿真误差%%%%%%%%%%%%%%%%%%%%%%%%%%%%
E = T - A;
MSE=mse(E);
%%%%%%%%%%%%%%%%%%%%%%绘制匹配结果曲线%%%%%%%%%%%%%%%%%%%%%%%%
plot(P,A,P,T,'+',P,sin(2*pi*P),':');
legend('样本点','标准正弦曲线','拟合正弦曲线');
