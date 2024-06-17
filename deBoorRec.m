% de Boorov algoritam (alfe)
function [y] = deBoorRec(x, k, n, t, a)

  [i] = bintrazenje(x, t);

  for r=1:(k-1)
    for j=i:-1:(i-k+r+1)

      w = 0;
      if t(j) != t(j+k-r)
        w = (x-t(j)) / (t(j+k-r) - t(j));
      endif

      a(j) = (1-w)*a(j-1) + w*a(j);
    endfor
  endfor

  y = a(i);
endfunction

