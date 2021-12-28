M = coordi('4ake.pdb');
[K distance] = link(M,6);


figure()
hold on
plot3(M(:,1),M(:,2),M(:,3),"b.:")
hold off

title("Alpha Carbon Sequence")


