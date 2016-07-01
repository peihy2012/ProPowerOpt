function initPowerflow( obj )
%BUSTYPES   Builds index lists for each type of bus (REF, PV, PQ).
%   BUSTYPES(OBJ)
%   Generators with "out-of-service" status are treated as PQ buses with
%   zero generation (regardless of Pg/Qg values in gen). Expects BUS and
%   GEN have been converted to use internal consecutive bus numbering.
%   MATPOWER
%   $Id: bustypes.m 2644 2015-03-11 19:34:22Z ray $
%% constants

[obj.YL, obj.YU, obj.YP] = lu(obj.Ybus);

end

