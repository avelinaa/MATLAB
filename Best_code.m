%%Yes, we begin another shit...
Spb= readmatrix('Санкт-Петербург.xls');
Mur = readmatrix('Мурманск.xls');
Sochi = readmatrix('Сочи.xls');
Vlad= readmatrix('Владивосток.xls');

Spb=flip(Spb);
Mur=flip(Mur);
Sochi=flip(Sochi);
Vlad= flip(Vlad);

%~READING TIME IN EACH CITY~
TimeSpb= readtable('Санкт-Петербург.xls');
TimeMur = readtable('Мурманск.xls');
TimeSochi = readtable('Сочи.xls');
TimeVlad= readtable('Владивосток.xls');

TimeSpb=flip(TimeSpb);
TimeMur=flip(TimeMur);
TimeSochi=flip(TimeSochi);
TimeVlad= flip(TimeVlad);

%for Saint Petersburg
TimeSpb= TimeSpb.x_____________________________;
TimeSpb = datetime(TimeSpb);

%for Murmansk
TimeMur= TimeMur.x______________________;
TimeMur = datetime(TimeMur);
 
%for Sochi
TimeSochi= TimeSochi.x____________;
TimeSochi = datetime(TimeSochi);

%for Vladivostok
TimeVlad= TimeVlad.x__________________________;
TimeVlad = datetime(TimeVlad);

%~SEARCHING FOR EACH DIMENSION  IN ARRAYS~

%for Saint Petersburg
TSpb=Spb(:,2);
USpb=Spb(:,6);
RSpb=Spb(:,24);
%for Murmansk
TMur=Mur(:,2);
UMur=Mur(:,6);
RMur=Mur(:,24);
%for Sochi
TSochi=Sochi(:,2);
USochi=Sochi(:,6);
RSochi=Sochi(:,24);
%for Vladivostok
TVlad=Vlad(:,2);
UVlad=Vlad(:,6);
RVlad=Vlad(:,24);

%~AVERAGE MONTHLY DIMENSIONS FOR Saint Petersburg~

%   average, min and max monthly temperature 
TimeRainSpb=TimeSpb;
TtimeSpb=TimeSpb;
UtimeSpb=TimeSpb;
RtimeSpb=TimeSpb;
TimeSpb=datevec(TimeSpb);

for i=1:12 
    AvgSpbT(i)=mean(TSpb(TimeSpb(:,2)==i),'omitnan'); 
    MINSpbT(i)=min(TSpb(TimeSpb(:,2)==i)); 
    MAXSpbT(i)=max(TSpb(TimeSpb(:,2)==i)); 
    AvgSpbU(i)=mean(USpb(TimeSpb(:,2)==i), 'omitnan'); 
end
AvgSpbT=AvgSpbT';
%   average monthly humidity
AvgSpbU=AvgSpbU';

%   average number of days per year with a relative humidity of at least 80%
YUSpb=USpb(USpb>=80);
YUSpb=rmmissing(YUSpb);
UtimeSpb=UtimeSpb(USpb>=80);
UtimeSpb=datevec(UtimeSpb);

UtimeSpb=[UtimeSpb(:,1), UtimeSpb(:,2),UtimeSpb(:,3),...
 zeros(size(YUSpb)), zeros(size(YUSpb)), zeros(size(YUSpb)) ];

UtimeSpb=unique(UtimeSpb,"rows");
YUSpb=ones(length(UtimeSpb), 1);

k=1;
for i=2010:2021 
 YSpbU(1, k)=sum(YUSpb(UtimeSpb(:,1)==i), 'omitnan'); 
 k=k+1;
end
Humidity_Spb= mean(YSpbU);

%   average monthly precipitation
RtimeSpb=datetime(RtimeSpb);
RtimeSpb=table(RtimeSpb);
meanRSpb=array2table(RSpb);
AvgSpbR=[RtimeSpb, meanRSpb];

