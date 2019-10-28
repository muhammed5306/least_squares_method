clc; clear all; close all;

%Random ve X ve Y Degerlerinin Üretilmesi ve TXT Dosyasina Yazdirilmasi

% x = unifrnd(1,100,[1 100]);
% y = unifrnd(1,100,[1 100]);

% csvwrite('data_x.txt',x);
% csvwrite('data_y.txt',y);

%TXT Dosyalarindaki Verilerin Import Edilmesi

x = importdata('data_x.txt');
y = importdata('data_y.txt');

%Degiskenlerin Tanimlanmasi

x_sum = 0;
y_sum = 0;
x_to_two_sum = 0;
x_multiply_y_sum = 0;

x_min = min(x);
x_max = max(x);
y_min = min(y);
y_max = max(y);

x_to_two = [];
x_multiply_y = [];

new_x = [];
new_y = [];

N=length(x);m=0;b=0;

%Normalizasyon Islemi

for i=1:100
    new_x(i) = (x(i)-x_min)/(x_max-x_min);
    new_y(i) = (y(i)-y_min)/(y_max-y_min);
end

%x^2, x*y, ?x, ?y, ?x^2, ?xy Islemleri

for i=1:100
    x_to_two(i) = new_x(i)*new_x(i);                       %x^2
    x_multiply_y(i) = new_x(i) * new_y(i);                 %xy
    x_sum = x_sum + new_x(i);                              %?x
    y_sum = y_sum + new_y(i);                              %?y
    x_to_two_sum = x_to_two_sum + x_to_two(i);             %?Sx^2
    x_multiply_y_sum = x_multiply_y_sum + x_multiply_y(i); %?xy
end

%m ve b Degerlerinin Hesaplanmasi

m = ((N * x_multiply_y_sum) - (x_sum - y_sum)) / ((N * x_to_two_sum) - ((x_sum)^2));
b = (y_sum - (m * x_sum)) / N;

% y = mx + b Denkleminde m ve b Degerleri Girilerek Kullanicidan Alinan X
% Degeri ile Yeni y Degerinin Hesaplanmasi

new_new_y = 0; 
new_new_x = input('X degerini giriniz : ');

new_new_y = (new_new_x*m) + b;

%Best Fit Dogrusunun Hesaplanmasi, X ve Y Degerlerinin Koordinat Sisteminde
%Gösterimi

coefficients = polyfit(new_x, new_y, 1);
xFit = linspace(min(new_x), max(new_x), 1000);
yFit = polyval(coefficients , xFit);
hold on;
plot(xFit, yFit, 'r-', 'LineWidth', 2);
grid on;
figure,plot(new_x,new_y,'o');

    