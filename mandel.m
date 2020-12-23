function mandel_img = mandel2();
  %% Parameters
  w = [-2.25 1.25]; % Domain
  h = [-1.25 1.25]; % Range
  s = 0.005;      % Step size
  it = 255;        % Iteration depth
  
  %% Prepare the complex plane
  [wa ha] = meshgrid (w(1):s:w(2), h(1):s:h(2));
  complex_plane = wa + ha * i;
  
  %% Preallocate image
  mandel_img = zeros( length(h(1):s:h(2)), length(w(1):s:w(2)));
  
  %% initialize Z
  z = complex_plane;
  z(abs(z)>=2) = 0;
  mandel_img(abs(z)<2) = mandel_img(abs(z)<2)+1;
  for i = 1:it
    I = (abs(z)<2);
    z(I) = z(I).^2 + complex_plane (I);
    mandel_img(I) = mandel_img(I) + 1;
    %% Display progress
    waitbar (i/it);
  end
  
  ##   cmap = [hot(63); 0 0 0];  # The colormap
  ##   imshow(mandel_img+1,cmap);
  mandel_img = mandel_img-1;
  mandel_img = mandel_img./max(mandel_img(:));
  mandel_img = histeq (mandel_img, 256);
  mandel_img = uint8(mandel_img);
  imshow(mandel_img);
  imwrite(mandel_img, "mandel.png",'Quality',100);
  
end