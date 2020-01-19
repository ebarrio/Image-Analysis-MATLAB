%% IC detection
close all, clear all, clc;
cold = imread('cold_fpga.jpg');
hot = imread('hot_fpga.jpg');
%% Erode operation:
ops_fig = figure(); ops_fig.WindowState = 'maximized';ops_fig.Name = 'Erode image';
subplot(5,2,1); imagesc(hot)
for i = 1:20
    subplot(5,4,i);
    if(i/10 <= 1)
        se_erode_sqr = strel('square',5*i);
        I1 = imerode(hot,se_erode_sqr);
        imagesc(I1);
        title (strcat('Hot IC with N streal = ',num2str(5*i)));
    else
        se_erode_sqr = strel('square',5*(i-10));
        I1 = imerode(cold,se_erode_sqr);
        imagesc(I1);
        title (strcat('Cold IC with N streal = ',num2str(5*(i-10))));
    end
end
%% Dilate operation:
ops_fig = figure(); ops_fig.WindowState = 'maximized';ops_fig.Name = 'Dilate image';
subplot(5,2,1); imagesc(hot)
for i = 1:20
    subplot(5,4,i);
    if(i/10 <= 1)
        se_erode_sqr = strel('square',5*i);
        I1 = imdilate(hot,se_erode_sqr);
        imagesc(I1);
        title (strcat('Hot IC with N streal = ',num2str(5*i)));
    else
        se_erode_sqr = strel('square',5*(i-10));
        I1 = imdilate(cold,se_erode_sqr);
        imagesc(I1);
        title (strcat('Cold IC with N streal = ',num2str(5*(i-10))));
    end
end
%% Erode + squeeze
close all; clc
for j = 1:2
    if (j == 1)
        ops_fig = figure(); ops_fig.WindowState = 'maximized';ops_fig.Name = 'Erode(20px) + squeeze image';
        se_erode_sqr = strel('square',5);
    else
        ops_fig = figure(); ops_fig.WindowState = 'maximized';ops_fig.Name = 'Erode(30px) + squeeze image ';
        se_erode_sqr = strel('square',30);
    end
    
    N_R = 2; N_C = 5; i = 1; img_trg = 180;img_trg2 = 215;
    Ies = imerode(hot,se_erode_sqr);
    Ies = squeeze(Ies(:,:,1)); % Ralza pixeles oscuros en zonas luminosas
    subplot(N_R , N_C , i),imagesc(hot);i = i+1;
    subplot(N_R , N_C , i),imagesc(Ies);i = i+1;
    subplot(N_R , N_C , i),imagesc(Ies>110);i = i+1;
    subplot(N_R , N_C , i),imagesc(Ies>img_trg);i = i+1;
    subplot(N_R , N_C , i),imagesc(Ies>img_trg2);i = i+1;
    Ies = imerode(cold,se_erode_sqr);
    Ies = squeeze(Ies(:,:,1)); % Ralza pixeles oscuros en zonas luminosas
    subplot(N_R , N_C,i),imagesc(cold);i = i+1;
    subplot(N_R , N_C,i),imagesc(Ies);i = i+1;
    subplot(N_R , N_C,i),imagesc(Ies>110);i = i+1;
    subplot(N_R , N_C,i),imagesc(Ies>img_trg);i = i+1;
    subplot(N_R , N_C,i),imagesc(Ies>img_trg2);i = i+1;
end