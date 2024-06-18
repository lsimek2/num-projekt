% funkcije za upravljanje bojanjem %
% preuzete sa https://stackoverflow.com/questions/74642517/surfaces-with-different-colormaps%
function rgb = data2rgb(data, color_bits, cmap)
  grays = normalize_01(data);
  indexes = gray2ind(grays, color_bits);
  rgb = ind2rgb(indexes, cmap);
endfunction
