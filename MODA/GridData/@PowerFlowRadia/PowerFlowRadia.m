classdef PowerFlowRadia < handle
    %UNTITLED8 Summary of this class goes here
    %   Detailed explanation goes here
    
properties
    baseMVA = 10;
    baseKV = 12.66;
    tol     = 1e-8;  %mpopt.pf.tol;
    max_it  = 10;    %mpopt.pf.nr.max_it;
    busdata
    Ybus
    Sbus
    YU
    YL
    YP
    U
    Vm
    Va
    Sf
    St
    loss
    V0
    nb
end % properties

methods
    function obj = PowerFlowRadia(data)
        obj.baseMVA = data.baseMVA;
        obj.busdata = data.busdata;
        obj.nb = size(data.busdata, 1);          %% number of buses
        obj.V0 = data.baseKV*ones(obj.nb,1);
    end

     makeYbus(obj);
     makeSbus(obj);
     initPowerflow(obj);
     powerflow(obj);
     powerloss(obj);
end % methods

% methods (Access = private)
%     [ dSbus_dVm, dSbus_dVa ] = dSbus_dV( obj, V );
% %     function [dSbus_dVm, dSbus_dVa] = dSbus_dV(obj, Ybus, V)
% %         n = length(V);
% %         Ibus = Ybus * V;
% %         if issparse(Ybus)           %% sparse version (if Ybus is sparse)
% %             diagV       = sparse(1:n, 1:n, V, n, n);
% %             diagIbus    = sparse(1:n, 1:n, Ibus, n, n);
% %             diagVnorm   = sparse(1:n, 1:n, V./abs(V), n, n);
% %         else                        %% dense version
% %             diagV       = diag(V);
% %             diagIbus    = diag(Ibus);
% %             diagVnorm   = diag(V./abs(V));
% %         end
% %         dSbus_dVm = diagV * conj(Ybus * diagVnorm) + conj(diagIbus) * diagVnorm;
% %         dSbus_dVa = 1j * diagV * conj(diagIbus - Ybus * diagV);
% %     end
% end

% methods
%     function plot(obj, varargin )
%         plot([1:obj.nb]',obj.Vm,'--rs','LineWidth',2,...
%              'MarkerEdgeColor','k',...
%              'MarkerFaceColor','g',...
%              'MarkerSize',4);grid;
%     end
% end

end % classdef

