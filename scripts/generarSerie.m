function []=generarSerie();

% Genero la Serie de Precipitaciones en cierta ventana temporal


%%%%%%%%%%%%%% Ventana de Datos %%%%%%%%%%%%%%

FechaInicio=input('Fecha de inicio [dd/mm/yyyy]: \n','s');
FechaFin=input('Fecha de cierre [dd/mm/yyyy]: \n','s');
Nombre=input('Ingreso el nombre del fichero a generar: \n','s');
NombreFichero=strcat('./series_generadas/',Nombre,'.txt');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

fecha1=datenum(FechaInicio,'dd/mm/yyyy');
fecha2=datenum(FechaFin,'dd/mm/yyyy');


fecha=[fecha1:fecha2];

file=fopen('cuenca_media_superior.txt');
A=textscan(file,'%f64 %f64 %s','Delimiter',';');
lat_ruy=A{2};
lon_ruy=A{1};
fclose(file);

earthellipsoid = almanac('earth','ellipsoid','km','sphere');
area_cuenca=areaint(lat_ruy,lon_ruy,earthellipsoid); %Area cuenca en km



%%%%%%%%%%%% Genero la Serie de Datos %%%%%%%%%%%%%%%%%

precipitaciones=zeros(length(fecha),1);
area_cubierta=zeros(length(fecha),1);
numero_estaciones=zeros(length(fecha),1);

file=fopen(NombreFichero,'w');
fclose(file);


for l=1:length(fecha)
    fecha(l)
    tic
    [precipitaciones(l),area_cubierta(l),numero_estaciones(l)] =generarSerieDiaria(fecha(l),lat_ruy,lon_ruy,area_cuenca);
    file=fopen(NombreFichero,'a');
    fprintf(file,'%d;%f;%f;%u;\n',fecha(l),precipitaciones(l),area_cubierta(l),numero_estaciones(l));
    fclose(file);
    a=toc;
    b=a*(length(fecha)-l);
    fprintf('\n Restan aproximadamente %f minutos. \n',b/60)
    fprintf('\n %u/100 Completado \n',floor(l/length(fecha)*100))
end


end
