function obj = CreateEmptyParticle( obj, n )
    if nargin<2
        n=1;
    end

    obj.empty_particle.Position=[];
    obj.empty_particle.Velocity=[];
    obj.empty_particle.Cost=[];
    obj.empty_particle.Dominated=false;
    obj.empty_particle.Best.Position=[];
    obj.empty_particle.Best.Cost=[];
    obj.empty_particle.GridIndex=[];
    obj.empty_particle.GridSubIndex=[];
    
%     particle=repmat(empty_particle,n,1);
    
end