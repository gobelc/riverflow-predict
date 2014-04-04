function [] = enventanarDatos(fechaInicio,fechaFin)

[A lat lon]=RecopilarDatosCoordenadas('estaciones_final.csv');   
cod=A(:,1);
encontre=0;
fechan=0;


for i=1:length(cod)
%Argentina
    precipitaciones=0;
    a=1;
    
%     if  str2double(cod(i))>214 && str2double(cod(i))<227
%         ID=char(cod(i));
%         file = fopen(strcat('./ventana/',ID,'.txt'),'w');
%         fprintf(file,'');
%         fclose(file);
%         [fecha,dato]=DatosArgentina(ID,'./argentina/');
%         for l=1:length(fecha)
%             n_fecha_arg=datenum(fecha(l),'dd/mm/yyyy');
%             if ((n_fecha_arg>=fechaInicio) && (n_fecha_arg<=fechaFin));
%                 precipitaciones(a)=dato(l);
%                 fechan(a)=n_fecha_arg;
%                 codigo(a)=str2double(ID);
%                 
%                 file = fopen(strcat('./ventana/',ID,'.txt'),'a');
%                 fprintf(file,'%d;%f\n',fechan(a),precipitaciones(a));
%                 fclose(file);
%                 a=a+1;
%             end
%         end
%         
%     end

precipitaciones=0;
dato=0;
% Brasil
    if str2double(cod(i))>1000
        ID=cod{i,1}
        [fecha dato]=DatosBrasil(ID,'./brasil/');
        file = fopen(strcat('./ventana/',ID,'.txt'),'w');
        fprintf(file,'');
        fclose(file);
        for l=1:length(fecha);
            n_fecha_bra=fecha(l);
            if ((n_fecha_bra>=fechaInicio) && ((n_fecha_bra)<=fechaFin));
                
                precipitaciones(a)=dato(l);
                fechan(a)=n_fecha_bra;
                
                file = fopen(strcat('./ventana/',ID,'.txt'),'a');
                fprintf(file,'%d;%f\n',fechan(a),precipitaciones(a));
                fclose(file);
           
                a=a+1;
            end
        end

        
        
    end




end

end