AvgSpbR=table2timetable(AvgSpbR);
AvgSpbR = retime(AvgSpbR,'monthly','sum');
AvgSpbR=timetable2table(AvgSpbR);
meanRSpb=AvgSpbR.RSpb;
RtimeSpb=AvgSpbR.RtimeSpb;
RtimeSpb=datevec(RtimeSpb);
for i=1:12 
 AvgSpbFall(i)=mean(meanRSpb(RtimeSpb(:,2)==i), 'omitnan'); 
end
AvgSpbFall=AvgSpbFall';

%   average annual rainfall
Rainfall_Spb=sum(AvgSpbFall);

%   average monthly number of rainy days
RRSpb=RSpb(RSpb>1); 

TimeRSpb=TimeRainSpb(RSpb>1);
TimeshitSpb=datevec(TimeRSpb);
TimeshitSpb=[TimeshitSpb(:,1), TimeshitSpb(:,2),TimeshitSpb(:,3),...
    zeros(size(TimeRSpb)), zeros(size(TimeRSpb)), zeros(size(TimeRSpb)) ];

TimeRSpb=unique(TimeshitSpb,"rows");
TimeRSpb=datetime(TimeRSpb);
TimeRSpb=table(TimeRSpb);

RRSpb=ones(size(TimeRSpb));
RRSpb=array2table(RRSpb);

S=[TimeRSpb, RRSpb];

S=table2timetable(S);

S = retime(S,'monthly','sum');
S=timetable2table(S);
RSpb=S.RRSpb;
TimeRSpb=S.TimeRSpb;
TimeRSpb=datevec(TimeRSpb);
for i=1:12 
 RainSpb(i)=mean(RSpb(TimeRSpb(:,2)==i)); 
end
RainSpb=RainSpb';

%   average annual temperature for the entire observation period
TtimeSpb=TtimeSpb(~isnan(TSpb));
YTSpb=TSpb(~isnan(TSpb));
YTtimeSpb=TtimeSpb;
YTtimeSpb=datevec(YTtimeSpb);

TtimeSpb= datevec(TtimeSpb);
TtimeSpb=[TtimeSpb(:,1), TtimeSpb(:,2), zeros(size(YTSpb)),zeros(size(YTSpb)),...
    zeros(size(YTSpb)), zeros(size(YTSpb))];

TtimeSpb=unique(TtimeSpb, "rows");

TSpb=ones(length(TtimeSpb), 1);
TSpb=array2table(TSpb);
TtimeSpb=table(TtimeSpb);
X=[TtimeSpb, TSpb];

k=1;
for i=2010:2021 
 YearTSpb(k)=mean(YTSpb(YTtimeSpb(:,1)==i)); 
 k=k+1;
end
YearTSpb=YearTSpb';

k=1;
    for i=2010:2021 
 TempatimeSpb(k)=sum(X.TtimeSpb(:,1) ==i); 
 k=k+1;
    end
TempatimeSpb=TempatimeSpb';
TempatimeSpb=TempatimeSpb==12;
YearTSpb=YearTSpb(TempatimeSpb);
T_Spb = 2010:2021;
T_Spb=T_Spb(TempatimeSpb)';

%~AVERAGE MONTHLY DIMENSIONS FOR MURMANSK~

%average, min and max monthly temperature 
TimeRainMur=TimeMur;
TtimeMur=TimeMur;
UtimeMur=TimeMur;
RtimeMur=TimeMur;
TimeMur=datevec(TimeMur);

for i=1:12 
 AvgMurT(i)=mean(TMur(TimeMur(:,2)==i),'omitnan'); 
end

AvgMurT=AvgMurT';

for i=1:12 
 MINMurT(i)=min(TMur(TimeMur(:,2)==i)); 
end

for i=1:12 
 MAXMurT(i)=max(TMur(TimeMur(:,2)==i)); 
end

%average monthly humidity 
for i=1:12 
 AvgMurU(i)=mean(UMur(TimeMur(:,2)==i), 'omitnan'); 
end
AvgMurU=AvgMurU';

