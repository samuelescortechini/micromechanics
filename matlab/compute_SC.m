function [K_SC, G_SC, iter_count] = compute_SC(porosity, E0, nu0, tol, max_iter, K_MT, G_MT)
    % Computes the Self-Consistent effective bulk and shear moduli
    % for a single porosity value using Mori-Tanaka as initial guess.
    %
    % Inputs:
    %   - porosity: Porosity fraction (0 <= porosity < 1)
    %   - E0: Young's modulus of the matrix
    %   - nu0: Poisson's ratio of the matrix
    %   - tol: Convergence tolerance
    %   - max_iter: Maximum number of iterations
    %   - K_MT, G_MT: Initial guesses from Mori-Tanaka
    %
    % Outputs:
    %   - K_SC: Self-Consistent Bulk Modulus
    %   - G_SC: Self-Consistent Shear Modulus
    %   - iter_count: Number of iterations required for convergence

    % Initial properties of the matrix
    K0 = E0 / (3 * (1 - 2 * nu0));  % Bulk modulus of matrix
    G0 = E0 / (2 * (1 + nu0));      % Shear modulus of matrix

    % Properties of voids (very low values to simulate air)
    K1 = 1e-6;  % Small bulk modulus for void phase
    G1 = 1e-6;  % Small shear modulus for void phase

    % Volume fractions
    c1 = porosity;  % Inclusion volume fraction (voids)
    c0 = 1 - c1;    % Matrix volume fraction

    % Initial guess: Use Mori-Tanaka results
    K_SC = K_MT;
    G_SC = G_MT;

    iter_count = 0;  % Counter for iterations

    % Iteration loop
    for iter = 1:max_iter
        iter_count = iter;  % Update iteration counter

        % Compute Poisson's ratio of the effective matrix
        nu_SC = (3 * K_SC - 2 * G_SC) / (2 * (3 * K_SC + G_SC));

        % Compute Eshelby tensor components
        gamma_SC = (1 + nu_SC) / (9 * (1 - nu_SC));
        delta_SC = (4 - 5 * nu_SC) / (15 * (1 - nu_SC));

        % Compute new bulk and shear moduli (SCM update)
        K_new = K0 + (c1 * K_SC * (K1 - K0)) / (K_SC + 3 * gamma_SC * (K1 - K_SC));
        G_new = G0 + (c1 * G_SC * (G1 - G0)) / (G_SC + 2 * delta_SC  * (G1 - G_SC));

        % Check convergence
        if abs(K_new - K_SC) < tol && abs(G_new - G_SC) < tol
            break;  % Exit the loop
        end

        % Update values for next iteration
        K_SC = K_new;
        G_SC = G_new;
    end
    
end

