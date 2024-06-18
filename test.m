% isprobavanje algorima za interpoliranje plohe
% tenzorskim produktom B-splajnova

f = @(x, y) 10 * cos(x + y.^2);

% na [-4, 3] X [-3, 2]
t = [-4, -4, -4, -4, -3, -2, -1, 0, 1, 2, 3, 3, 3, 3];
u = [-3, -3, -3, -2, -1, 0, 1, 2, 2, 2];

ax = -4;
bx = 3;
ay = -3;
by = 2;

k = 4;
l = 3;

C = interp(f, t, u, k, l);

gsx = 25;
gsy = 20;
gx = linspace(ax, bx, gsx);
gy = linspace(ay, by, gsy);
[GX, GY] = meshgrid(gx, gy);

z = eval(C, gx, gy, t, u, k, l);
z = z';

% finija mreza za "pravu" plohu
ggx = linspace(ax, bx, 100);
ggy = linspace(ay, by, 100);
[GGX, GGY] = meshgrid(ggx, ggy);


ploha = f(GGX, GGY);
color_bits = 128;
cmap_1 = gray(color_bits);
rgb_1 = data2rgb(ploha, color_bits, cmap_1);

surf(ggx, ggy, ploha, rgb_1);
shading interp;
hold on;


cmap_2 = viridis(color_bits);
% bojamo ovisno o razlici do tocne vrijednosti
rgb_2 = data2rgb(abs(f(GX, GY) - z), color_bits, cmap_2);

surf(gx, gy, z, rgb_2);