%   average number of days per year with a relative humidity of at least 80%
YUMur=UMur(UMur>=80);
YUMur=rmmissing(YUMur);
UtimeMur=UtimeMur(UMur>=80);
UtimeMur=datevec(UtimeMur);

UtimeMur=[UtimeMur(:,1), UtimeMur(:,2),UtimeMur(:,3),...
    zeros(size(YUMur)), zeros(size(YUMur)), zeros(size(YUMur)) ];

UtimeMur=unique(UtimeMur,"rows");
YUMur=ones(length(UtimeMur), 1);

k=1;
for i=2010:2021 
 YMurU(1, k)=sum(YUMur(UtimeMur(:,1)==i), 'omitnan'); 
 k=k+1;
end
Humidity_Murmansk= mean(YMurU);

%   average monthly precipitation
RtimeMur=datetime(RtimeMur);
RtimeMur=table(RtimeMur);
meanRMur=array2table(RMur);
AvgMurR=[RtimeMur, meanRMur];

AvgMurR=table2timetable(AvgMurR);
AvgMurR = retime(AvgMurR,'monthly','sum');
AvgMurR=timetable2table(AvgMurR);
meanRMur=AvgMurR.RMur;
RtimeMur=AvgMurR.RtimeMur;
RtimeMur=datevec(RtimeMur);
for i=1:12 
 AvgMurFall(i)=mean(meanRMur(RtimeMur(:,2)==i), 'omitnan'); 
end
AvgMurFall=AvgMurFall';

%   average annual rainfall
Rainfall_Mur=sum(AvgMurFall);

%   average monthly number of rainy days
RRMur=RMur(RMur>1); 

TimeRMur=TimeRainMur(RMur>1);
TimeshitMur=datevec(TimeRMur);
TimeshitMur=[TimeshitMur(:,1), TimeshitMur(:,2),TimeshitMur(:,3),...
    zeros(size(TimeRMur)), zeros(size(TimeRMur)), zeros(size(TimeRMur)) ];

TimeRMur=unique(TimeshitMur,"rows");
TimeRMur=datetime(TimeRMur);
TimeRMur=table(TimeRMur);

RRMur=ones(size(TimeRMur));
RRMur=array2table(RRMur);

M=[TimeRMur, RRMur];

M=table2timetable(M);

M = retime(M,'monthly','sum');
M=timetable2table(M);
RMur=M.RRMur;
TimeRMur=M.TimeRMur;
TimeRMur=datevec(TimeRMur);
for i=1:12 
 RainMur(i)=mean(RMur(TimeRMur(:,2)==i)); 
end
RainMur=RainMur';

%   average annual temperature for the entire observation period
TtimeMur=TtimeMur(~isnan(TMur));
YTMur=TMur(~isnan(TMur));
YTtimeMur=TtimeMur;
YTtimeMur=datevec(YTtimeMur);

TtimeMur= datevec(TtimeMur);
TtimeMur=[TtimeMur(:,1), TtimeMur(:,2), zeros(size(YTMur)),zeros(size(YTMur)),...
    zeros(size(YTMur)), zeros(size(YTMur))];

TtimeMur=unique(TtimeMur, "rows");

TMur=ones(length(TtimeMur), 1);
TMur=array2table(TMur);
TtimeMur=table(TtimeMur);
X=[TtimeMur, TMur];

k=1;
for i=2010:2021 
 YearTMur(k)=mean(YTMur(YTtimeMur(:,1)==i)); 
 k=k+1;
end
YearTMur=YearTMur';

k=1;
    for i=2010:2021 
 TempatimeMur(k)=sum(X.TtimeMur(:,1) ==i); 
 k=k+1;
    end
TempatimeMur=TempatimeMur';
TempatimeMur=TempatimeMur==12;
YearTMur=YearTMur(TempatimeMur);
T_Mur = 2010:2021;
T_Mur=T_Mur(TempatimeMur)';

%~AVERAGE MONTHLY DIMENSIONS FOR SOCHI~

