% de Boor-Coxova rekurzija (evaluacija 1d B-splinea)
% vektorizirano i bez rekurzije u implementaciji
function y = deBoorCoxRec(x, k, i, t)
  % t redak, x stupac, i skalar

  % pocinjemo od k B-splineova reda 1
  % u k-1 iteracija povecavamo red do k
  n = length(t) - k;
  [q, _] = size(x);
  B = zeros(q, k);
  % baza
  for j=i:(i+k-1)
    B(:, j-(i-1)) = t(j) <= x & (x < t(j+1) | (x == t(j+1) & j == n));
  endfor

  K = k;
  I = i;
  for k=2:K
    for i=I:(I+K-k)
      w_1 = zeros(q, 1);
      w_2 = zeros(q, 1);

      if t(i+k-1) ~= t(i)
        w_1 = (x-t(i)) / (t(i+k-1) - t(i));
      endif

      if t(i+k) ~= t(i+1)
        w_2 = (x-t(i+1)) / (t(i+k) - t(i+1));
      endif

      B(:, i-I+1) = w_1.*B(:, i-I+1) + (1-w_2).*B(:, i-I+2);
    endfor
  endfor

  y = B(:, 1);
endfunction

