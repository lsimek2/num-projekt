load primjer_dmnk.mat;

Delta_1 = (0:10)/10;
Delta_2 = [(0:7)/10 1];

gridsize = 200;

[x, I] = sort(x);
y = y(I);

for k=2:3 % red splajna %
  for idx_cvorovi = 1:3

    % selekcija cvorova %
    if k == 2 && idx_cvorovi == 3
      cvorovi = sort(x');
    elseif k == 3 && idx_cvorovi == 3
      temp = sort(x');
      cvorovi = [temp(1) temp(3:size(temp)(2))];
    elseif idx_cvorovi == 1
      cvorovi = Delta_1;
    elseif idx_cvorovi == 2
      cvorovi = Delta_2;
    endif

    [_, m] = size(cvorovi);

    t = [repelem(cvorovi(1), k) cvorovi(2:m-1), repelem(cvorovi(m), k)];

    alpha = nk_splajn(k, t, x, y);

    grid_x = linspace(min(x), max(x), gridsize);
    grid_y = zeros(1, size(grid_x)(2));
    for idx=1:size(grid_x)(2)
      grid_y(idx) = deBoor(grid_x(idx), k, 0, t, alpha);
    endfor

    % subplot(6, idx_cvorovi, k-1);
    % idx_cvorovi + 3 * (k - 2)
    subplot(2, 3, idx_cvorovi + 3 * (k - 2));
    plot(x, y, 'col', 'blue', 'o');
    hold on
    plot(grid_x, grid_y, 'col', 'red');

    if idx_cvorovi == 1 || idx_cvorovi == 2
      alpha
    endif

  endfor
endfor
