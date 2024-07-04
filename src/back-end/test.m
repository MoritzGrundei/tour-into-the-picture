function recVertex = test(vanish_p,estimatedVertex)
    recVertex=[estimatedVertex;zeros(1,12)];
    L=zeros(12,1);
    for i=[1:12]
       L(i)=pdist([[vanish_p(2),vanish_p(1)]',estimatedVertex(:,i)]','euclidean');
    end
    recVertex(3,5)=1;
    recVertex(3,3)=L(5)/L(3);
    recVertex(3,[1,2,7,8])=L(5)/L(1);
    recVertex(3,4)=L(2)/L(4)*L(5)/L(1);
    recVertex(3,6)=L(2)/L(6)*L(5)/L(1);
    
    recVertex(3,9)=L(7)/L(9)*L(5)/L(1);
    recVertex(3,11)=L(7)/L(11)*L(5)/L(1);
    
    recVertex(3,12)=L(8)/L(12)*L(5)/L(1);
    recVertex(3,10)=L(8)/L(10)*L(5)/L(1);
    
    recVertex([1,2],:)=(recVertex([1,2],:)-[vanish_p(2),vanish_p(1)]').*recVertex(3,:);
end