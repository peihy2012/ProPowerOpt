function powerflow( obj )
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
%NEWTONPF  Solves the power flow using a full Newton's method.
%   NEWTONPF(OBJ)
%   solves for bus voltages given the full system admittance matrix (for
%   all buses), the complex bus power injection vector (for all buses),
%   the initial vector of complex bus voltages, and column vectors with
%   the lists of bus indices for the swing bus, PV buses, and PQ buses,
%   respectively. The bus voltage vector contains the set point for
%   generator (including ref bus) buses, and the reference angle of the
%   swing bus, as well as an initial guess for remaining magnitudes and
%   angles. MPOPT is a MATPOWER options struct which can be used to 
%   set the termination tolerance, maximum number of iterations, and 
%   output options (see MPOPTION for details). Uses default options if
%   this parameter is not given. Returns the final complex voltages, a
%   flag which indicates whether it converged or not, and the number of
%   iterations performed.

%% initialize
iterations = 1;
converged = 0;
U = obj.V0;
Err = obj.tol;
while ~converged
    temp_u = U;
%     temp = Y\(conj(Sn./U));
    temp=obj.YP * (conj(obj.Sbus./U));
    temp=obj.YL \ temp;
    temp=obj.YU \ temp;
    U = obj.V0 - temp;
    if max(abs(temp_u-U)) < Err  %err
        converged = 1;
        break;
    end
    iterations = iterations + 1;
    if iterations > 50
        converged = 0;
        break;         %Not convergence flag
    end
end

if ~converged
    fprintf('\nThe power flow did not converge in %d iterations.\n', i);
else
    obj.U = U;
    obj.Vm = abs(U);            %% update Vm and Va again in case
    obj.Va = angle(U);          %% we wrapped around with a negative Vm    
end

end

