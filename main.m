function [f1,f2,f3,f4,f5,qRM1,qRM2,qRM3,qRM4,qRM5,qSF1,qSF2,qSF3,qSF4,qSF5,qRF1,qRF2,qRF3,qRF4,qRF5]=main()
addpath(genpath('.\thecodes')) % adds to path along with subdirectories.
addpath(genpath('.\KSVD_OMP_Tools')) % adds to path along with subdirectories.
Ver = 'demo';

% GENUINE REFERENCE TRAINING SAMPLES
algorithm.NSamples=5;

%GRAY LEVEL OR BINARY IMAGES
algorithm.borgray='gray';

%PATCH_SIZE
algorithm.patch_size=5;

%PATCH_CENTER
algorithm.patch_center='yes';

%#_ATOMS
Dictionary_Size=60;

%#_sparsity_level
SL=3;

%#_SEGMENTS
% defines the number of spatial pyramid segments per signature.
algorithm.nosegms=3; 

%#_Reference thin_level
ref_thin_lev=1;

%% Bulding Dictionary
% Example: the first five samples for reference
dirgen='.\someimages\original\Reference';
for j=1:algorithm.NSamples
    img=imread([dirgen '\original_1_' num2str(j) '.png']);
    [bcropped_image{1,j},thin_image1{1,j}]=image_prepr_crop_1(img, ref_thin_lev);
    figure(j),
    subplot(311),subimage(img), title(['REF ' num2str(j) ' original image'])
    subplot(312),subimage(thin_image1{1,j}), title(['REF ' num2str(j) ' gray cropped thinned'])
    subplot(313),subimage(bcropped_image{1,j}), title(['REF ' num2str(j) ' BW cropped thinned'])    
end
refTHimages=thin_image1;
refBWimages=bcropped_image;
% Reference Features (f*.fgtr_s) and Dictionary (Dref)
[Dref,f1,f2,f3,f4,f5]=main_SS_ref_features(refTHimages,refBWimages,SL,Dictionary_Size,algorithm);
close all
%% remaining genuine features
dirgen='.\someimages\original\Remaining';

% Number of remaining samples
remgsamples=24-algorithm.NSamples;

% set questioned signature thin_level
q_thin_lev=ref_thin_lev;

%% Remaining genuine
disp('Remaining')
for j=1:remgsamples
    img=imread([dirgen '\original_1_' num2str(algorithm.NSamples+j) '.png']);
    [QBWimage,QTHimage]=image_prepr_crop_1(img, q_thin_lev);
    figure(j),
    subplot(311),subimage(img), title(['REM ' num2str(algorithm.NSamples+j) ' original image'])
    subplot(312),subimage(QTHimage), title(['REM ' num2str(algorithm.NSamples+j) ' gray cropped thinned'])
    subplot(313),subimage(QBWimage), title(['REM ' num2str(algorithm.NSamples+j) ' BW cropped thinned'])
    drawnow;
    % questioned signature feature extraction (remaining samples)
    [qRM1(j),qRM2(j),qRM3(j),qRM4(j),qRM5(j)]=main_SS_q_features(Dref, QTHimage,QBWimage,SL,Dictionary_Size,algorithm);
end
close all

%% Skilled forgeries
% set questioned thin_level
q_thin_lev=ref_thin_lev;
dirSF='.\someimages\skilled_forgs';
disp('Skilled')
for jSF=1:24
    img=imread([dirSF '\forgeries_1_' num2str(jSF) '.png']);
    [QBWimage,QTHimage]=image_prepr_crop_1(img, q_thin_lev);
    figure(jSF),
    subplot(311),subimage(img), title(['SF ' num2str(jSF) ' Skilled Forgery image'])
    subplot(312),subimage(QTHimage), title(['SF ' num2str(jSF) ' gray cropped thinned'])
    subplot(313),subimage(QBWimage), title(['SF ' num2str(jSF) ' BW cropped thinned'])    
    drawnow;
    % questioned signature feature extraction (Skilled Forgery samples)
    [qSF1(jSF),qSF2(jSF),qSF3(jSF),qSF4(jSF),qSF5(jSF)]=main_SS_q_features(Dref, QTHimage,QBWimage,SL,Dictionary_Size,algorithm);
end
close all
%% Random forgeries
% set qthin_level
q_thin_lev=ref_thin_lev;
dirgen='.\someimages\random_forgs';
disp('Random')
RFindx=0;
for jRF=2:55
    RFindx=RFindx+1;
    img=imread([dirgen '\original_' num2str(jRF) '_1.png']);
    [QBWimage,QTHimage]=image_prepr_crop_1(img, q_thin_lev);
    figure(jRF),
    subplot(311),subimage(img), title(['RF ' num2str(jRF) ' Random Forgery image'])
    subplot(312),subimage(QTHimage), title(['RF ' num2str(jRF) ' gray cropped thinned'])
    subplot(313),subimage(QBWimage), title(['RF ' num2str(jRF) ' BW cropped thinned'])    
    drawnow;
    % questioned signature feature extraction (Random Forgery samples)
    [qRF1(RFindx),qRF2(RFindx),qRF3(RFindx),qRF4(RFindx),qRF5(RFindx)]=main_SS_q_features(Dref, QTHimage,QBWimage,SL,Dictionary_Size,algorithm);
end
close all

rmpath(genpath('.\KSVD_OMP_Tools'))
rmpath(genpath('.\thecodes'))




