clear all
close all

% Recolectar Datos

%Coordenadas estaciones

    %codigo_estacion=A{1}; nombre_estacion=A{3}; lat=A{4}; lon=A{5};

    [A]=RecopilarDatosCoordenadas('estaciones_filtro1.csv');
    lat=A{4};
    lon=A{5};
    cod=A{1};

%Coordenadas Cuenca Media y Superior del Rio Uruguay
file=fopen('cuenca_media_superior.txt');
A=textscan(file,'%f64 %f64 %s','Delimiter',';');
lat_ruy=A{2};
lon_ruy=A{1};
fclose(file);

%Escribo fichero .kml con las estaciones iniciales
kmlwrite('filtro1.kml', lat, lon)


%Calculo area cuenca (km2)
earthellipsoid = almanac('earth','ellipsoid','km','sphere');
area_cuenca=areaint(lat_ruy,lon_ruy,earthellipsoid); 


%Delaunay
tri = delaunay(lat(:),lon(:));

%Graficar estaciones, cuenca rio Uruguay, Triangulación Delauney
GraficarEstaciones(lat,lon,lon_ruy,lat_ruy,tri)



%Filtro de estaciones

%Si todos los segmentos de una tringulación no pertenecen a la Cuenca, las
%elimino y creo un nuevo listado de estaciones.


for i=1:length(cod) 
    codi(i)=str2num(cod(i));
end
