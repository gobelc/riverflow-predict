function []=GraficarEstaciones(lat,lon,lon_ruy,lat_ruy,tri)



figure(1)
hold on

%Dibujo Costa
coast = load('coast.mat');
latlim = [-50 -20];
lonlim = [-90 -30];
[latTrimmed, lonTrimmed] = maptrimp(coast.lat, coast.long, ...
    latlim, lonlim);
mapshow(lonTrimmed, latTrimmed, 'DisplayType', 'polygon');
plot(lon(:),lat(:),'+',lon_ruy,lat_ruy,'r','linewidth',2)
title('Estaciones, limite de la cuenca del Rio Uruguay')
axis([-90 -30 -50 -20])
xlabel('Longitud (º)')
ylabel('Latitud (º)')
legend('Continente','Estaciones','Limite de la Cuenca Media y Superior del Río Uruguay')


figure(2)
%Triangulaciones
trisurf(tri,lon,lat,zeros(1,length(lat)));
axis([-60 -47 -34 -24])
hold on
plot(lon(:),lat(:),'.',lon_ruy,lat_ruy,'r','linewidth',2)
title('Estaciones, limite de la cuenca del Rio Uruguay y triangulación de Delaunay')
axis([-60 -47 -34 -24])
xlabel('Longitud (º)')
ylabel('Latitud (º)')

end