%   average, min and max monthly temperature 
TimeRainSochi=TimeSochi;
TtimeSochi=TimeSochi;
UtimeSochi=TimeSochi;
RtimeSochi=TimeSochi;
TimeSochi=datevec(TimeSochi);

for i=1:12 
 AvgSochiT(i)=mean(TSochi(TimeSochi(:,2)==i),'omitnan'); 
end
AvgSochiT=AvgSochiT';

for i=1:12 
 MINSochiT(i)=min(TSochi(TimeSochi(:,2)==i)); 
end

for i=1:12 
 MAXSochiT(i)=max(TSochi(TimeSochi(:,2)==i)); 
end

%   average monthly humidity
for i=1:12 
 AvgSochiU(i)=mean(USochi(TimeSochi(:,2)==i), 'omitnan'); 
end
AvgSochiU=AvgSochiU';

%   average number of days per year with a relative humidity of at least 80%
YUSochi=USochi(USochi>=80);
YUSochi=rmmissing(YUSochi);
UtimeSochi=UtimeSochi(USochi>=80);
UtimeSochi=datevec(UtimeSochi);

UtimeSochi=[UtimeSochi(:,1), UtimeSochi(:,2),UtimeSochi(:,3),...
    zeros(size(YUSochi)), zeros(size(YUSochi)), zeros(size(YUSochi)) ];

UtimeSochi=unique(UtimeSochi,"rows");
YUSochi=ones(length(UtimeSochi), 1);

k=1;
for i=2010:2021 
 YSochiU(1, k)=sum(YUSochi(UtimeSochi(:,1)==i), 'omitnan'); 
 k=k+1;
end
Humidity_Sochi= mean(YSochiU);

%   average monthly precipitation
RtimeSochi=datetime(RtimeSochi);
RtimeSochi=table(RtimeSochi);
meanRSochi=array2table(RSochi);
AvgSochiR=[RtimeSochi, meanRSochi];

AvgSochiR=table2timetable(AvgSochiR);
AvgSochiR = retime(AvgSochiR,'monthly','sum');
AvgSochiR=timetable2table(AvgSochiR);
meanRSochi=AvgSochiR.RSochi;
RtimeSochi=AvgSochiR.RtimeSochi;
RtimeSochi=datevec(RtimeSochi);
for i=1:12 
 AvgSochiFall(i)=mean(meanRSochi(RtimeSochi(:,2)==i), 'omitnan'); 
end
AvgSochiFall=AvgSochiFall';

%   average annual rainfall
Rainfall_Sochi=sum(AvgSochiFall);

%   average monthly number of rainy days
RRSochi=RSochi(RSochi>1); 

TimeRSochi=TimeRainSochi(RSochi>1);
TimeshitSochi=datevec(TimeRSochi);
TimeshitSochi=[TimeshitSochi(:,1), TimeshitSochi(:,2),TimeshitSochi(:,3),...
    zeros(size(TimeRSochi)), zeros(size(TimeRSochi)), zeros(size(TimeRSochi)) ];

TimeRSochi=unique(TimeshitSochi,"rows");
TimeRSochi=datetime(TimeRSochi);
TimeRSochi=table(TimeRSochi);

RRSochi=ones(size(TimeRSochi));
RRSochi=array2table(RRSochi);

Sch=[TimeRSochi, RRSochi];

Sch=table2timetable(Sch);

Sch = retime(Sch,'monthly','sum');
Sch=timetable2table(Sch);
RSochi=Sch.RRSochi;
TimeRSochi=Sch.TimeRSochi;
TimeRSochi=datevec(TimeRSochi);
for i=1:12 
 RainSochi(i)=mean(RSochi(TimeRSochi(:,2)==i)); 
end
RainSochi=RainSochi';

%   average annual temperature for the entire observation period
TtimeSochi=TtimeSochi(~isnan(TSochi));
YTSochi=TSochi(~isnan(TSochi));
YTtimeSochi=TtimeSochi;
YTtimeSochi=datevec(YTtimeSochi);

