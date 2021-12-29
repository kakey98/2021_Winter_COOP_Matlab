data_ca = coordi('4ake.pdb');

k1 = linkmaker(data_ca,7);
% linkGraph(data_ca,k1);

K = nma(k1,data_ca);