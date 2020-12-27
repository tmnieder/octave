  %% Parameters
  %w = [-2.25 1.25]; % Domain
  %h = [-1.25 1.25]; % Range
  %s = 0.005;      % Step size
  %it = 255;        % Iteration depth
   %% Prepare the complex plane
  %[wa ha] = meshgrid (w(1):s:w(2), h(1):s:h(2));
  %complex_plane = wa + ha * i;
   % z = complex_plane;
function [I,z] = mandel(z,it);
  tic
    %% Preallocate image
  I = zeros( size(z));
  zi = z;
  
  z(abs(z)>=2) = 0;
  I(abs(z)<2) = I(abs(z)<2)+1;
  indx = abs(z) ~= 0;
  for i = 1:it
    indx = (abs(z)<2 & indx);
    z(indx) = z(indx).^2 + zi(indx);
    I(indx) = I(indx) + 1;
  end
  
  I = I-1;
  toc
end