TtimeSochi= datevec(TtimeSochi);
TtimeSochi=[TtimeSochi(:,1), TtimeSochi(:,2), zeros(size(YTSochi)),zeros(size(YTSochi)),...
    zeros(size(YTSochi)), zeros(size(YTSochi))];

TtimeSochi=unique(TtimeSochi, "rows");

TSochi=ones(length(TtimeSochi), 1);
TSochi=array2table(TSochi);
TtimeSochi=table(TtimeSochi);
X=[TtimeSochi, TSochi];

k=1;
for i=2010:2021 
 YearTSochi(k)=mean(YTSochi(YTtimeSochi(:,1)==i)); 
 k=k+1;
end
YearTSochi=YearTSochi';

k=1;
    for i=2010:2021 
 TempatimeSochi(k)=sum(X.TtimeSochi(:,1) ==i); 
 k=k+1;
    end
TempatimeSochi=TempatimeSochi';
TempatimeSochi=TempatimeSochi==12;
YearTSochi=YearTSochi(TempatimeSochi);
T_Sochi = 2010:2021;
T_Sochi=T_Sochi(TempatimeSochi)';


%~AVERAGE MONTHLY DIMENSIONS FOR VLADIVOSTOK~

%   average, min and max monthly temperature 
TimeRainVlad=TimeVlad;
TtimeVlad=TimeVlad;
UtimeVlad=TimeVlad;
RtimeVlad=TimeVlad;
TimeVlad=datevec(TimeVlad);

for i=1:12 
 AvgVladT(i)=mean(TVlad(TimeVlad(:,2)==i),'omitnan'); 
end
AvgVladT=AvgVladT';

for i=1:12 
 MINVladT(i)=min(TVlad(TimeVlad(:,2)==i)); 
end

for i=1:12 
 MAXVladT(i)=max(TVlad(TimeVlad(:,2)==i)); 
end

%   average monthly humidity
for i=1:12 
 AvgVladU(i)=mean(UVlad(TimeVlad(:,2)==i), 'omitnan'); 
end
AvgVladU=AvgVladU';

%   average number of days per year with a relative humidity of at least 80%
YUVlad=UVlad(UVlad>=80);
YUVlad=rmmissing(YUVlad);
UtimeVlad=UtimeVlad(UVlad>=80);
UtimeVlad=datevec(UtimeVlad);

UtimeVlad=[UtimeVlad(:,1), UtimeVlad(:,2),UtimeVlad(:,3),...
    zeros(size(YUVlad)), zeros(size(YUVlad)), zeros(size(YUVlad)) ];

UtimeVlad=unique(UtimeVlad,"rows");
YUVlad=ones(length(UtimeVlad), 1);

k=1;
for i=2010:2021 
 YVladU(1, k)=sum(YUVlad(UtimeVlad(:,1)==i), 'omitnan'); 
 k=k+1;
end
Humidity_Vladivostok= mean(YVladU);

%   average monthly precipitation
RtimeVlad=datetime(RtimeVlad);
RtimeVlad=table(RtimeVlad);
meanRVlad=array2table(RVlad);
AvgVladR=[RtimeVlad, meanRVlad];

AvgVladR=table2timetable(AvgVladR);
AvgVladR = retime(AvgVladR,'monthly','sum');
AvgVladR=timetable2table(AvgVladR);
meanRVlad=AvgVladR.RVlad;
RtimeVlad=AvgVladR.RtimeVlad;
RtimeVlad=datevec(RtimeVlad);
for i=1:12 
 AvgVladFall(i)=mean(meanRVlad(RtimeVlad(:,2)==i), 'omitnan'); 
end
AvgVladFall=AvgVladFall';

%   average annual rainfall
Rainfall_Vlad=sum(AvgVladFall);

%   average monthly number of rainy days
RRVlad=RVlad(RVlad>1); 

