%% climate data
% анимация температуры среднемес 
% геошоу и береговая линия facecolor 'none'
% рисуем картинку по давлению(как альтиметрию рисуем)
% сделать анимацию по давлению и ветру
% %  скачать ежечасные данные по дарсиллу, все тоже самое скачаиваем за
% 2010-2020 год
% давлениние в точке по горизонтали время, по вертикали распрел давления
% наложить графики

clear
clc
inf=ncinfo("adaptor.mars.internal-1639728391.6172595-27339-17-b5675760-704d-4941-b161-33ca3d77640f.nc");
name= 'adaptor.mars.internal-1639728391.6172595-27339-17-b5675760-704d-4941-b161-33ca3d77640f.nc';

wind= ncread(name, 'u10');
wind=squeeze(wind(:, :, 1, :));

speedw=ncread(name, 'v10');
speedw=squeeze(speedw(:, :, 1, :));

P=ncread(name, 'msl');
P= squeeze(P(:, :, 1, :));
% P=P*1000;

lat=double(ncread(name, 'latitude'));
long=double(ncread(name, 'longitude'));
[long,lat]=ndgrid(long,lat);
latlim = [30 80];
lonlim = [-80 80];

time=double(ncread(name, 'time'));
time=datenum(1900, 1, 1, time, 0, 0);
T=ncread(name, 't2m');
T=T(:,:,1, :);
T=squeeze(T-273);

% T=T-273;
% T=(T(:, :, 1))';
% k=min(T, [], 'omitnan');
% k=rmmissing(k);
%  P=P(:,:,1);


%% video Temperature

v = VideoWriter('Temperature_geo.mp4','MPEG-4');
v.FrameRate=2; 
v.Quality=100;
open(v);
for n=1:35
%     worldmap (latlim,lonlim, 'mercator');
    axesm ('MapProjection', 'mercator','MapLatLimit',[30 80], ...
        'MapLonLimit',[-80 80],  ...
        'frame','off', 'grid', 'on');  

%  axesm('MapProjection','mercator', 'MapLatLimit',[20 50], 'MapLonLimit',[-100 10],... ​
%       'MeridianLabel' , 'on', 'ParallelLabel','on', 'MLabelParallel', 'south’ ,... ​
%       'PLabelMeridian', 'west', 'PLineLocation', 5, 'MLineLocation', 10,... ​
%       'fontsize', 14, 'frame','off', 'grid', 'on')
%     xlim([30 80]);
%     ylim([-80 80]);
% 'Frame', 'on', 'Grid', 'on'
    geoshow(lat,long, T(:,:,n),'displaytype','texture');
    colorbar
    caxis([-40 42]);
    geoshow('landareas.shp','FaceColor','none','EdgeColor','w');
    
    title(datestr(time(n)));
    frame= getframe(gcf);
    writeVideo(v,frame);
    
end
close(v) 

%     contourf (long, lat, T(:,:,n), [-43:40], 'LineStyle','none');
%     colormap jet
%     colorbar
%% pressure+wind
% v = VideoWriter('Pressure.mp4','MPEG-4');
% v.FrameRate=2; 
% v.Quality=100;
% open(v);
% for n=1:35
n=5;
%     worldmap (latlim,lonlim, 'MapProjection', 'mercator');
%     axesm('MapProjection','mercator');
    axesm ('MapProjection', 'mercator','MapLatLimit',[30 80], ...
        'MapLonLimit',[-80 80], 'frame','off', 'grid', 'on');  
    hold on
    contourfm(lat,long, P(:,:,n));
    colorbar
%     caxis([1 1.15]);
    title(datestr(time(n)))
%     worldmap (latlim,lonlim) 
    quivermc(lat,long, wind(:,:,n), speedw(:,:,n), 'units','m/s', ...
        'reference',2,'density',50);
    geoshow('landareas.shp','FaceColor','none','EdgeColor','w')
    colormap("jet")
