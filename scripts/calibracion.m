clear all
close all
clc

file=fopen('./series_generadas/2003-2004-2005.txt','r');
A=textscan(file,'%u %f %f %u','delimiter',';');
fecha_serie=A{1};
flujo_serie=A{2};
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
flujo=flujo(f1:f2);
dia1=datestr(datevec(fecha(1)),24);
dia2=datestr(datevec(fecha(length(fecha))),24);

l=length(flujo);

gamma=.9281;
c=.94;
delta=2;
B=[.102 -.1002];
A=[-1.821 .823];


a1=c*flujo.^(gamma).*flujo_serie;

h = dfilt.delay(delta);



[ACF, lags, bounds] = autocorr(a1, [], 2);


R=toeplitz(ACF);
mu_max=2/(max(eig(R)));
mu=.000000005;





M=32;
e=zeros(l,1);
w=zeros(M,l);
ecm=zeros(1,l);
iter=100;
x=ones(M,1);
d=flujo;

for n=1:length(flujo)
    
    for i=1:M
        if (n-M+i)>0
            x(i)=a1(n-M+i);
        end
    end
    
    e(n)=flujo(n)-w(:,n)'*x;
    w(:,n+1)=w(:,n)+x*e(n)*mu;
    ecm(n)=(e(n)-d(n))^2;
end



plot(fecha,ecm)

