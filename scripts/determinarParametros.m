
clear all
close all
clc

nombre_fichero='tabla_residuos3.txt';

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

file=fopen(nombre_fichero,'w');
fprintf(file,'%s;%s;%s;%s;%s;%s;%s \n','n','m','delta','an--a1','bm--b1','gamma','resnorm'); 


f1=find(fecha==fecha_serie(1));
f2=find(fecha==fecha_serie(length(fecha_serie)));

fecha=fecha(f1:f2);
y=flujo(f1:f2);
dia1=datestr(datevec(fecha(1)),24);
dia2=datestr(datevec(fecha(length(fecha))),24);
cont=0;

%%% Defino f %%%

for n=2:3
    for m=4:4
        for delta=1:10
         
           
        a=ones(1,n);
        b=ones(1,m);
        a2=.5*ones(1,4);
        b2=.5*ones(1,4);
        
        for j=1:n;
            a2(j)=a(j);
        end

        for l=1:m;
            
            b2(l)=b(l);
        end
        
        x0 = [-2.2,1.7,-.5,.5;-.05,.2,-.1,.5;.2 0 0 0];
        f = @(x)parameterfun(x,delta,y,r,n,m);
        [x,resnorm]=lsqnonlin(f,x0);
        cont=cont+1
        file=fopen(nombre_fichero,'a');
        fprintf(file,'%u;%u;%u;',n,m,delta);   
        
        for j=1:n
        fprintf(file,'%f32;',x(1,j));    
        end
        
        
        for j=n+1:3
        fprintf(file,';');   
        end
        
        for k=1:m
        fprintf(file,'%f32;',x(2,k));    
        end
        
        for j=m+1:3
        fprintf(file,';');   
        end
        
        
        fprintf(file,'%f32;%f32;\n',x(3,1),resnorm);
        fclose(file);
        
        
        
        end
    end
end

        
