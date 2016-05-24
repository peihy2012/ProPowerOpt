function obj = powerloss( obj )
%POWERLOSS Summary of this function goes here
%   Detailed explanation goes here
z = obj.busdata(:,3) + j*obj.busdata(:,4);
Un = [obj.baseKV;obj.U];
Sfrom = Un(obj.busdata(:,1)).*conj(Un(obj.busdata(:,1))-Un(obj.busdata(:,2)))./conj(z);%线路首端流经功率
Sto = Un(obj.busdata(:,2)).*conj(Un(obj.busdata(:,1))-Un(obj.busdata(:,2)))./conj(z);%线路末端流经功率
Sloss = Sfrom-Sto;
obj.Sf = Sfrom;
obj.St = Sto;
obj.loss = real(Sloss);
end

