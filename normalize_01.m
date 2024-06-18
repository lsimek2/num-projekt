% funkcije za upravljanje bojanjem %
% preuzete sa https://stackoverflow.com/questions/74642517/surfaces-with-different-colormaps%
function normalized = normalize_01(data)
  data_min = min(min(data));
  data_max = max(max(data));
  normalized = (data - data_min)/(data_max - data_min);
endfunction
