function [Q]=qiuQ(A,deltaP,ro)   %�ɺ�����A��ѹ����deltaP�͸�ѹ��ȼ���ܶ�ro������Q
Q = 0.85*A.*sqrt(2*deltaP./ro)