  %% Parameters
  
  %s = 0.005;      % Step size
  %it = 255;        % Iteration depth
  %% Prepare the complex plane
  %[wa ha] = meshgrid (w(1):s:w(2), h(1):s:h(2));
  %complex_plane = wa + ha * i;
  % z = complex_plane;
  clc;
  clear;
  close all;
  pkg load image
  pkg load video
  
  ##  fn = fullfile (tempdir(), "mandel.mp4");
  ##  w = VideoWriter (fn);
  ##  open (w);
  
  function z = build_array(d,r,w,h)
    [wa ha] = meshgrid (linspace(d(1),d(2),w), linspace(r(1),r(2),h));
    z = wa+ha*i;
  endfunction
  
  d = [-2.25,1.25]; % Domain
  r = [-1.25,1.25]; % Range
  
  w = 1920/4;
  h = 1200/4;
  it = 256;
  
  
  r_offs = 0;
  d_offs = 0;
  sfactor = .9;
  
  d_mean_offs = 0;
  
  i = 0;
  while(i<20000)
  row = 1;
  
  z = build_array(d,r,w,h);
  mandel_img = mandel(z,it);
  
  d = (d+d_offs);
  r = (r+r_offs);
  dmean = mean(d);
  rmean = mean(r);
  d(2) = d(2) - (d(2)-dmean)*(1-sfactor);
  d(1) = d(1) - (d(1)-dmean)*(1-sfactor);
  r(2) = r(2) - (r(2)-rmean)*(1-sfactor);
  r(1) = r(1) - (r(1)-rmean)*(1-sfactor);
  w2d = (d(2)-d(1))/w;
  h2r = (r(2)-r(1))/h;
  
  
  mandel_img_edge = mandel_img-imsmooth(mandel_img,'Gaussian');
  [x,y] = weighted_centroid(mandel_img_edge,0);
  mandel_img = uint8(255*(mandel_img./max(mandel_img(:))));
  
  
  r_offs = (h2r*y);
  d_offs = (w2d*x);
  
  
  mandel_img = 255-mandel_img;
  cmap = [cubehelix(max(mandel_img(:)))];
  mandel_rgb = ind2rgb (gray2ind(mandel_img,255), cmap);
  imwrite(mandel_rgb, ['mandels/mandel' num2str(i) '.png'],'Quality',100);
  imwrite(mandel_img_edge, ['edges/mandel_edge' num2str(i) '.png'],'Quality',100);
  %% Check Contrast
  indx = mandel_img > 0 & mandel_img < 255;
  mmax = double(max(mandel_img(indx)));
  mmin = double(min(mandel_img(indx)));
  K = (mmax-mmin)/(mmax+mmin);
  if(K < 0.7)
  K
  it = round(it/(.9-sfactor))
endif

##imshow(mandel_img,cmap);
##writeVideo (w, mandel_img);
i = i + 1
endwhile
##close (w)

