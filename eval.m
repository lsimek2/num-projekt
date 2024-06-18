function z = eval(
    C, % koeficijenti
    tau, eta, % mreza na kojoj izvrednjavamo
    t, u, % prosirene particije
    k, l  % redovi 1d Bsplineova
  )

  m = length(t) - k;
  n = length(u) - l;

  [_, gsx] = size(tau);
  [_, gsy] = size(eta);

  z = zeros(gsx, gsy);
  vy = zeros(1, l);
  vx = zeros(1, k);
  for j=1:gsy  % y-koordinata u mrezi
    y = eta(j);
    ni = bintrazenje(y, u);

    for iterj=(ni-l+1):ni
        idx = iterj - (ni-l);
        vy(idx) = deBoorCoxRec(y, l, iterj, u);
    endfor

    for i=1:gsx  % x-koordinata u mrezi
      x = tau(i);
      mi = bintrazenje(x, t);

      for iteri=(mi-k+1):mi
        idx = iteri - (mi-k);
        vx(idx) = deBoorCoxRec(x, k, iteri, t);
      endfor

      z(i, j) = vx * C((mi-k+1):mi, (ni-l+1):ni) * vy';
    endfor
  endfor


  % ovaj nacin je jednostavniji ali sporiji
  % jer matrice Bx i By imaju puno nula
  % sto ih cini neucinkovitima memorijski
  % i mnozenje na kraju ima vecu slozenost nego treba
##  % matrice za 1d splajnove
##  % Bx(i, j) je B_ik(x_j)
##  Bx = zeros(gsx, m);
##  for i=1:m
##    Bx(:, i) = deBoorCoxRec(tau', k, i, t);
##  endfor
##
##  By = zeros(gsy, n);
##  for j=1:n
##    By(:, j) = deBoorCoxRec(eta', l, j, u);
##  endfor
##
##  z = Bx * C * By';

endfunction
