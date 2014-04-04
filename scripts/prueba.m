clear all
close all

clc

a=zeros(3,1);
b=zeros(3,1);


a(3)=-2.23622332;
a(2)=1.71885932;
a(1)=-.47223832;

b(1)=-0.05067732;
b(2)=.19535832;
b(3)=-.13463532;

delta=5;
gamma=.141417;




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
    suma=suma+y(l)^gamma*r(l);
end

c=sum(y)/suma;
b=c*b;

%%% Filtrado

y2=filter([b(1) b(2) b(3)],[1 a(3) a(2) a(1)],u2);




figure(1)
plot(y)

figure(2)
plot(y2,'r')


figure(3)
hold on
plot(y)
plot(y2,'r')
legend('Real','Estimada')
