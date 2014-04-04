function [precipitacion_global,area_cubierta,numero_estaciones] = generarSerieDiaria(fecha,lat_ruy,lon_ruy,area_cuenca)


earthellipsoid = almanac('earth','ellipsoid','km','sphere');

[estaciones lat lon precipitaciones]=EstacionesDisponibles(fecha);


tri=delaunay(lon',lat');
tri2=delaunayTri(lon',lat');
centros=incenters(tri2);
dt=tri(:,:);

area_triangulacion=0;
p_area=0;


for l=1:length(centros)
    
    t = pointLocation(tri2,centros(l,1),centros(l,2));
    r = dt(t,:);
    vert = [lat(r) lon(r)];
    lat_estacion=lat(r);
    lon_estacion=lon(r);
    [i1,i2,i3]=identificarEstacion(lat,lon,lat_estacion,lon_estacion);
    s=inpolygon(lon_estacion,lat_estacion,lon_ruy,lat_ruy);
    
    ind1=i1(1);
    ind2=i2(1);
    ind3=i3(1);
    
    
    if s(1) && s(2) && s(3) %Todos los vertices son interiores a la cuenca
        
        areat=areaint(lat_estacion,lon_estacion,earthellipsoid);%Area de cada triangulo en km
        area_triangulacion=area_triangulacion+areat;
        
        d1=distance(centros(l,2),centros(l,1),lat(ind1),lon(ind1),earthellipsoid);
        d2=distance(centros(l,2),centros(l,1),lat(ind2),lon(ind2),earthellipsoid);
        d3=distance(centros(l,2),centros(l,1),lat(ind3),lon(ind3),earthellipsoid);
        
        m1=1/d1(1);
        m2=1/d2(1);
        m3=1/d3(1);
        
        p_areat=10^(6)*areat*(m1*precipitaciones(ind1)+m2*precipitaciones(ind2)+m3*precipitaciones(ind3))/(m1+m2+m3);%Precipitacion en cada triangul en mm3
        p_area=p_area+p_areat;
        
        
        
    elseif s(1)||s(2)||s(3) %Intersecciones cuando al menos un vetice no pertenece a la cuenca
        
        
        [xi,yi] = polyxpoly([vert(4);vert(5);vert(6);vert(4)],[vert(1);vert(2);vert(3);vert(1)],lon_ruy,lat_ruy);
        
        
        if s(1)&&s(2)
            [xj, yj] = poly2cw(vertcat([vert(4);vert(5)],xi),vertcat([vert(1);vert(2)],yi));
            pondero=(precipitaciones(ind1)+precipitaciones(ind2))/2;
        end
        
        if s(1)&&~s(2)&&~s(3)
            [xj, yj] = poly2cw([vert(4);xi],[vert(1);yi]);
            pondero=precipitaciones(ind1);
        end
        
        
        if s(1)&&s(3)
            [xj, yj] = poly2cw(vertcat([vert(4);vert(6)],xi),vertcat([vert(1);vert(3)],yi));
            pondero=(precipitaciones(ind1)+precipitaciones(ind3))/2;
        end
        
        if s(2)&&~s(3)&&~s(1)
            [xj, yj] = poly2cw([vert(5);xi],[vert(2);yi]);
            pondero=precipitaciones(ind2);
        end
        
        
        if s(2)&&s(3)
            [xj, yj] = poly2cw(vertcat([vert(5);vert(6)],xi),vertcat([vert(2);vert(3)],yi));
            pondero=(precipitaciones(ind2)+precipitaciones(ind3))/2;
        end
        
        if s(3)&&~s(2)&&~s(1)
            [xj, yj] = poly2cw([vert(6);xi],[vert(3);yi]);
            pondero=precipitaciones(ind3);
        end
        
        area_triangulacion=area_triangulacion+areaint(yj,xj,earthellipsoid);
        p_areat=10^6*areaint(yj,xj,earthellipsoid)*pondero;
        p_area=p_area+p_areat;
        
    end
end


%Correccion precipitacion total

area_cubierta=area_triangulacion/area_cuenca*100;
precipitacion_global=(p_area*(area_cuenca/area_triangulacion))/(10^6*(24*60*60)); %En metros cúbicos por segundo
numero_estaciones=length(lat);

end

