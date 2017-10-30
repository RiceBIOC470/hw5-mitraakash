function x = post_segment_adjustment(img1)

radius = 4;
sigma = 2;
img_sm_bgsub1 = smooth_sub(img1, radius, sigma);
%imshow(img_sm_bgsub1,[])

img_auto_threshold1 = auto_threshold(img_sm_bgsub1);
%imshow(img_auto_threshold1);

img_clean1 = remove_noise(img_auto_threshold1);
%imshow(img_clean1);
x = img_clean1;