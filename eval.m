function z = eval(
    C, % koeficijenti
    tau, eta, % mreza na kojoj izvrednjavamo
    t, u, % prosirene particije
    k, l  % redovi 1d Bsplineova
  )
  % literatura str. 396-398

  m = length(t) - k;
  n = length(u) - l;

  [_, gsx] = size(tau);
  [_, gsy] = size(eta);

  % matrice za 1d splajnove
  % Bx(i, j) je B_ik(x_j)
  Bx = zeros(gsx, m);
  for i=1:m
    Bx(:, i) = deBoorCoxRec(tau', k, i, t);
  endfor

  By = zeros(gsy, n);
  for j=1:n
    By(:, j) = deBoorCoxRec(eta', l, j, u);
  endfor

  z = Bx * C * By';

endfunction
