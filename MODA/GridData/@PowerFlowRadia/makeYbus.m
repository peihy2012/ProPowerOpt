function makeYbus( obj )
%MAKEYBUS   Builds the bus admittance matrix and branch admittance matrices.
%   MAKEYBUS(MPC)
%   Returns the full bus admittance matrix (i.e. for all buses) and the
%   matrices YF and YT which, when multiplied by a complex voltage vector,
%   yield the vector currents injected into each line from the "from" and
%   "to" buses respectively of each line. Does appropriate conversions to p.u.
%   Inputs can be a MATPOWER case struct or individual BASEMVA, BUS and
%   BRANCH values. Bus numbers must be consecutive beginning at 1 (internal
%   ordering).

Zbus = obj.busdata(:,3) + obj.busdata(:,4)*i;
A = sparse([obj.busdata(:,1);obj.busdata(:,2)],[(1:obj.nb)';(1:obj.nb)'],[ones(obj.nb,1),-ones(obj.nb,1)]);
A(1,:) = [];%remove the row of substation
Ybus = 1./Zbus;
Ybus = sparse((1:obj.nb)',(1:obj.nb)',Ybus);
obj.Ybus = A*Ybus*A';

end

