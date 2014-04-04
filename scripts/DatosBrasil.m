function [fecha precipitaciones] = DatosBrasil(ID,carpeta)


% EstacaoCodigo;NivelConsistencia;Data;TipoMedicaoChuvas;Maxima;Total;DiaMaxima;NumDiasDeChuva;MaximaStatus;TotalStatus;NumDiasDeChuvaStatus;TotalAnual;TotalAnualStatus;Chuva01;Chuva02;Chuva03;Chuva04;Chuva05;Chuva06;Chuva07;Chuva08;Chuva09;Chuva10;Chuva11;Chuva12;Chuva13;Chuva14;Chuva15;Chuva16;Chuva17;Chuva18;Chuva19;Chuva20;Chuva21;Chuva22;Chuva23;Chuva24;Chuva25;Chuva26;Chuva27;Chuva28;Chuva29;Chuva30;Chuva31;Chuva01Status;Chuva02Status;Chuva03Status;Chuva04Status;Chuva05Status;Chuva06Status;Chuva07Status;Chuva08Status;Chuva09Status;Chuva10Status;Chuva11Status;Chuva12Status;Chuva13Status;Chuva14Status;Chuva15Status;Chuva16Status;Chuva17Status;Chuva18Status;Chuva19Status;Chuva20Status;Chuva21Status;Chuva22Status;Chuva23Status;Chuva24Status;Chuva25Status;Chuva26Status;Chuva27Status;Chuva28Status;Chuva29Status;Chuva30Status;Chuva31Status;
% Estac-1-odigo;NivelCo-2-stencia;D-3-;TipoM-4-caoChuvas;Ma-5-a;To-6-;Dia-7-ima;Num-8-sDeChuva;Maxi-9-tatus;Tot-10-atus;Num-11-DeChuvaStatus;Tot-12-ual;Total-13-lStatus;Ch-14-1;Chu-10-;Ch-10-3;Ch-10-4;Ch-10-5;Ch-10-6;Ch-10-7;Ch-10-8;Ch-10-9;Ch-10-0;Ch-10-1;Ch-10-2;Ch-10-3;Ch-10-4;Ch-10-5;Ch-10-6;Ch-10-7;Ch-10-8;Ch-10-9;Ch-10-0;Ch-10-1;Ch-10-2;C-10-23;Ch-10-4;Ch-10-5;Ch-10-6;Ch-10-7;C-41-28;C-42-29;Ch-43-0;Ch-44-1;Chu-45-Status;Chuv-10-tatus;Chuva-10-atus;Chu-10-Status;Chu-10-Status;Chu-10-Status;Ch-10-7Status;Chuva-10-atus;Ch-10-9Status;Chuv-10-tatus;Chuv-10-tatus;Chuva-10-atus;Chuva-10-atus;Chu-10-Status;Chuv-10-tatus;Chuva1-10-tus;Chuv-10-tatus;Chuv-10-tatus;Chuv-10-tatus;Chuv-10-tatus;Chuv-10-tatus;Chuva-10-atus;Chuv-10-tatus;Chuva-10-atus;Chuv-10-tatus;Chuv-10-tatus;Chu-10-Status;Chuva-72-atus;Chuv-73-tatus;Chuv-74-tatus;Chuva-75-atus;

% file=fopen(strcat('./brasil/',ID,'.txt'));
% A=textscan(file,'%s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s','HeaderLines',18,'Delimiter',';','TreatAsEmpty','0');



% Import the file

A = importdata(strcat(carpeta,ID,'.txt'),';',16);

fecha2=A.textdata(:,3);
fecha3=fecha2(17:length(fecha2),1);


n=DATENUM(fecha3,'dd/mm/yyyy');
l=length(fecha3);
precipitacionesc=0;
a=1;


for i=1:l;
    b=0;
    for j=11:41
        if A.data(i,j+31)>0
            precipitacionesc(a)=A.data(i,j);
            fechac(a)=n(i)+b;
            a=a+1;
            b=b+1;
        end
    end
end

B = sortrows(horzcat(fechac',precipitacionesc'));
fechab=B(:,1);
precipitacionesb=B(:,2);

a=1;
for i=1:length(precipitacionesb)-1;
    b=fechab(i);
    c=precipitacionesb(i);
    if fechab(i+1)~=b
    fecha(a)=b;
    precipitaciones(a)=c;
    a=a+1;
    end
end

fecha=fecha';
precipitaciones=precipitaciones';

end

