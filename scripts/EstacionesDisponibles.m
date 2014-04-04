function [estaciones lat lon precipitaciones] = EstacionesDisponibles(n_dia)
%ESTACIONDISPONIBLE Summary of this function goes here
%   Devuelve el listado de estaciones que tienen datos de n_dia

[A lat2 lon2]=RecopilarDatosCoordenadas('estaciones_final.csv');   
cod=A(:,1);
a=1;
precipitaciones=0;
hay_dato=true;

for j=1:length(cod);
    

        ID=cod{j};
        A1=importdata(strcat('./ventana/',ID,'.txt'),';');
        if  size(A1)~=[0,0]
            fecha1=A1(:,1);
            preci1=A1(:,2);
            I1=find(fecha1==n_dia);
            k=I1;
            hay_dato=~isnan(preci1(k));
            if (I1~=0) & (hay_dato==1)
                estaciones(a)=cod(j);
                precipitaciones(a)=preci1(k);
                lat(a)=lat2(j);
                lon(a)=lon2(j);
                a=a+1;
            end
        end
    end
    


end

