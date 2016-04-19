load usps.mat;
tic;
P_val=[10,50,100,200];% no. of principal components

[U,D,V]=svd(A);  % svd decomposition of A%
error = zeros(1,size(P_val,2));

for k = 1:size(P_val,2)
 p =P_val(k);
    
 U1=U(:,1:p);    % selecting first p principal components of A
 D1=D(1:p,1:p);
 V1=V(:,1:p);
 
A_pred=U1*D1*V1'; % forming min frobenius projection of A with p dimensional
                           % eigenspace
err = norm(A-A_pred,'fro'); % measuring error as frobenius norm of difference
error(k) = err;

A_1=reshape(A(1,:),16,16);
A_pred_1=reshape(A_pred(1,:),16,16); 
A_2=reshape(A(2,:),16,16);
A_pred_2=reshape(A_pred(2,:),16,16);

figure 
subplot(2,2,1);
imshow(A_1');                   
title('original image');    

subplot(2,2,2);
imshow(A_pred_1');
title(strcat('reconstructed with p= ',num2str(p)));

subplot(2,2,3);
imshow(A_2');
title('original image');

subplot(2,2,4);
imshow(A_pred_2');
title(strcat('reconstructed with p= ',num2str(p)));
   
end


figure
plot(P_val,log(error),'o--'); 
xlabel(' number of PC');
ylabel('log error');
toc

 
