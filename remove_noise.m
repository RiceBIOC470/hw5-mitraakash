function img_dilate = remove_noise(img)

img_dilate = imopen(img, strel('disk',5));
