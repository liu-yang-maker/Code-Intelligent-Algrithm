%%%%%%%%%%%%%%%%%%%%%%运用BP网络预测数据%%%%%%%%%%%%%%%%%%%%%%%%
clear all;                      %清除所有变量
close all;                      %清图
clc;                            %清屏
%%%%%%%%%%%%%%%%%%%%%%%%%%%%原始数据%%%%%%%%%%%%%%%%%%%%%%%%%%%%
p=[2056 2395 2600 2298 1634 1600 1873 1478 1900
   2395 2600 2298 1634 1600 1873 1478 1900 1500
   2600 2298 1634 1600 1873 1478 1900 1500 2046];%注意这里p是3*9的矩阵而不是1*12的行向量（换行就是一行）
t=[2298 1634 1600 1873 1478 1900 1500 2046 1556];%期望输出的结果
%%%%%%%%%%%%%%%%%%%%%%%%%%原始数据归一化%%%%%%%%%%%%%%%%%%%%%%%%%
pmax=max(max(p));
pmin=min(min(p));
P=(p-pmin)./(pmax-pmin);                 %输入数据矩阵
tmax=max(t);
tmin=min(t);
T=(t-tmin)./(tmax-tmin);                 %目标数据向量
%%%%%%%%%%%%%%%%%%%创建一个新的前向神经网络%%%%%%%%%%%%%%%%%%%%%%%
net=newff(minmax(P),[5,1],{'tansig','logsig'},'traingdx')
%%%%%%%%%%%%%%%%%%%%%%%设置训练参数%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
net.trainParam.show = 50;              %显示中间结果的周期
net.trainParam.lr = 0.05;              %学习率
net.trainParam.epochs = 1000;          %最大迭代次数
net.trainParam.goal = 1e-3;            %目标误差
%%%%%%%%%%%%%%%%%调用 TRAINGDM 算法训练 BP 网络%%%%%%%%%%%%%%%%%%
[net,tr]=train(net,P,T);
%%%%%%%%%%%%%%%%%%%%%对 BP 网络进行仿真%%%%%%%%%%%%%%%%%%%%%%%%%%
A = sim(net,P);
%%%%%%%%%%%%%%%%%%%%%%计算预测数据原始值%%%%%%%%%%%%%%%%%%%%%%%%%
a = A.*(tmax-tmin)+tmin;               
%%%%%%%%%%%%%%%%%%%%%绘制实际值和预测值曲线%%%%%%%%%%%%%%%%%%%%%%
x=4:12;
figure
plot(x,t,'+');
hold on;
plot(x,a,'or');
hold off
xlabel('月份')
ylabel('销量')
legend('实际销量 ','预测销量');
