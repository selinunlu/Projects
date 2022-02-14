%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%% "DÝKDÖRTGEN DALGAKILAVUZU" %%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%% SÜ & BK & NC %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% 
clear all;	% çalýþma alanýndaki tüm nesneleri temizler
clc;        % komut Penceresi ekranýndaki tüm girdi ve çýktýlarý temizleyerek temiz bir ekran sunar

%% Boþ uzay parametreleri
epsilon0 = (1 / (36*pi)) * (10^-9); %boþluðun elektriksel geçirgenliði  (farad/metre (F/m)))
mu0 = 4 * pi * (10^-7);             %boþluðun manyetik geçirgenliði     (henry/metre (H/m))
c = 3 * (10^8);                     %ýþýðýn hýzý   

%% Maksimum frekans ve minimum dalga boyu
% frequency = 0.618 * (10^9);    %(hertz (Hz))
% lambda = c / frequency;         %(metre (m))

%% x ve y yönündeki hücre sayýsý
Nx = 200;     %x ekseninde hücre sayýsý
Ny = 200;     %y ekseninde hücre sayýsý

%% Kaynaðýn konumu
xsource = 100;
ysource = 100;

%% hücre boyutlarý
% dx = lambda / 10;   
dx = 0.005;     %x ekseninde hücre boyutu   (metre (m))
dy = dx;        %y ekseninde hücre boyutu   (metre (m))

% n = 1;
% frequency = n / (2*Ny*dy*sqrt(mu0*epsilon0)); %MUR

frequency = 151000000;

%% %% Courant Stability Þartý
dt = 1 / ( c*sqrt( ((1/dx)^2) + ((1/dx)^2)) );   %zaman adýmý

%% Toplam zaman adýmý sayýsý
Tsim = 10000;	%(saniye (s))   

%% Bütün alan bileþenlerinin deðerlerinin sýfýrlanmasý
Hx = zeros(Nx,   Ny-1);
Hy = zeros(Nx-1, Ny);
Ez = zeros(Nx,   Ny);

%% 
k=1;
b = (c*dt-dx)/(c*dt+dx);

t0=100;
ndecay=200;
w = 500;
r = 200;

for t=1:1:Tsim

    Ez(2:Nx-1,2:Ny-1) = Ez(2:Nx-1,2:Ny-1) + (dt/(epsilon0*dx))*( Hy(2:Nx-1,2:Ny-1)-Hy(1:Nx-2,2:Ny-1)-Hx(2:Nx-1,2:Ny-1)+Hx(2:Nx-1,1:Ny-2) );
    Ez(xsource,ysource) = Ez(xsource,ysource) + sin(2*pi*frequency*t*dt);  
%     Ez(2:Nx-1,2:Ny-1) = Ez(2:Nx-1,2:Ny-1) + exp ( - r*(t-100)^2/(w^2)); %Gaussian Pulse
          
        %MUR
    for j=1:1:Ny
        Ezeski(2,j) = Ez(2,j);
        Ezeski(Nx-1,j) = Ez(Nx-1,j);
    end
    
    for j=1:1:Ny
        Ez(1,j) = Ezeski(2,j)+ b.*(Ez(2,j)- Ez(1,j));
        Ez(Nx,j) = Ezeski(Nx-1,j)+b.*(Ez(Nx-1,j)-Ez(Nx,j));
    end 
    
    Hx(:,1:Ny-1) = Hx(:,1:Ny-1) - (dt/(mu0*dx)) * ( Ez(:,2:Ny) - Ez(:,1:Ny-1) );    
    Hy(1:Nx-1,:) = Hy(1:Nx-1,:) + (dt/(mu0*dx)) * ( Ez(2:Nx,:) - Ez(1:Nx-1,:) );
     
    A(k) = Ez(100,60);
        
    k=k+1;
    
end

%% Fast Fourier Transformu

fezr_1=fft(A);
df=1/dt;
npoint_1=length(A);
fr_1=df*(0:npoint_1/2)/npoint_1;

result_1=fezr_1(1:npoint_1/2+1);

%% 
figure();
 
subplot(311);    
pcolor(1:Ny,1:Nx,Ez(1:Nx,1:Ny));
shading interp;
colorbar;
title('FDTD');

% Plot time domain
subplot(312);
plot(A);
grid on
title('(100,25)');
xlabel('Time Step[n]');
ylabel('Ez[n]');

% Plot frequency domain
subplot(313);
plot(fr_1,abs(result_1));
grid on
title('(100,25)');
xlabel('Frequency[Hz]');
ylabel('|Ez[n]|');


    


