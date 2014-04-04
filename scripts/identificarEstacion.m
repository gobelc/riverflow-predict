function [i1,i2,i3] = identificarEstacion(lat,lon,lat_estacion,lon_estacion)
%IDENTIFICARESTACION Summary of this function goes here
%   Detailed explanation goes here



ind1=find(lat==lat_estacion(1));


% Si hay dos estaciones con la misma latitud, identifico la buscada por la longitud.

if length(ind1)~=1
    for j=1:length(ind1)
        a=ind1(j);
        if lon(a)==lon_estacion(1)
            i1=ind1(j);
        end
    end
end
    



ind2=find(lat==lat_estacion(2));

if length(ind2)~=1
    for j=1:length(ind2)
        a=ind2(j);
        if lon(a)==lon_estacion(2)
            i2=ind2(j);
        end
    end   

end

ind3=find(lat==lat_estacion(3));

if length(ind3)~=1
    for j=1:length(ind3)
        a=ind3(j);
        if lon(a)==lon_estacion(3)
            i3=ind3(j);
        end
    end
 
end

if length(ind1)==1
i1=ind1;
end

if length(ind2)==1
i2=ind2;
end

if length(ind3)==1
i3=ind3;
end



