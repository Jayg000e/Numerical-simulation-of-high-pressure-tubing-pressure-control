function S=qiuS(h)      %�����뷧��������h���Ӧ�ĺ�����S
theta=pi/20;            %thetaΪ��Ŀ�����ܷ���Բ׶���
r1=0.7;                 %r1Ϊ���¶���װ뾶
r2=1.25;                %r2Ϊ�뷧�뾶
h0=r1/tan(theta);       
h1=r2/tan(theta)-h0;
R=tan(theta)*(h+h0+h1); %RΪ���������S�İ뾶
S=pi*(R.*R-r2*r2);