TimeRVlad=TimeRainVlad(RVlad>1);
TimeshitVlad=datevec(TimeRVlad);
TimeshitVlad=[TimeshitVlad(:,1), TimeshitVlad(:,2),TimeshitVlad(:,3),...
    zeros(size(TimeRVlad)), zeros(size(TimeRVlad)), zeros(size(TimeRVlad)) ];

TimeRVlad=unique(TimeshitVlad,"rows");
TimeRVlad=datetime(TimeRVlad);
TimeRVlad=table(TimeRVlad);

RRVlad=ones(size(TimeRVlad));
RRVlad=array2table(RRVlad);

V=[TimeRVlad, RRVlad];

V=table2timetable(V);

V = retime(V,'monthly','sum');
V=timetable2table(V);
RVlad=V.RRVlad;
TimeRVlad=V.TimeRVlad;
TimeRVlad=datevec(TimeRVlad);
for i=1:12 
 RainVlad(i)=mean(RVlad(TimeRVlad(:,2)==i)); 
end
RainVlad=RainVlad';

%   average annual temperature for the entire observation period
TtimeVlad=TtimeVlad(~isnan(TVlad));
YTVlad=TVlad(~isnan(TVlad));
YTtimeVlad=TtimeVlad;
YTtimeVlad=datevec(YTtimeVlad);

TtimeVlad= datevec(TtimeVlad);
TtimeVlad=[TtimeVlad(:,1), TtimeVlad(:,2), zeros(size(YTVlad)),zeros(size(YTVlad)),...
    zeros(size(YTVlad)), zeros(size(YTVlad))];

TtimeVlad=unique(TtimeVlad, "rows");

TVlad=ones(length(TtimeVlad), 1);
TVlad=array2table(TVlad);
TtimeVlad=table(TtimeVlad);
X=[TtimeVlad, TVlad];

k=1;
for i=2010:2021 
 YearTVlad(k)=mean(YTVlad(YTtimeVlad(:,1)==i)); 
 k=k+1;
end
YearTVlad=YearTVlad';

k=1;
    for i=2010:2021 
 TempatimeVlad(k)=sum(X.TtimeVlad(:,1) ==i); 
 k=k+1;
    end
TempatimeVlad=TempatimeVlad';
TempatimeVlad=TempatimeVlad==12;
YearTVlad=YearTVlad(TempatimeVlad);
T_Vlad = 2010:2021;
T_Vlad=T_Vlad(TempatimeVlad)';

% ~GRAPHS FOR ALL DIMENSIONS~ 

% for Saint Petersburg

%   1.Temperature
figure name Saint_Petersburg_T_and_R
set(gcf,'units','normalized','outerposition',[0 0 1 1])
tiledlayout(2,1)
nexttile
plot(AvgSpbT,'LineWidth',2);
title(' График среднемесячных температур', 'FontSize', 25);
xlabel('месяцы', 'FontSize', 20)
ylabel('Температура C^\circ', 'FontSize', 20)
grid on;
nexttile
%   2. Precipitation
plot(AvgSpbFall,'LineWidth',2);
title(' График среднемесячных осадков', 'FontSize', 25);
xlabel('месяцы', 'FontSize', 20)
ylabel('количество выпавших осадков, мм', 'FontSize', 20)
grid on;
saveas(gcf, 'Spb T and R.jpeg');

figure name Saint_Petersburg_U_and_Rainydays
set(gcf,'units','normalized','outerposition',[0 0 1 1])
tiledlayout(2,1)
nexttile
%   3. Humidity
plot(AvgSpbU,'LineWidth',2);
title(' График среднемесячной влажности', 'FontSize', 25);
xlabel('месяцы', 'FontSize', 20)
ylabel('влажность, % ', 'FontSize', 20)
grid on;
nexttile
%   4. Average monthly number of rainy days
plot(RainSpb, 'r', 'LineWidth',2);
title(' График среднемесячного количества дождливых дней', 'FontSize', 25);
xlabel('месяцы', 'FontSize', 20)
ylabel('количество дождливых дней', 'FontSize', 20)
grid on;
saveas(gcf, 'Spb U and Rainydays.jpeg');

