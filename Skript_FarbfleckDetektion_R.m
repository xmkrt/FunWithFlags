%% Rücksetzen der Umgebung
clc, clear, close all
%% 
pfad = './';

%name = [pfad  'Flag_of_Germany.png'];
name = uigetfile;

[rgb,hsv] = FarbModelleDarstellung(name,1);

%% Setzen von Parametern
% Für ROT
nhood = ones(1); % Nachbarschaft für morphologische Operationen
nrpixel = 20; % Mindestgröße von interessierenden Regionen
kanaele = [1,2,3];

%% Auswertung aus dem RGB-Farbmodell
%% Erkennung von farbe-Bereichen

%%farbWert = [0.8,0.1,0.1]; % RGB: rot
%%farbDistanz = 0.2;
%%farbWichtung = [1 0.95 0.9]; %Wichtung der Farbkanäle

farbeNameWeiss = 'Weiss';
farbWertWeiss = [1,1,1]; % RGB: weiss

farbeNameGruen = 'Gruen';
farbWertGruen = [0.2,0.6,0.2]; % RGB: gruen

farbeNameSchwarz = 'Schwarz';
farbWertSchwarz = [0,0,0]; % RGB: schwarz

farbeNamegelb = 'Gelb';
farbWertgelb = [1,0.8,0]; % RGB: gelb

farbeNameBlau = 'Blau';
farbWertBlau = [0, 0.21, 0.71]; % RGB: blau

farbeNameRot = 'Rot';
farbWertRot = [0.9,0,0]; % RGB: rot

farbDistanz = 0.2;
farbWichtung = [1 0.95 0.9]; %Wichtung der Farbkanäle

bw_rgb_weiss = FarbErkennungDistanz_RGB(rgb,name,farbeNameWeiss,farbWertWeiss,farbDistanz,farbWichtung);
bw_rgb_blau = FarbErkennungDistanz_RGB(rgb,name,farbeNameBlau,farbWertBlau,farbDistanz,farbWichtung);
bw_rgb_rot = FarbErkennungDistanz_RGB(rgb,name,farbeNameRot,farbWertRot,farbDistanz,farbWichtung);
bw_rgb_gelb = FarbErkennungDistanz_RGB(rgb,name,farbeNamegelb,farbWertgelb,farbDistanz,farbWichtung);
%bw_rgb_schwarz = FarbErkennungDistanz_RGB(rgb,name,farbeNameBlau,farbWertBlau,farbDistanz,farbWichtung);
%bw_rgb_gruen = FarbErkennungDistanz_RGB(rgb,name,farbeNameBlau,farbWertBlau,farbDistanz,farbWichtung);


%% Erkennung und Schließen der Regionen
% nach Öffnen, Aureißer-Bereinigung (zu kleine Gebiete) und Schließen
bw_rgb1_weiss = BereichErkennen(bw_rgb_weiss,name,farbeNameWeiss,nhood,nrpixel);
bw_rgb1_blau = BereichErkennen(bw_rgb_blau,name,farbeNameBlau,nhood,nrpixel);
bw_rgb1_rot = BereichErkennen(bw_rgb_rot,name,farbeNameRot,nhood,nrpixel);
bw_rgb1_gelb = BereichErkennen(bw_rgb_gelb,name,farbeNamegelb,nhood,nrpixel);

%% Bestimmen von Regionen und deren Eigenschaften 
% regions_rgb = bwconncomp(bw_rgb1);
disp('Ergebnisse für RGB-Farberkennung:');

regions_rgb_weiss = bwlabel(bw_rgb1_weiss);
props_rgb_weiss = regionprops(regions_rgb_weiss);

disp(['Anzahl der ' farbeNameWeiss 'en Regionen: ' num2str(size(props_rgb_weiss,1))]);

white_area = 0.0;
for k = 1 : size(props_rgb_weiss,1),
        white_area += uint32(100*props_rgb_weiss(k).Area/(size(rgb,1)*size(rgb,2)));
end

[max_white_area,max_white_index] = max([props_rgb_weiss.Area]);
[min_white_area,min_white_index] = min([props_rgb_weiss.Area]);

disp(['Die groesste weisse flaeche ist [px]:' num2str(max_white_area)]);
disp(['Die kleinse weisse flaeche ist [px]:' num2str(min_white_area)]);

%%['a' 2]
%% Ausgabe
disp(['Der weiss anteil betraegt ' num2str(white_area) '%']);

regions_rgb_blau = bwlabel(bw_rgb1_blau);
props_rgb_blau = regionprops(regions_rgb_blau);

disp(['Anzahl der blauen Regionen: ' num2str(size(props_rgb_blau,1))]);

blue_area = 0.0;
for k = 1 : size(props_rgb_blau,1),
        blue_area += uint32(100*props_rgb_blau(k).Area/(size(rgb,1)*size(rgb,2)));
end

[max_blue_area,max_blue_index] = max([props_rgb_blau.Area]);
[min_blue_area,min_blue_index] = min([props_rgb_blau.Area]);

disp(['Die groesste blaue flaeche ist [px]: ' num2str(max_blue_area)]);
disp(['Die kleinse blaue flaeche ist [px]: ' num2str(min_blue_area)]);

regions_rgb_red = bwlabel(bw_rgb1_rot);
props_rgb_red = regionprops(regions_rgb_red);

disp(['Anzahl der ' farbeNameRot 'en Regionen: ' num2str(size(props_rgb_red,1))]);
red_area = 0.0;
for k = 1 : size(props_rgb_red,1),
        red_area += uint32(100*props_rgb_red(k).Area/(size(rgb,1)*size(rgb,2)));
end

[max_red_area,max_red_index] = max([props_rgb_red.Area]);
[min_red_area,min_red_index] = min([props_rgb_red.Area]);

disp(['Die groesste rote flaeche ist [px]:' num2str(max_red_area)]);
disp(['Die kleinse rote flaeche ist [px]:' num2str(min_red_area)]);

disp(['Der ' farbeNameRot 'anteil betraegt ' num2str(red_area) '%']);

regions_rgb_gelb = bwlabel(bw_rgb1_gelb);
props_rgb_gelb = regionprops(regions_rgb_gelb);

disp(['Anzahl der ' farbeNamegelb 'en Regionen: ' num2str(size(props_rgb_gelb,1))]);

Yellow_area = 0.0;
for k = 1 : size(props_rgb_gelb,1),
        Yellow_area += uint32(100*props_rgb_gelb(k).Area/(size(rgb,1)*size(rgb,2)));
end

[max_Yellow_area,max_Yellow_index] = max([props_rgb_gelb.Area]);
[min_Yellow_area,min_Yellow_index] = min([props_rgb_gelb.Area]);

disp(['Die groesste gelbe flaeche ist [px]:' num2str(max_Yellow_area)]);
disp(['Die kleinse gelbe flaeche ist [px]:' num2str(min_Yellow_area)]);

['a' 2]
%% Ausgabe
disp(['Der gelb anteil betraegt ' num2str(Yellow_area) '%']);


%% Ergebnisdarstellung
figure, subplot(2,3,1), imshow(rgb); title('Original')
subplot(2,3,2), imshow(maskImage( rgb, bw_rgb1_weiss )); title('Auswahl Weiss aus RGB')
subplot(2,3,5), imshow(maskImage( rgb, ~bw_rgb1_weiss )); title('Rest Weiss aus RGB')
subplot(2,3,3), imshow(maskImage( rgb, bw_rgb1_blau )); title('Auswahl Blau aus RGB')
subplot(2,3,6), imshow(maskImage( rgb, ~bw_rgb1_blau )); title('Rest Blau aus RGB')