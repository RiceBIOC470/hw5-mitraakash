% Akash Mitra
% am132

%HW5

% Note. You can use the code readIlastikFile.m provided in the repository to read the output from
% ilastik into MATLAB.

%% Problem 1. Starting with Ilastik

% Part 1. Use Ilastik to perform a segmentation of the image stemcells.tif
% in this folder. Be conservative about what you call background - i.e.
% don't mark something as background unless you are sure it is background.
% Output your mask into your repository. What is the main problem with your segmentation?  

% Main problem is that background in addition to cells are selcected. 
% The segmentation criteria is too lenient

% Part 2. Read you segmentation mask from Part 1 into MATLAB and use
% whatever methods you can to try to improve it. 

% imgx = h5read('/Users/amitra2/Documents/CompBioRice17/Homework5/hw5-mitraakash/PredictionforLabel1.h5', '/exported_data');
% imgx = squeeze(imgx);
% imshow(imgx,[]);

img = h5read('/Users/amitra2/Documents/CompBioRice17/Homework5/hw5-mitraakash/PredictionFromSlides.h5', '/exported_data');
img = squeeze(img);
imshow(img,[]);

%imshowpair(img, imgx, 'montage');

radius = 4;
sigma = 2;
img_sm_bgsub = smooth_sub(img, radius, sigma);
imshow(img_sm_bgsub,[])

img_auto_threshold = auto_threshold(img_sm_bgsub);
imshow(img_auto_threshold);

img_clean = remove_noise(img_auto_threshold);
imshow(img_clean);

% Part 3. Redo part 1 but now be more aggresive in defining the background.
% Try your best to use ilastik to separate cells that are touching. Output
% the resulting mask into the repository. What is the problem now?

img1 = h5read( '/Users/amitra2/NewPrediction.h5', '/exported_data');
img1 = squeeze(img1);
imshow(img1,[]);

% Used more labels on seperating cells; resulted in seperation being too
% stringent and losing cells.

% Part 4. Read your mask from Part 3 into MATLAB and try to improve
% it as best you can.

radius = 4;
sigma = 2;
img_sm_bgsub1 = smooth_sub(img1, radius, sigma);
imshow(img_sm_bgsub1,[])

img_auto_threshold1 = auto_threshold(img_sm_bgsub1);
imshow(img_auto_threshold1);

img_clean1 = remove_noise(img_auto_threshold1);
imshow(img_clean1);


%% Problem 2. Segmentation problems.

% The folder segmentationData has 4 very different images. Use
% whatever tools you like to try to segement the objects the best you can. Put your code and
% output masks in the repository. If you use Ilastik as an intermediate
% step put the output from ilastik in your repository as well as an .h5
% file. Put code here that will allow for viewing of each image together
% with your final segmentation. 

img2 = h5read( '/Users/amitra2/Documents/CompBioRice17/Homework5/hw5-mitraakash/Bacteria.h5', '/exported_data');
img2 = squeeze(img2);
imshow(img2,[]);

imshow(post_segment_adjustment(img2),[]);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

figure;
img3 = imread('segmentationData/cellPhaseContrast.png');
imshow(img3, []);
mask1 = img3 < 120;
imshow(mask1, []);

CC = bwconncomp(mask1);
stats = regionprops(CC, 'Area');
area = (stats.Area);
s = round(1.2*sqrt(mean(area))/pi);
eroded = imerode(mask1, strel('disk',s));
outside = ~imdilate(mask1, strel('disk',1));
basin = imcomplement(bwdist(outside));
basin = imimposemin(basin,eroded|outside);
new_image = watershed(basin);
new_image = new_image > 2;
imshow(new_image, [])

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

img4 = h5read( '/Users/amitra2/Documents/CompBioRice17/Homework5/hw5-mitraakash/Worm.h5', '/exported_data');
img4 = squeeze(img4);
imshow(img4,[]);

imshow(post_segment_adjustment(img4),[]);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

img5 = h5read( '/Users/amitra2/Documents/CompBioRice17/Homework5/hw5-mitraakash/Yeast.h5', '/exported_data');
img5 = squeeze(img5);
imshow(img5,[]);

imshow(post_segment_adjustment(img5),[]);
