data_ca = coordi('4ake.pdb');

k1 = linkmaker(data_ca,12);
% linkGraph(data_ca,k1);

[K d v] = nma(k1,data_ca);
fprintf("Done\n");

modeshape(data_ca,v,5);
