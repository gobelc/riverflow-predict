clear all
close all

clc


n=3;
m=2;

a=zeros(n,1);
b=zeros(m,1);

% 3 3 4 -0.43448032 1.63626032 -2.18702032 -0.00958532 0.02030732 -0.00607732 0.30327132 0.00000032 41613141.39276832 
% 3 2 4 -0.43309532 1.63377232 -2.18598932 0.00454432 -0.00075032 0.32689832 0.00000032 41654068.26122432 
a(1)=-2.18598932;
a(2)=1.63377232;
a(3)=-0.43309532;

% b(3)=0.00454432;
b(2)=0.00454432;
b(1)=-0.00075032;

delta=4;
gamma=0.32689832;



%%% Genero r(t), y(t) %%%

file=fopen('./series_generadas/2003-2004-2005.txt','r');
A=textscan(file,'%u %f %f %u','delimiter',';');
fecha_serie=A{1};
r=A{2};
area_cobert=A{3};
numero_est=A{4};
fclose(file);

file2=fopen('caudal_pdll.txt','r');
B=textscan(file,'%s %s %f64 %s','delimiter',';','headerlines',4);
fecha=datenum(B{1},'dd/mm/yyyy');
flujo=B{3};
fclose(file2);

f1=find(fecha==fecha_serie(1));
f2=find(fecha==fecha_serie(length(fecha_serie)));

fecha=fecha(f1:f2);
y=flujo(f1:f2);
dia1=datestr(datevec(fecha(1)),24);
dia2=datestr(datevec(fecha(length(fecha))),24);

u=y.^(gamma).*r;

h = dfilt.delay(delta);

for j=delta+1:length(u)
    u2(j)=u(j-delta);
end



%%% Normalizacion
suma=0;

for l=1:length(y)
    suma=suma+(y(l)^gamma*r(l));
end

c=(sum(y)/suma)^(1/3);
b=b/c;

%%% Filtrado 

a=vertcat(1,a);

y2=filter(b,a,u2);




figure(1)
plot(y)

figure(2)
plot(y2,'r')


figure(3)
hold on
plot(y)
plot(y2,'r','LineWidth',2)
legend('Real','Estimada')
