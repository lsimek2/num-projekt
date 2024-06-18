% nedovrseno - maknuti

% de Boor-Coxova rekurzija (evaluacija 1d B-splinea)
% vektorizirano i bez rekurzije u implementaciji
% ova verzija je vektorizirana i (i je stupac, x je bilo kakav tenzor)
function y = deBoorCoxRec2(x, k, i, t)
  % t redak, x stupac/matrica, i stupac

  xsize = size(x);
  q = prod(xsize);
  x = reshape(x', q, 1);

  [r, _] = size(i);
  % i = reshape(i, 1, 1, r);

  n = length(t) - k;

  B = zeros(q, k, r);

  % pocinjemo od k B-splineova reda 1
  % u k-1 iteracija povecavamo red do k

  % baza
  for idxi=1:r
    % ii = i(:, :, idxi);
    ii = i(idxi);
    for j=ii:(ii+k-1)
      B(:, j-(ii-1), idxi) = t(j) <= x & (x < t(j+1) | (x == t(j+1) & j == n));
    endfor
  endfor

  K = k;
  I = i;
  for k=2:K
    for i=I:(I+K-k)
      w_1 = zeros(q, 1, r);
      w_2 = zeros(q, 1, r);

      if t(i+k-1) ~= t(i)
        w_1 = (x-t(i)) / (t(i+k-1) - t(i));
      endif

      if t(i+k) ~= t(i+1)
        w_2 = (x-t(i+1)) / (t(i+k) - t(i+1));
      endif

      B(:, i-I+1, :) = w_1.*B(:, i-I+1, :) + (1-w_2).*B(:, i-I+2, :);
    endfor
  endfor

  y = B(:, 1);
endfunction