%     frame= getframe(gcf);
%     writeVideo(v,frame);
%     
% end
% close(v)
%% HOURLY DATA REANALYSIS 
clear
clc

inf=ncinfo("15-16-17");
one= '15-16-17';

inf=ncinfo("18-19-20");
two= '18-19-20';

lat=double(ncread(one, 'latitude'));
long=double(ncread(one, 'longitude'));
latD=lat==54.75;
longD=long==12.75;

v=ncread(one, 'v10');
v2=ncread(two, 'v10');
v=cat(3, v, v2);
v=squeeze(v(longD, latD, :));

u= ncread(one, 'u10');
u2=ncread(two, 'u10');
u=cat(3, u, u2);
u=squeeze(u(longD, latD, :));
m=sqrt(u.^2+v.^2);
dir=atan2(u, v)*180/pi;



P_D=ncread(one, 'msl');
P_D2=ncread(two, 'msl');
P_D=cat(3, P_D, P_D2);
P_D=squeeze(P_D(longD, latD, :));
P_D=P_D/100;
% P=P*1000;


% [long,lat]=ndgrid(long,lat);
% latlim = [30 80];
% lonlim = [-80 80];


time=double(ncread(one, 'time'));
time2=double(ncread(two, 'time'));
time=[time; time2];
time=datenum(1900, 1, 1, time, 0, 0);
% time=datevec(time);

T=ncread(one, 't2m');
T2=ncread(two, 't2m');
T=T-273;
T2=T2-273;
T=cat(3, T, T2);
T=squeeze(T(longD, latD, :));

clear one two time2 u2 v2 T2 P_D2
%%
% % time=datetime(datevec(time));
% figure name Pressure
% plot(time, P_D,'m', 'LineWidth',2);
% 
% % Y=datenum(time(1, 1):time(end, 1), 1, 1, 00, 00, 00);
% set(gca, 'XTick', time(1:500:end), 'XTickLabel', time(1:500:end));
% datetick('x', 'yyyy', 'keeplimits', 'keepticks');
% xlim([time(1) time(end)]);
% 
% title('График изменения давления', 'FontSize', 25);
% xlabel('Время', 'FontSize', 20)
% ylabel('Давление', 'FontSize', 20)
% grid on;
% saveas(gcf, 'pressure.jpeg');
% 
% 
% figure name Temperature
% plot(time, T,'k', 'LineWidth',2);
% 
% % Y=datenum(time(1, 1):time(end, 1), 1, 1, 00, 00, 00);
% set(gca, 'XTick', time(1:500:end), 'XTickLabel', time(1:500:end));
% datetick('x', 'yyyy', 'keeplimits', 'keepticks');
% xlim([time(1) time(end)]);
% 
% title('График изменения температуры', 'FontSize', 25);
% xlabel('Время', 'FontSize', 20)
% ylabel('Температура', 'FontSize', 20)
% grid on;
% saveas(gcf, 'Temperature.jpeg');


%% comparing data with station
% clear
% clc

inf= ncinfo("BO_TS_MO_DarsserS.nc");
Darss="BO_TS_MO_DarsserS.nc";

time_D=ncread(Darss, 'TIME' );
time_D=datenum(1950, 1, 1+time_D, 0, 0, 0);
%  time_Dv=datevec(time_D);
time_D(1:175320)=[];
%  time_D=datevec(time_D);
time_D(73231:end)=[];

Wdir=ncread(Darss, 'WDIR' );
Wdir=Wdir(1, :);
Wdir(1:175320)=[];
Wdir(73231:end)=[];


Wspd=ncread(Darss, 'WSPD' );
Wspd=Wspd(1, :);
Wspd(1:175320)=[];
Wspd(73231:end)=[];

