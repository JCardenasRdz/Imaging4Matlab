clear all; close all; clc
%define variables
xdata=linspace(0,.5,100);
decay_rate=1/0.1;
ydata= exp(-xdata.*decay_rate);

% plot
plot(xdata,ydata);

% inline function
myfunc=@(x,rate) exp(-x.*rate);

% add noise
ywn=awgn(ydata,20,'measured');

% perform nonlinear fitting
initial_guess=4;
fitnlm(xdata,ywn,myfunc,[initial_guess])