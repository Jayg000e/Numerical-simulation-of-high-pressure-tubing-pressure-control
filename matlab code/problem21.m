function problem21(omega) %以模型第二题假设一为基础，根据输入的不同角速度计算最终对压力的影响并画出图像，从而确定合理的角速度范围

%如果需要更改模型运作的总时长，请更改下面的变量totali
periodi=ceil(2*pi/omega*100);   %凸轮以角速度omega转动一周的周期periodi，单位0.01ms
totali=100*periodi;         %测试模型运作的总时间totali，单位0.01ms
hneedle=[0 1.2337E-06 0.000019739 0.000099928 0.00031581 0.00077096 0.0015984 0.0029607 0.005049 0.0080834 0.012312 0.018008 0.025473 0.035029 0.047021 0.061809 0.079768 0.10128 0.12674 0.15651 0.19098 0.23049 0.27535 0.32583 0.38214 0.44443 0.51275 0.58705 0.66718 0.75283 0.84357 0.93878 1.0377 1.1393 1.2426 1.3461 1.4484 1.5477 1.6423 1.73 1.809 1.8771 1.9321 1.972 1.995 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 1.9942 1.9704 1.9296 1.8739 1.8052 1.7258 1.6376 1.5427 1.4432 1.3409 1.2373 1.1341 1.0326 0.93382 0.83882 0.74833 0.66296 0.58312 0.50912 0.44111 0.37912 0.32311 0.27292 0.22835 0.18911 0.15488 0.12534 0.10009 0.078769 0.060981 0.046344 0.034486 0.025044 0.017677 0.012063 0.0079019 0.0049215 0.0028753 0.0015448 0.00073997 0.0003 0.000093301 0.000017801 1.0005E-06 0 ];%根据题目所给数据导入针阀随时间变化的移动距离矩阵hneedle
C=0.85;                     %流量系数C
A1=pi*0.7*0.7;              %直径为1.4mm的供油入口A处的小孔面积A1
vrem=20;                    %柱塞运动到上止点时柱塞腔残余容积vrem
hmax=7.239;                 %凸轮极径长度的最大值hmax
rpump=2.5;                  %柱塞腔半径rpump
t=zeros(totali,1);          %时间t(i)，单位ms
fi=zeros(totali,1);         %i时间凸轮的角度fi(i)
hpump=zeros(totali,1);      %i时间柱塞腔内柱塞的高度hpump(i)
vpump=zeros(totali,1);      %i时间柱塞腔内剩余油量体积vpump(i)
ropump=zeros(totali,1);     %i时间柱塞腔内剩余油量密度ropump(i)
ppump=zeros(totali,1);      %i时间柱塞腔内剩余油量压力ppump(i)
mpump=zeros(totali,1);      %i时间柱塞腔内剩余油量质量mpump(i)
mpipe=zeros(totali,1);      %i时间高压油管内油量质量mpipe(i)
ropipe=zeros(totali,1);     %i时间高压油管内油量密度ropipe(i)
ppipe=zeros(totali,1);      %i时间高压油管内油量压力ppipe(i)
pumpin=zeros(totali,1);     %i时间高压油管进油量pumpin(i)
pumpout=zeros(totali,1);    %i时间高压油管出油量pumpout(i)
V=pi*500*5*5;               %高压油管体积V
mpipe(1)=V*0.85;            %初始化高压油管内初始油量质量
hpump(1)=2.413;             %初始化柱塞腔内柱塞的初始高度
vpump(1)=vrem+rpump*rpump*pi*(hmax-hpump(1));   %初始化柱塞腔内初始油量体积
mpump(1)=roF(0.5)*vpump(1);     %初始化柱塞腔内初始油量质量

for i=1:totali        %将整个时间段划分为totali个区间，每个区间为0.01ms，利用数值积分方法计算结果，每个出油周期为100ms，即10000次循环为一出油周期
    if rem(i,10000)<=246&&rem(i,10000)~=0   
        ti=rem(i,10000);    %计算每个出油周期中喷油嘴针阀运动到的当前时间ti
    else 
        ti=1;       %如果当前时间喷油嘴不在运作，则令ti=1，即当前针阀高度为0
    end
    if rem(i,periodi)==1&&i~=1  %如果当前时间刚好进入一个新的周期，则重新初始化柱塞腔内油量质量与柱塞腔内油量密度
        mpump(i)=mpump(1);
        ropump(i)=roF(0.5);
    end
    t(i)=i/100;                                     %换算使t(i)单位为ms
    fi(i)=omega*t(i);                               %根据时间t(i)计算当前角速度f(i)
    hpump(i)=-2.413*cos(fi(i))+4.826;               %根据之前拟合的角度与柱塞高度关系式计算当前柱塞高度
    vpump(i)=vrem+rpump*rpump*pi*(hmax-hpump(i));
    ropump(i)= mpump(i)/vpump(i);
    ropipe(i)= mpipe(i)/V;
    ppump(i)=Fro(ropump(i));        %根据之前拟合的密度与压力关系式计算当前压力
    ppipe(i)=Fro(ropipe(i));
    if ppump(i)>ppipe(i)    %如果当前柱塞腔内压力大于高压油管压力，则单向阀开启，根据流量公式计算当前高压油管进油量pumpin(i)
        pumpin(i)=C*A1*sqrt(2*(ppump(i)-ppipe(i))/ropump(i))*ropump(i)*0.01;
    end
    if rem(fi(i),2*pi)>pi   %如果当前时间柱塞处于下降状态，则单向阀关闭，高压油管进油量为0
        pumpin(i)=0;
        ropump(i)=ropump(i-1);  %当前时间柱塞处于下降状态，单向阀和喷油嘴都处于关闭状态，柱塞腔内密度的降低不影响高压油管内压力，这段时间柱塞腔内密度变化不予研究
    end
    pumpout(i)=C*qiuS(hneedle(ti))*sqrt(2*ppipe(i)/ropipe(i))*ropipe(i)*0.01;   %根据流量公式，已经设定好的qiuS函数和针阀当前高度hneedle(i)计算高压油管出油量
    mpipe(i+1)=mpipe(i)+pumpin(i)-pumpout(i);       %递推下一i时间内高压油管内油量质量及柱塞腔内油量质量
    mpump(i+1)=mpump(i)-pumpin(i);
end

%disp(mpipe(totali)-mpipe(1))    
%t(i+1)=t(i)+0.01;
scatter(t,ppipe,1);         %绘制高压油管内压力随时间的变化图像以查看结果
title('凸轮以角速度0.0471rad/ms转动100周压力随时间的变化');
xlabel('时间/ms');
ylabel('压力/MPa');