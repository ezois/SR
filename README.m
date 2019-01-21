%% Demo code which describes the algorithm proposed in:
% % A comprehensive study of sparse representation techniques for offline signature verification
% % E.N Zois, D Tsourounis, I. Theodorakopoulos, A. Kesidis & G. Economou
% % - Accepted for publication in: IEEE Transactions on Biometrics, Behavior, and Identity Science.

%% Steps
%% 1. Place and compile KSVD & OMP toolbox codes at the KSVD_OMP_Tools directory
%     http://www.cs.technion.ac.il/~ronrubin/software.html
%% 2. As in the example:
% Place the reference genuine signatures of a writer at .\someimages\original\Reference directory
% Place the reference remaining signatures of a writer at .\someimages\original\Remaining directory
% Place the skilled forgery signatures of a writer at .\someimages\skilled_forgs directory
% Place the random forgery signatures of a writer at .\someimages\random_forgs directory

%% Unzip file someimages.rar into the someimages directory. 

%% 4. Run the main.m file as: 

% [f1,f2,f3,f4,f5,qRM1,qRM2,qRM3,qRM4,qRM5,qSF1,qSF2,qSF3,qSF4,qSF5,qRF1,qRF2,qRF3,qRF4,qRF5]=main();

% It returns features (f1-f5) with the following meaning:
% f1: mean pooling
% f2: max pooling
% f3: std pooling
% f4: L1 norm pooling
% f5: L2 norm pooling

% For example:
% f3.fgtr_s is a (f3-std) 5x360 reference (for the learning stage) feature vector.

% qRF3(1).q ((1) stand for the 1st) is a (f3-std) 1x360 questioned (or training) random forgery feature vector  
% in this case we have 54 random forgery samples: qRF3(1).q ...-... qRF3(54).q

% qSF3(1).q ((1) stand for the 1st) is a (f3-std) 1x360 questioned skilled forgery feature vector 
% in this case we have 24 random forgery samples: qSF3(1).q ...-... qSF3(24).q

% qRM3(1).q ((1) stand for the 1st) is a (f3-std) 1x360 questioned remaining genuine feature vector
% in this case we have 19 remaining genuine samples: qRF3(1).q ...-... qRF3(19).q

%% Feature structure: 
% 1:60 dims: entire signature window
% 61:120 dims: entire signature window - with BRISK keypoints
% 121:end dims: features derived from the spatial pyramid. 

%% For example in a 2x2 spatial pyramid the f3 feature breakdown is: 
% f3(:,1:60)   : 1x1 window
% f3(:,61:120) : 1x1 BRISK window
% f3(:,121:360): 2x2 = 4 segments (x60 = 240 features) of the spatial pyramid


