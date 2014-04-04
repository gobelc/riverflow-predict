function [a,b,gamma,y2] = graficarModelo(n,m,delta)



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

file=fopen('tabla_residuos.txt','w');
fprintf(file,'%s;%s;%s;%s;%s;%s;%s \n','n','m','delta','an--a1','bm--b1','gamma','resnorm'); 


f1=find(fecha==fecha_serie(1));
f2=find(fecha==fecha_serie(length(fecha_serie)));

fecha=fecha(f1:f2);
y=flujo(f1:f2);
dia1=datestr(datevec(fecha(1)),24);
dia2=datestr(datevec(fecha(length(fecha))),24);
cont=0;

%%% Defino f %%%


         
a=ones(n,1);
b=ones(m,1);
a2=.5*ones(1,3);
b2=.5*ones(1,3);

for j=1:n;
    a2(j)=a(j);
end

for l=1:m;
    
    b2(l)=b(l);
end

x0 = [-2.2,1.7,-.5;-.05,.2,-.1;.2 0 0];
f = @(x)parameterfun(x,delta,y,r,n,m);
[x,resnorm]=lsqnonlin(f,x0);

gamma=x(3,1);

for j=1:n;
    a(j)=x(1,n-j+1);
end

for l=1:m;
    b(l)=x(2,l);
end

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


    
        
        


        


