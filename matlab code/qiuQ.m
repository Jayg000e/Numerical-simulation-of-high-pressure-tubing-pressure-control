function [Q]=qiuQ(A,deltaP,ro)   %由横截面积A、压力差deltaP和高压侧燃油密度ro求流量Q
Q = 0.85*A.*sqrt(2*deltaP./ro)