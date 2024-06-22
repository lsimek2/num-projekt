function z = eval(
    C, % koeficijenti
    tau, eta, % mreza na kojoj izvrednjavamo
    t, u, % prosirene particije
    k, l  % redovi 1d Bsplineova
  )

  [_, gsx] = size(tau);
  [_, gsy] = size(eta);

  % postupamo slicno kao u literaturi, str. 396
  z = zeros(gsx, gsy);
  vy = zeros(1, l);

  vx = zeros(gsx, k);
  vmi = zeros(gsx);
  % da ne ponavljamo evaluacije deBoorCoxRec funkcije
  % popunimo vektor(e) vx sada
  for i=1:gsx
    x = tau(i);
    mi = bintrazenje(x, t);

    for iteri=(mi-k+1):mi
      vx(i, iteri-mi+k) = deBoorCoxRec(x, k, iteri, t);
    endfor
    vmi(i) = mi;
  endfor

  for j=1:gsy  % y-koordinata u mrezi
    y = eta(j);
    ni = bintrazenje(y, u);

    for iterj=(ni-l+1):ni
        vy(iterj-ni+l) = deBoorCoxRec(y, l, iterj, u);
    endfor

    for i=1:gsx  % x-koordinata u mrezi
      mi = vmi(i);
      z(i, j) = vx(i, :) * C((mi-k+1):mi, (ni-l+1):ni) * vy';
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