U_darss=Wspd.*sind(Wdir);
V_darss=Wspd.*cosd(Wdir);
% m=sqrt(u.^2+v.^2);
% dir=atan2(u, v)*180/pi;
%
DryT=ncread(Darss, 'DRYT' );
DryT=DryT(1, :);
DryT(1:175320)=[];
DryT(73231:end)=[];

AtmP=ncread(Darss, 'ATMP' );
AtmP=AtmP(2, :);
AtmP(1:175320)=[];
AtmP(73231:end)=[];
% min=min(AtmP);
% max=max(AtmP);

%% WINDROSE
% tiledlayout(2,1)
% nexttile
WindRose_station= WindRose(Wdir, Wspd);

% nexttile
WindRose_reanaliz=WindRose(dir+180, m);
%% WIND plots
% U
% tiledlayout(2,1)
% % intersect
% 
% nexttile
plot(u.*(-1), 'k', 'LineWidth',2);
title('wind reanalysis data', 'FontSize', 20);
xlabel('Dir', 'FontSize', 20);
ylabel('Speed', 'FontSize', 20);
grid on;

hold on
% nexttile
plot(U_darss, 'r', 'LineWidth', 1);
title('wind на станции', 'FontSize', 20);
xlabel('Dir', 'FontSize', 20)
ylabel('Speed', 'FontSize', 20)
grid on;

% legend
%% V
% умножаем на -1 т.к. направления отличаются на реанализе и на станции на
% 180 градусов. В реанализе компонент ветра направлен также как и на
% течениях.
plot(v.*(-1), 'k', 'LineWidth',2);
title('wind reanalysis data', 'FontSize', 20);
xlabel('Dir', 'FontSize', 20);
ylabel('Speed', 'FontSize', 20);
grid on;

hold on
% nexttile
plot(V_darss,'r', 'LineWidth', 1);
title('wind на станции', 'FontSize', 20);
xlabel('Dir', 'FontSize', 20)
ylabel('Speed', 'FontSize', 20)
grid on;

%% PRESSURE
% tiledlayout(2,1)
% 
% nexttile
plot(time_D, AtmP,'k', 'LineWidth',2);
set(gca, 'XTick', time_D(1:500:end), 'XTickLabel', time_D(1:500:end));
datetick('x', 'yyyy', 'keeplimits', 'keepticks');
xlim([time_D(1) time_D(end)]);
title('График изменения давления на станции', 'FontSize', 20);
xlabel('Время', 'FontSize', 20)
ylabel('Давление', 'FontSize', 20)
grid on;
hold on
% nexttile
plot(time, P_D,'r', 'LineWidth',1);
set(gca, 'XTick', time(1:500:end), 'XTickLabel', time(1:500:end));
datetick('x', 'yyyy', 'keeplimits', 'keepticks');
xlim([time(1) time(end)]);
title('График изменения давления по данным реанализа', 'FontSize', 20);
xlabel('Время', 'FontSize', 20)
ylabel('Давление', 'FontSize', 20)
grid on;


 %% TEMPERATURE
% tiledlayout(2,1)
% 
% nexttile
plot(time_D, DryT,'m', 'LineWidth',2);
set(gca, 'XTick', time_D(1:500:end), 'XTickLabel', time_D(1:500:end));
datetick('x', 'yyyy', 'keeplimits', 'keepticks');
xlim([time_D(1) time_D(end)]);
title('График изменения температуры на станции', 'FontSize', 20);
xlabel('Время', 'FontSize', 20)
ylabel('Температура', 'FontSize', 20)
grid on;

hold on
% nexttile
plot(time, T,'k', 'LineWidth',2);
set(gca, 'XTick', time(1:500:end), 'XTickLabel', time(1:500:end));
datetick('x', 'yyyy', 'keeplimits', 'keepticks');
xlim([time(1) time(end)]);
title('График изменения температуры по данным реанализа', 'FontSize', 20);
xlabel('Время', 'FontSize', 20)
ylabel('Температура', 'FontSize', 20)
grid on;