figure name Saint_Petersburg_annual_T
set(gcf,'units','normalized','outerposition',[0 0 1 1])
%   5. Average annual temperature for the entire observation period
plot(T_Spb, YearTSpb, 'm', 'LineWidth',2);
title('График среднегодовой температуры за весь период наблюдений', 'FontSize', 25);
xlabel('Года', 'FontSize', 20)
ylabel('Среднегодовая температура C^\circ', 'FontSize', 20)
grid on;
saveas(gcf, 'Spb annual T.jpeg');

%for Murmansk

%   1.Temperature
figure name Murmansk_T_and_R
set(gcf,'units','normalized','outerposition',[0 0 1 1])
tiledlayout(2,1)
nexttile
plot(AvgMurT,'LineWidth',2);
title(' График среднемесячных температур', 'FontSize', 25);
xlabel('месяцы', 'FontSize', 20)
ylabel('Температура C^\circ', 'FontSize', 20)
grid on;
nexttile
%   2. Precipitation
plot(AvgMurFall,'LineWidth',2);
title(' График среднемесячных осадков', 'FontSize', 25);
xlabel('месяцы', 'FontSize', 20)
ylabel('количество выпавших осадков, мм', 'FontSize', 20)
grid on;
saveas(gcf, 'Murmansk T and R.jpeg');

figure name Murmansk_U_and_Rainydays
set(gcf,'units','normalized','outerposition',[0 0 1 1])
tiledlayout(2,1)
nexttile
%   3. Humidity
plot(AvgMurU,'LineWidth',2);
title(' График среднемесячной влажности', 'FontSize', 25);
xlabel('месяцы', 'FontSize', 20)
ylabel('влажность, % ', 'FontSize', 20)
grid on;
nexttile
%   4. Average monthly number of rainy days
plot(RainMur, 'r', 'LineWidth',2);
title(' График среднемесячного количества дождливых дней', 'FontSize', 25);
xlabel('месяцы', 'FontSize', 20)
ylabel('количество дождливых дней', 'FontSize', 20)
grid on;
saveas(gcf, 'Murmansk U and Rainydays.jpeg');

figure name Murmansk_annualT
set(gcf,'units','normalized','outerposition',[0 0 1 1])
%   5. Average annual temperature for the entire observation period
plot(T_Mur, YearTMur, 'm', 'LineWidth',2);
title('График среднегодовой температуры за весь период наблюдений', 'FontSize', 25);
xlabel('Года', 'FontSize', 20)
ylabel('Среднегодовая температура C^\circ', 'FontSize', 20)
grid on;
saveas(gcf, 'Murmansk annual T.jpeg');

% for Sochi

%   1.Temperature
figure name Sochi_T_and_R
set(gcf,'units','normalized','outerposition',[0 0 1 1])
tiledlayout(2,1)
nexttile
plot(AvgSochiT,'LineWidth',2);
title(' График среднемесячных температур', 'FontSize', 25);
xlabel('месяцы', 'FontSize', 20)
ylabel('Температура C^\circ', 'FontSize', 20)
grid on;
nexttile
%   2. Precipitation
plot(AvgSochiFall,'LineWidth',2);
title(' График среднемесячных осадков', 'FontSize', 25);
xlabel('месяцы', 'FontSize', 20)
ylabel('количество выпавших осадков, мм', 'FontSize', 20)
grid on;
saveas(gcf, 'Sochi T and R.jpeg');

figure name Sochi_U_and_Rainydays
set(gcf,'units','normalized','outerposition',[0 0 1 1])
tiledlayout(2,1)
nexttile
%   3. Humidity
plot(AvgSochiU,'LineWidth',2);
title(' График среднемесячной влажности', 'FontSize', 25);
xlabel('месяцы', 'FontSize', 20)
ylabel('влажность, % ', 'FontSize', 20)
grid on;
nexttile
%   4. Average monthly number of rainy days
plot(RainSochi, 'r', 'LineWidth',2);
title(' График среднемесячного количества дождливых дней', 'FontSize', 25);
xlabel('месяцы', 'FontSize', 20)
ylabel('количество дождливых дней', 'FontSize', 20)
grid on;
saveas(gcf, 'Sochi U and Rainydays.jpeg');

