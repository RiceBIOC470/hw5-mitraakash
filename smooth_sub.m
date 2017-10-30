function img_sm_bgsub = smooth_sub(img, radius, sigma)

img_sm = imfilter(img, fspecial('gaussian',radius,sigma));
img_bg = imopen(img_sm, strel('disk',10));
img_sm_bgsub = imsubtract(img_sm, img_bg);
