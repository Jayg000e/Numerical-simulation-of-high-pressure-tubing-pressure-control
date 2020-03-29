function S=qiuS(h)      %根据针阀上升距离h求对应的横截面积S
theta=pi/20;            %theta为题目所给密封座圆锥半角
r1=0.7;                 %r1为最下端喷孔半径
r2=1.25;                %r2为针阀半径
h0=r1/tan(theta);       
h1=r2/tan(theta)-h0;
R=tan(theta)*(h+h0+h1); %R为所求横截面积S的半径
S=pi*(R.*R-r2*r2);