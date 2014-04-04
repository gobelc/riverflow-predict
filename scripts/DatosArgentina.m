function [fecha precipitaciones] = DatosArgentina(ID,carpeta)
%DATOSARGETINA Summary of this function goes here
%   Detailed explanation goes here

%A{1} fecha
%A{2} Precipitaciones en mm


A=importdata(strcat(carpeta,ID,'.txt'),';',4);

fecha2=A.textdata;
precipitaciones=A.data;
fecha=fecha2(5:length(fecha2),1);

end

