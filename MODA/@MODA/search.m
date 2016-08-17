function obj = search( obj )
%SEARCH Summary of this function goes here
%   Detailed explanation goes here
for iter = 1:obj.maxGen

    parfor it=1:obj.N 
        % mo.Particles_F(it,:) = ObjectiveFunction(mo.X(:,it)', pf, Snew);
        P_F(it,:) = obj.objFunc(obj.X(:,it))';
    end
    StoreF(:,:,iter) = P_F;
    obj.Particles_F = P_F(:,[1:3]);
    obj.getfront();
    obj.operation(iter);
end

end

