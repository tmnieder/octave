function [x,y] = weighted_centroid(I,thresh)
  I(I<thresh) = 0;
  [H,W] = size(I);
  img_sum = sum(I(:));
  %These return x,y in image coordinates not zero centered.
  y = H/2-(H-sum(double(I)' * (1:H)')/img_sum);
  x = (sum(double(I)*(1:W)'/img_sum))-W/2;
##  figure; imshow(I); hold on;
##  plot_circle(x,y,5);
endfunction
