P = zeros(10000,1);

for a = 1:1:10000
   E = ABAM_2_Layers();
   E = E(4:numel(E));
   P(a) = issorted(-E);
   if P(a) == 0
       plot(E,'k-x');
   end
end
disp(sum(P));