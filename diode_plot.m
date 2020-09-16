close all % st�nger alla �ppna figurer
clear all % tar bort alla definierade variabler
clc       % rensar "Command Window"

 %Fyll i uppm�tt diodsp�nning Vd (V) och diodstr�m Id (A) i nedanst�ende vektorer

Vdlab = [0.598 0.679 0.735 0.772 0.800 0.822 0.831 0.839 0.847 0.855 0.862 0.866 0.870 0.874 0.875 0.879 0.880 0.884];
Idlab = [0.7 4.0 12.0 23.3 36.3 50.7 58.1 65.6 73.3 81.0 87.2 91.8 96.5 99.5 102.9 106.0 109.2 112.3]*1e-3;

% M�tdata f�r Vd < 0.51V fr�n Keithley 4200 (utanf�r tidsramen f�r labben)

Vd = [0.005:0.005:0.1 0.125:0.025:0.2 0.25:0.05:0.5 0.51];
Id = [[0.2 0.45 0.75 1.1 1.5 2 2.5 3 3.7 4.6 5.4 6.4 7.5 8.8 10.0 11.4 13.1...
    15.0 17.3 19.4 35.6 63.1 106.5 178 487]*1e-9 [1.32 3.62 10.1 28.6 83.5 103.3]*1e-6];

% G�r en gemensam vektor f�r bifogad och uppm�tt m�tdata 

Vd = [Vd Vdlab];
Id = [Id Idlab];

% Plotta diodkarakteristiken i linj�r skala med "styckevis linj�r modell"

Vdsl = linspace(0, 0.9,100);

Vbi = 0.765; 
Rs = 1.1; 

Idsl=zeros(1,length(Vdsl));
for idx=1:length(Vdsl)
    
    if Vdsl(idx) > Vbi
        
        Idsl(idx) = (Vdsl(idx)-Vbi)/Rs;
        
    end
end

figure(1)
plot(Vd,Id,'*')
hold on
plot(Vdsl,Idsl,'r--')
xlabel('V_d (V)')
ylabel('I_d (A)')
title('Linj�r skala')
legend('M�tdata','Styckevis linj�r modell','Location','NorthWest')

% Plotta diodkarakteristiken i semilogaritmisk skala med "ideala diodekvationen"

% Utan serieresistans

Vdmod = linspace(0, 0.9,100);

I0 = 4e-10; % <-- FYLL I "DIODM�TTNADSTR�MMEN I BACKRIKTNINGEN"
n = 1.6;     % <-- FYLL I "IDEALITETSFAKTORN"

kB = 8.62e-5; % eV/K
T = 298;      % K
Vth = kB*T;   % termiska sp�nningen vid rumstemperatur

Idmod = I0*(exp(Vdmod/(n*Vth))-1);

figure(2)
semilogy(Vd,Id,'*')
hold on
semilogy(Vdmod,Idmod,'r--')
xlabel('V_d (V)')
ylabel('I_d (A)')
title('Semilogaritmisk skala')

% Med serieresistans

Rs = 1.1;  % <-- FYLL I "SERIERESISTANS F�R IDEALA DIODEKVATIONEN"

Idmod = 2*logspace(-10,-1,100);
Vdmod = log(Idmod/I0+1)*n*Vth+Idmod*Rs;

semilogy(Vdmod,Idmod,'k--')
legend('M�tdata','Ideala diodekvationen R_s = 0','Ideala diodekvation R_s \neq 0','Location','NorthWest')
