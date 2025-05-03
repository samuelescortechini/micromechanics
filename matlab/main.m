clear all; close all;

%% Parameters
porosity = linspace(0.25, 0.45, 50);  
moduli = linspace(1e9, 50e9, 50);  
nu0 = 0.3;   
tol = 1;  
max_iter = 1000;  

% Meso-scale parameters
E_meso = 100 * 1e9;  
nu_meso = 0.30;       
K_meso = ones(length(moduli), length(porosity)) * E_meso / (3 * (1 - 2 * nu_meso)); 
G_meso = ones(length(moduli), length(porosity)) * E_meso / (2 * (1 + nu_meso));  

% Preallocate matrices
K_lower = zeros(length(moduli), length(porosity));
K_upper = zeros(length(moduli), length(porosity));
mu_lower = zeros(length(moduli), length(porosity));
mu_upper = zeros(length(moduli), length(porosity));
K_MT = zeros(length(moduli), length(porosity));
G_MT = zeros(length(moduli), length(porosity));
K_SC = zeros(length(moduli), length(porosity));
G_SC = zeros(length(moduli), length(porosity));
iter_counts = zeros(length(moduli), length(porosity));

%% Computations
for i = 1:length(moduli)
    for j = 1:length(porosity)
        E0 = moduli(i);
        poro = porosity(j);
        
        % Hashin-Shtrikman bounds
        [K_lower(i, j), K_upper(i, j), mu_lower(i, j), mu_upper(i, j)] = compute_HS_bounds(poro, E0, nu0);
        
        % Mori-Tanaka Model
        [K_MT(i, j), G_MT(i, j)] = compute_MT(poro, E0, nu0);
        
        % Self-Consistent Model
        [K_SC(i, j), G_SC(i, j), iter_counts(i, j)] = compute_SC_relaxed(poro, E0, nu0, tol, max_iter, K_MT(i, j), G_MT(i, j));
    end
end

%% Meshgrid for plotting
[P, M] = meshgrid(porosity, moduli);

% ====== Plot 2: Bulk and Shear Modulus ======
figure('Units', 'normalized', 'OuterPosition', [0 0 1 1]); 

% ====== Subplot 1: Bulk Modulus ======
subplot(1,2,1); 
hold on; grid on;
xlabel('Porosity', 'FontSize', 12, 'FontWeight', 'bold');
ylabel('Young''s Modulus (GPa)', 'FontSize', 12, 'FontWeight', 'bold', 'Position', [0.5, 30, -1]);
zlabel('Bulk Modulus (GPa)', 'FontSize', 12, 'FontWeight', 'bold');
title('Bulk Modulus with Bounds and Models', 'FontSize', 14, 'FontWeight', 'bold');

% Add surfaces
surf(P, M/1e9, K_lower/1e9, 'FaceAlpha', 0.5, 'FaceColor', 'b', 'EdgeColor', 'none'); % Lower Bound (blue)
surf(P, M/1e9, K_upper/1e9, 'FaceAlpha', 0.5, 'FaceColor', 'r', 'EdgeColor', 'none'); % Upper Bound (red)
surf(P, M/1e9, K_MT/1e9, 'FaceAlpha', 0.5, 'FaceColor', 'g', 'EdgeColor', 'none');    % Mori-Tanaka (green)
surf(P, M/1e9, K_SC/1e9, 'FaceAlpha', 0.5, 'FaceColor', 'm', 'EdgeColor', 'none');    % Self-Consistent (magenta)
surf(P, M/1e9, K_meso/1e9, 'FaceAlpha', 0.5, 'FaceColor', 'k', 'EdgeColor', 'none');  % Bulk Experimental (black)

% ====== New Vertical Plane at Porosity = 0.305 ======
[Y_exp, M_exp] = meshgrid(linspace(min(moduli)/1e9, max(moduli)/1e9, 50), linspace(min(K_lower(:))/1e9, max(K_upper(:))/1e9, 50));
P_exp = 0.305 * ones(size(Y_exp)); 
surf(P_exp, Y_exp, M_exp, 'FaceColor', 'k', 'FaceAlpha', 0.3, 'EdgeColor', 'none'); % Experimental Porosity (Black)

legend('Lower Bound', 'Upper Bound', 'Mori-Tanaka', 'Self-Consistent', 'Bulk Experimental', 'Experimental Porosity');
view(135, 10);
hold off;

% ====== Subplot 2: Shear Modulus ======
subplot(1,2,2); 
hold on; grid on;
xlabel('Porosity', 'FontSize', 12, 'FontWeight', 'bold');
ylabel('Young''s Modulus (GPa)', 'FontSize', 12, 'FontWeight', 'bold', 'Position', [0.5, 30, -1]);
zlabel('Shear Modulus (GPa)', 'FontSize', 12, 'FontWeight', 'bold');
title('Shear Modulus with Bounds and Models', 'FontSize', 14, 'FontWeight', 'bold');

% Add surfaces
surf(P, M/1e9, mu_lower/1e9, 'FaceAlpha', 0.5, 'FaceColor', 'b', 'EdgeColor', 'none'); % Lower Bound (blue)
surf(P, M/1e9, mu_upper/1e9, 'FaceAlpha', 0.5, 'FaceColor', 'r', 'EdgeColor', 'none'); % Upper Bound (red)
surf(P, M/1e9, G_MT/1e9, 'FaceAlpha', 0.5, 'FaceColor', 'g', 'EdgeColor', 'none');    % Mori-Tanaka (green)
surf(P, M/1e9, G_SC/1e9, 'FaceAlpha', 0.5, 'FaceColor', 'm', 'EdgeColor', 'none');    % Self-Consistent (magenta)
surf(P, M/1e9, G_meso/1e9, 'FaceAlpha', 0.5, 'FaceColor', 'k', 'EdgeColor', 'none');  % Bulk Experimental (black)

% Experimental Porosity (Vertical Plane at Porosity = 0.305)
surf(P_exp, Y_exp, M_exp, 'FaceColor', 'k', 'FaceAlpha', 0.3, 'EdgeColor', 'none');

legend('Lower Bound', 'Upper Bound', 'Mori-Tanaka', 'Self-Consistent', 'Bulk Experimental', 'Experimental Porosity');
zlim([0 15]); 
view(135,10);

% Export the figures as transparent PNGs
exportgraphics(gcf, 'bulk_shear_modulus.png', 'BackgroundColor', 'none', 'Resolution', 300);

hold off;


