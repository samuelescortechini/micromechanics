function [K_HS_lower, K_HS_upper, mu_HS_lower, mu_HS_upper] = compute_HS_bounds(porosity, E0, nu0)
    % Compute bulk modulus K and shear modulus mu for the matrix
    K0 = E0 / (3 * (1 - 2 * nu0));  % Bulk modulus of matrix
    mu0 = E0 / (2 * (1 + nu0));     % Shear modulus of matrix

    % Properties of voids (small nonzero values for stability)
    K1 = 1e-6;  
    mu1 = 1e-6;  

    % Dimensionalità del problema
    delta = 3;

    % Phases concentration
    c1 = porosity;
    c0 = 1 - porosity;

    % Min e Max tra i moduli di taglio
    G_min = min(mu0, mu1);
    G_max = max(mu0, mu1);

    % Correzione nel calcolo di H_min e H_max
    if mu0 >= mu1  % Caso G1 >= G2
        H_min = (mu1 * (delta * K1 / 2 + (delta + 1) * (delta - 2) * mu1 / delta)) / (K1 + 2 * mu1);
        H_max = (mu0 * (delta * K0 / 2 + (delta + 1) * (delta - 2) * mu0 / delta)) / (K0 + 2 * mu0);
    else  % Caso G2 > G1
        H_min = (mu0 * (delta * K0 / 2 + (delta + 1) * (delta - 2) * mu0 / delta)) / (K0 + 2 * mu0);
        H_max = (mu1 * (delta * K1 / 2 + (delta + 1) * (delta - 2) * mu1 / delta)) / (K1 + 2 * mu1);
    end

    % Calcolo dei nuovi bound di Bulk Modulus
    K_HS_lower = ((c0 / 2) / ((delta - 1) / delta * G_min + K0) + (c1 / 2) / ((delta - 1) / delta * G_min + K1))^(-1) - 2 * (delta - 1) / delta * G_min;
    K_HS_upper = ((c0 / 2) / ((delta - 1) / delta * G_max + K0) + (c1 / 2) / ((delta - 1) / delta * G_max + K1))^(-1) - 2 * (delta - 1) / delta * G_max;

    % Calcolo dei nuovi bound di Shear Modulus
    mu_HS_lower = (c0 / (H_min + mu0) + c1 / (H_min + mu1))^(-1) - H_min;
    mu_HS_upper = (c0 / (H_max + mu0) + c1 / (H_max + mu1))^(-1) - H_max;
end
