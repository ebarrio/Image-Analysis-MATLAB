%% Parameter characterization
close all, clear all, clc;
cold = imread('cold_fpga.jpg');
hot = imread('hot_fpga.jpg');
%%  1.1 HISTOGRAM (PDF)
rgb_vs_gray = figure (1); rgb_vs_gray.WindowState = 'maximized';
fontsize = 12;
set(0,'DefaultAxesFontSize',fontsize);
title('Hot FPGA');
% HOT SPOT
subplot(2,4,1),imshow(hot),title('Hot FPGA'), colorbar;
subplot(2,4,2),histfit(hot(:),220), grid on ,title('Hot FPGA PDF'), colorbar;
gry_hot = rgb2gray(hot);
subplot(2,4,3),imshow(gry_hot), title('Hot FPGA Gray Scale'), colorbar;
subplot(2,4,4),histfit(gry_hot(:),220), grid on, , title('Hot FPGA GS PDF'), colorbar;
% COLD SPOT
subplot(2,4,5),image(cold),title('Cold FPGA'), colorbar;
subplot(2,4,6),histfit(cold(:),220), grid on ,title('Cold FPGA PDF'), colorbar;
gry_cold = rgb2gray(cold);
subplot(2,4,7),imshow(gry_cold), title('Cold FPGA Gray Scale'), colorbar;
subplot(2,4,8),histfit(gry_cold(:),220), grid on, title('Cold FPGA GS PDF'), colorbar;
%% 1.2 Covariance
gry_hot = double(gry_hot);
gry_cold = double(gry_cold);
cold_cov = cov(gry_cold);
hot_cov = cov(gry_hot);
coviariance_fig = figure(2); coviariance_fig.WindowState = 'maximized';
subplot(2,2,1), imshow(cold), colorbar;
subplot(2,2,2), imshow(cold_cov), colorbar;
subplot(2,2,3), imshow(hot), colorbar;
subplot(2,2,4), imshow(hot_cov), colorbar;
%% 2.1 RBB ANALYSIS BIVARIATE HISTOGRAM
for i = 1:2
    if (i == 1)
        fig_hot = figure(3);fig_hot.WindowState = 'maximized';fig_hot.Name = 'HOT RGB ANALYSIS';
        r = hot(:,:,1); g = hot(:,:,2); b = hot(:,:,3);
    else
        fig_cold = figure(4);fig_cold.WindowState = 'maximized';fig_cold.Name = 'COLD RGB ANALYSIS';
        r = cold(:,:,1); g = cold(:,:,2); b = cold(:,:,3);       
    end
    % RED VS GRREN
   
    subplot(2,2,1);
    h1 = histogram2(r,g,'DisplayStyle','tile','ShowEmptyBins','on', ...
        'XBinLimits',[0 255],'YBinLimits',[0 255]);
        axis equal; colorbar, xlabel('Red Values')
        ylabel('Green Values'), title('Green vs. Red Pixel Components')
        ax = gca; ax.CLim = [0 500];
    % RED VS BLUE
    subplot(2,2,2);
    histogram2(r,b,'DisplayStyle','tile','ShowEmptyBins','on', ...
        'XBinLimits',[0 255],'YBinLimits',[0 255]);
        axis equal; colorbar, xlabel('Red Values')
        ylabel('Blue Values'), title('Blue vs. Red Pixel Components')
        ax = gca; ax.CLim = [0 500];
    % GREEN VS BLUE
    subplot(2,2,3);
    histogram2(g,b,'DisplayStyle','tile','ShowEmptyBins','on', ...
        'XBinLimits',[0 255],'YBinLimits',[0 255]);
        axis equal; colorbar, xlabel('Green Values')
        ylabel('Blue Values'), title('Blue vs. Green Pixel Components')
        ax = gca; ax.CLim = [0 500];
    subplot(2,2,4);
    histogram(r,'BinMethod','integers','FaceColor','r','EdgeAlpha',0,'FaceAlpha',1) 
    hold on, histogram(g,'BinMethod','integers','FaceColor','g','EdgeAlpha',0,'FaceAlpha',0.7)
    histogram(b,'BinMethod','integers','FaceColor','b','EdgeAlpha',0,'FaceAlpha',0.7)
    xlabel('RGB value'); ylabel('Frequency'); title('Color histogram in RGB color space');
    xlim([0 257]);
end