%   5. Average annual temperature for the entire observation period
figure name Sochi_annualT
set(gcf,'units','normalized','outerposition',[0 0 1 1])
plot(T_Sochi, YearTSochi, 'm', 'LineWidth',2);
title('График среднегодовой температуры за весь период наблюдений', 'FontSize', 25);
xlabel('Года', 'FontSize', 20)
ylabel('Среднегодовая температура C^\circ', 'FontSize', 20)
grid on;
saveas(gcf, 'Sochi annualT.jpeg');

% for Vladivostok

figure name Vladivostok_T_and_R
set(gcf,'units','normalized','outerposition',[0 0 1 1])
tiledlayout(2,1)
nexttile
%   1.Temperature
plot(AvgVladT,'LineWidth',2);
title(' График среднемесячных температур', 'FontSize', 25);
xlabel('месяцы', 'FontSize', 20)
ylabel('Температура C^\circ', 'FontSize', 20)
grid on;
nexttile
%   2. Precipitation
plot(AvgVladFall,'LineWidth',2);
title(' График среднемесячных осадков', 'FontSize', 25);
xlabel('месяцы', 'FontSize', 20)
ylabel('количество выпавших осадков, мм', 'FontSize', 20)
grid on;
saveas(gcf, 'Vladivostok T and R.jpeg');

figure name Vladivostok_U_and_Rainydays
set(gcf,'units','normalized','outerposition',[0 0 1 1])
tiledlayout(2,1)
nexttile
%   3. Humidity
plot(AvgVladU,'LineWidth',2);
title(' График среднемесячной влажности', 'FontSize', 25);
xlabel('месяцы', 'FontSize', 20)
ylabel('влажность, %', 'FontSize', 20)
grid on;
nexttile
%   4. Average monthly number of rainy days
plot(RainVlad, 'r', 'LineWidth',2);
title(' График среднемесячного количества дождливых дней', 'FontSize', 25);
xlabel('месяцы', 'FontSize', 20)
ylabel('количество дождливых дней', 'FontSize', 20)
grid on;
saveas(gcf, 'Vladivostok U and Rainydays.jpeg');


%   5. Average annual temperature for the entire observation period
figure name Vladivostok_annualT
set(gcf,'units','normalized','outerposition',[0 0 1 1])
plot(T_Vlad, YearTVlad, 'm', 'LineWidth',2);
title('График среднегодовой температуры за весь период наблюдений', 'FontSize', 25);
xlabel('Года', 'FontSize', 20)
ylabel('Среднегодовая температура C^\circ', 'FontSize', 20)
grid on;
saveas(gcf, 'Vladivostok annual T.jpeg');

%~TABLES~

%TABLE FOR SAINT PETERSBURG
Saint_Petersburg=[AvgSpbT'; MINSpbT; MAXSpbT; AvgSpbFall'; RainSpb'];
writematrix(Saint_Petersburg, 'tableSpb.xlsx');

%TABLE FOR MURMANSK
Murmansk=[AvgMurT'; MINMurT; MAXMurT; AvgMurFall'; RainMur'];
writematrix(Murmansk, 'tableMur.xlsx');

%TABLE FOR SOCHI
Sochi=[AvgSochiT'; MINSochiT; MAXSochiT; AvgSochiFall'; RainSochi'];
writematrix(Sochi, 'tableSochi.xlsx');

%TABLE FOR VLADIVOSTOK
Vladivostok=[AvgVladT'; MINVladT; MAXVladT; AvgVladFall'; RainVlad'];
writematrix(Vladivostok, 'tableVlad.xlsx');

