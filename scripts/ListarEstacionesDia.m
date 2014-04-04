function [EstacionesDisponibles,DatoDisponible]=ListarEstacionesDia(numeroDiaInicio,numeroDiaFin)

% Esta función permite listar el conjunto de las estaciones que tienen
% datos de precipitaciones para un dia en particular.

numeroDia=datenum('22/07/1998','dd/mm/yyyy');
numeroDiaFin=datenum('22/07/2000','dd/mm/yyyy');
[A]=RecopilarDatosCoordenadas('estaciones_final.csv');   
cod=A{1};
encontre=0;

%DATOS ARGENTINA

for i=1:length(A{1})
%Argentina
    if str2double(cod(i))<300
        ID=char(cod(i))
        tic;
        [fecha,dato]=DatosArgentina(ID);
        a=toc

        for l=1:length(fecha)
            tic;
            n_fecha_arg=datenum(fecha(l),'dd/mm/yyyy');
            b=toc
            if n_fecha_arg==numeroDia;
                encontre=true
                indice=l;
            end
        end
        
        if encontre
            EstacionesDisponibles(i,1)=str2double(ID);
            DatoDisponible(i,2)=dato(l);
        end
    end
end
