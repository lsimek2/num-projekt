% interpolacija plohe
function C = interp(
    f,
    t, u, % retci, prosirene particije
    k, l, % skalari, redovi B-splineova
    tau=Inf, eta=Inf % retci, interpolacijski cvorovi
  )

  m = length(t) - k;
  n = length(u) - l;

  if tau == Inf % ako tau nije dan, koristimo preporuceno
    % (k-1) * (tau(i+1) - tau(i)) == t(i+k) - t(i+1)
    tau = zeros(1, m);
    tau(1) = sum(t(2:k));
    for i=2:m
      tau(i) = tau(i-1) + t(i+k-1) - t(i);
    endfor
    tau /= k-1;
  endif

  if eta == Inf % ako eta nije dana...
    eta = zeros(1, n);
    eta(1) = sum(u(2:l));
    for j=2:n
      eta(j) = eta(j-1) + u(j+l-1) - u(j);
    endfor
    eta /= l-1;
  endif

  [Tau, Eta] = meshgrid(tau, eta);
  H = f(Tau, Eta)';

  % kao u literaturi (14.2., str. 416) definiramo F i G
  % i poslije rjesavamo sustave
  F = zeros(m);
  for i=1:m
    % pod pretpostavkom t_i < tau_i < t_{i+k} (u, eta u drugom slucaju)
    lower = max(i-k+1, 1);
    upper = min(i+k-1, m);
    F(lower:upper, i) = deBoorCoxRec(tau(lower:upper)', k, i, t);
  endfor

  G = zeros(n);
  for j=1:n
    lower = max(j-l+1, 1);
    upper = min(j+l-1, n);
    G(lower:upper, j) = deBoorCoxRec(eta(lower:upper)', l, j, u);
  endfor

  R = H * (G' \ eye(size(G)));
  C = F \ R;
endfunction

