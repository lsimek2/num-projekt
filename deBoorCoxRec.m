% de Boor-Coxova rekurzija (evaluacija 1d B-splinea)
% vektorizirano i bez rekurzije u implementaciji
function y = DeBoorCoxRec(x, i, n, k, t)
  % pocinjemo od k B-splineova reda 1
  % u k-1 iteracija povecavamo red do k
  [q, _] = size(x);
  B = zeros(q, k);
  % baza
  for j=i:(i+k-1)
    B(j-(i-1)) = t(j) <= x && x < t(j+1);
  endfor


  for iter=1:(k-1)
    for j=1:(k-iter+1)
      w_1 = 0;
      w_2 = 0;

      if t(i+k-1) != t(i)
        w_1 = (x-t(i)) / (t(i+k-1) - t(i));
      endif

      if t(i+k) != t(i+1)
        w_2 = (x-t(i+1)) / (t(i+k) - t(i+1));
      endif

      B(j) = w_1*B(j) + (1-w_2)*B(j+1);

    endfor
  endfor

  y = B(1);
endfunction

