clear all
close all;
clc


%Coordenadas Cuenca Media y Superior del Rio Uruguay
file=fopen('cuenca_media_superior.txt');
A=textscan(file,'%f64 %f64 %s','Delimiter',';');
lat_ruy=A{2};
lon_ruy=A{1};
fclose(file);


choice = 0;
while choice ~= 12,
    
    titulo = sprintf('Predicción de flujo del Río Uruguay - TES 2011/2012');
    
    choice = menu(titulo,'Generar Serie','Graficar Series','Datos Diarios','Mapa estaciones','Determinar Modelo','Graficar Modelo','Filtrado KALMAN','Cerrar');
    
    switch choice,
        
        case 1,
           
           generarSerie()
           
           
        case 2,
            
            file=fopen('./series_generadas/2003-2004-2005.txt','r');
            A=textscan(file,'%u %f %f %u','delimiter',';');
            fecha_serie=A{1};
            flujo_serie=A{2};
            area_cobert=A{3};
            numero_est=A{4};
            fclose(file);
            
            file2=fopen('caudal_pdll.txt','r');
            B=textscan(file,'%s %s %f64 %s','delimiter',';','headerlines',4);
            fecha=datenum(B{1},'dd/mm/yyyy');
            flujo=B{3};
            fclose(file2);
            
            f1=find(fecha==fecha_serie(1));
            f2=find(fecha==fecha_serie(length(fecha_serie)));
            
            fecha=fecha(f1:f2);
            flujo=flujo(f1:f2);
            dia1=datestr(datevec(fecha(1)),24);
            dia2=datestr(datevec(fecha(length(fecha))),24);
            
            
            figure(1)
            subplot(2,2,[1 3])
            hold on
            plot(flujo,'LineWidth',2)
            plot(flujo_serie,'r')
            axis([1 length(fecha) 0 max(flujo)])
            xlabel(strcat('Numero Dia (Dia 1=',dia1,' - Dia ',num2str(length(fecha)),'=',dia2,')'))
            ylabel('Flujo [m3/s]')
            hold off
            subplot(2,2,2)
            plot(flujo,'LineWidth',2)
            ylabel('Flujo [m3/s]')
            title('Flujo del Río Uruguay (PDLL)')
            axis([1 length(fecha) 0 max(flujo)])
            subplot(2,2,4)
            plot(flujo_serie,'r')
            axis([1 length(fecha) 0 max(flujo_serie)])
            ylabel('Flujo [m3/s]')
            title('Flujo de precipitaciones en la cuenca')
            
            
        case 3,
            
            close all
            n_dia=datenum(input('Ingrese el dia [dd/mm/yyyy]: \n','s'),'dd/mm/yyyy');
            [estaciones lat lon precipitaciones] = EstacionesDisponibles(n_dia);
            %Delaunay
            tri = delaunay(lat,lon);
%           GraficarEstaciones(lat,lon,lon_ruy,lat_ruy,tri)

            
            trisurf(tri,lon',lat',precipitaciones')
            colorbar
            xlabel('Longitud (º)')
            ylabel('Latitud (º)')
            zlabel('Precipitaciones diarias (mm/m2)')
            hold on
            plot(lon_ruy,lat_ruy,'r','linewidth',2)
            hold off
            
        case 4,
            
            [cod lat lon]=RecopilarDatosCoordenadas('estaciones_final.csv');
            
            %Delaunay
            tri = delaunay(lat,lon);
            
            
            %Graficar estaciones, cuenca rio Uruguay, Triangulación Delauney
            GraficarEstaciones(lat,lon,lon_ruy,lat_ruy,tri)
          
        case 5,
            
            file=fopen('./series_generadas/2003-2004-2005.txt','r');
            A=textscan(file,'%u %f %f %u','delimiter',';');
            fecha_serie=A{1};
            flujo_serie=A{2};
            area_cobert=A{3};
            numero_est=A{4};
            fclose(file);
            
            file2=fopen('caudal_pdll.txt','r');
            B=textscan(file,'%s %s %f64 %s','delimiter',';','headerlines',4);
            fecha=datenum(B{1},'dd/mm/yyyy');
            flujo=B{3};
            fclose(file2);
            
            f1=find(fecha==fecha_serie(1));
            f2=find(fecha==fecha_serie(length(fecha_serie)));
            
            fecha=fecha(f1:f2);
            y=flujo(f1:f2);
            dia1=datestr(datevec(fecha(1)),24);
            dia2=datestr(datevec(fecha(length(fecha))),24);
            
            n=str2num(input('Orden de A(z): \n','s'));
            m=str2num(input('Orden de B(z): \n','s'));
            delta=str2num(input('Dias de retardo: \n', 's'));
            
           [a,b,c,gamma,y2]=determinarModelo(n,m,delta);
            a
            b
            c
            gamma
           
            
        case 6,
            

            figure(1)   
            hold on
            plot(y2,'LineWidth',2)
            plot(y,'r')
            axis([1 length(fecha) 0 max(y)])
            xlabel(strcat('Numero Dia (Dia 1=',dia1,' - Dia ',num2str(length(fecha)),'=',dia2,')'))
            ylabel('Flujo [m3/s]')
           
        case 7,
            
            sigmar=900;
            sigmaq=40;
            sigma=.008;
            
            R=eye(6)*sigmar;
            Q=eye(6)*sigmaq;
            
            
            [ykal F G]=filtroKalman(a,b,c,delta,gamma,R,Q,sigma);
            
            figure(1)
            hold on
            plot(y2,'r')
            plot(ykal,'b','LineWidth',2)
            plot(y,'k')
            legend('Estimación','Estimación y filtrado Kalman','Flujo medido')
            
            
        otherwise
            close all
            break
            
    end
end