%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Importando el archivo de excel.

filename = 'tectonics.xls';
sheet = 1;
xlrange = 'C2:E3';

A = xlsread(filename,sheet,xlrange);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Grados ----> Radianes.

%lambda1 = deg2rad(A(1,1))
%phi1 = deg2rad(A(1,2))
%delta1 = deg2rad(A(1,3))

%lambda2 = deg2rad(A(2,3))
%phi2 = deg2rad(A(2,2))
%delta2 = deg2rad(A(2,3))

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Ecuación para conocer X, Y, Z.

syms x

x = A(2,3)*cosd(A(2,1))*cosd(A(2,2))+A(1,3)*cosd(A(1,1))*cosd(A(1,2));
vpa(x,4)

y = A(2,3)*cosd(A(2,1))*sin(A(2,2))+A(1,3)*cosd(A(1,1))*sind(A(1,2));
vpa(y,4)

z = A(2,3)*sind(A(2,1))+A(1,3)*sind(A(1,1));
vpa(z,4)

%%%%%%%%%%%%%%%%%%%%%%%%%%%% Calculando la magnitud.

magx = sqrt((x^2)+(y^2)+(z^2));

%%%%%%%%%%%%%%%%%%%%%%%%%%% Calculando el polo.

lambdaf = asind(z/magx);
phif = atand(-y/-x);

%%%%%%%%%%%%%%%%%%%%%%%%%%% Mostrando resultados.

chat1 = ['x = ', num2str(x)];
chat2 = ['y = ', num2str(y)];
chat3 = ['z = ', num2str(z)];
chat4 = ['Lat. de Polo = ', num2str(lambdaf)];
chat5 = ['Long. de Polo = ', num2str(phif)];
chat6 = ['Magnitud = ', num2str(magx)];

disp(chat1)
disp(chat2)
disp(chat3)
disp(chat4)
disp(chat5)
disp(chat6)

%%%%%%%%%%%%%%%%%%%%%%%%%%%% Creando sistema de coordenadas esférico.

%grs80 = referenceEllipsoid('grs80','km');
%domeRadius =  3000;  % km
%domeLat =  39;       % degrees
%domeLon = -77;       % degrees
%domeAlt = 0;  
%figure('Renderer','opengl')
%ax = axesm('globe','Geoid',grs80,'Grid','on', ...
%    'GLineWidth',1,'GLineStyle','-',...
%    'Gcolor',[0.9 0.9 0.1],'Galtitude',100);
%ax.Position = [0 0 1 1];
%axis equal off
%view(3)

%%%%%%%%%%%%%%%%%%%%%%%% La topografía y esas cosillas.

%load topo
%geoshow(topo,topolegend,'DisplayType','texturemap')
%demcmap(topo)
%land = shaperead('landareas','UseGeoCoords',true);
%plotm([land.Lat],[land.Lon],'Color','black')
%rivers = shaperead('worldrivers','UseGeoCoords',true);
%plotm([rivers.Lat],[rivers.Lon],'Color','blue')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Sistema de coordenadas 2D.

figure 
axesm bries
text(.8, -1.8, 'Briesemeister projection')
framem('FLineWidth',1)

%%%%%%%%%%%%%%%%%%%%%%%%%%% Topo.

load topo
geoshow(topo, topolegend, 'DisplayType', 'texturemap')

%%%%%%%%%%%%%%%%%% Aspectos superficiales.

demcmap(topo)
brighten(.5)

geoshow(lambdaf, phif,...
        'DisplayType', 'point',...
        'Marker', 'o',...
        'MarkerEdgeColor', 'r',...
        'MarkerFaceColor', 'r',...
        'MarkerSize', 3)

h = msgbox('Listo.');
