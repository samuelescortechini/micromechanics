function [K_MT, G_MT] = compute_MT(porosity, E0, nu0)
    % Computes the Mori-Tanaka effective bulk and shear moduli
    % using Eshelby’s tensor components.
    %
    % Inputs:
    %   - porosity: Volume fraction of voids (0 <= porosity < 1)
    %   - E0: Young's modulus of the matrix
    %   - nu0: Poisson's ratio of the matrix
    %
    % Outputs:
    %   - K_MT: Mori-Tanaka effective bulk modulus
    %   - G_MT: Mori-Tanaka effective shear modulus

    % Compute bulk modulus K and shear modulus G for the matrix
    K0 = E0 / (3 * (1 - 2 * nu0));  % Bulk modulus of matrix
    G0 = E0 / (2 * (1 + nu0));      % Shear modulus of matrix

    % Properties of voids (Set small nonzero values to avoid singularities)
    K1 = 1e-6;  % Small bulk modulus for void phase (voids)
    G1 = 1e-6;  % Small shear modulus for void phase (voids)

    % Volume fractions
    c1 = porosity;  % Inclusion concentration (porosity)
    c0 = 1 - c1;    % Matrix fraction

    % Compute Eshelby tensor components (updated for stability)
    gamma0 = (1 + nu0) / (9 * (1 - nu0));
    delta0 = (4 - 5 * nu0) / (15 * (1 - nu0));

    % Mori-Tanaka bulk modulus
    K_MT = K0 + (c1 * K0 * (K1 - K0)) / (K0 + 3 * gamma0 * c0 * (K1 - K0));

    % Mori-Tanaka shear modulus
    G_MT = G0 + (c1 * G0 * (G1 - G0)) / (G0 + 2 * delta0 * c0 * (G1 - G0));
end
