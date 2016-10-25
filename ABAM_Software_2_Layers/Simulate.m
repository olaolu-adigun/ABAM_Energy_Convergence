P = zeros(100,1);

for a = 1:1:100
   E = ABAM_2_Layers();
   P(a) = issorted(-E);
end
disp(sum(P));