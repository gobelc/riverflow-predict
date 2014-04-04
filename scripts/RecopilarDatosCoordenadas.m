function [estacion lat lon]=RecopilarDatosCoordenadas(nombre_fichero);

%Codigo		Latitud	Longitud	Añocomienzo	Añofin	Bajado																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																								


A=importdata(nombre_fichero,';',0);


estacion=A.textdata();
lat=A.data(:,1);
lon=A.data(:,2);


end