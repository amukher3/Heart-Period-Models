%% creating the mis-aligned covariance matrix;

% n~~ num. of vectors
% tau ~~ amount of shift
% x ~~ input vector
% i ~~ following the paper notation
% i=1,2,......n
% p ~~ length of the sequence

%for VidIdx=1:NumVideos
% Change the half here 
% First half signifies the first 30 seconds
% Second half signifies the next 30 seconds

clear all

VidIdx=2;
[firstHalf,secondHalf,NumVideos,NumUsers]=...
    PreparingData;

tempMat=(secondHalf(:,VidIdx))';

% finding the minm. length between the arrays
for l=1:length(tempMat)
    len(l)=length(tempMat{1,l});
end 
minLength=min(len);

%making the cells of equal length
NewTemp =...
cellfun(@(tempMat) tempMat(1:minLength), tempMat, 'Uniform', 0);

for num=1:length(NewTemp)
 
 DataMat(:,num)=NewTemp{1,num};
 
end

n=size(DataMat,2);
p=size(DataMat,1);
x=randn(p,n);
dmax=400;S=zeros(p,p);
iterPrime=10;

for i=1:iterPrime
    
  tau(i)=unidrnd(dmax);
  
for k=1:p
    
    for l=1:p
        
        modVal=mod(tau(i)+l,p);
        
        if(k==modVal)
            C(k,l)=1;
        else
            C(k,l)=0;
        end
        
    end
    
end

Sprime{i}=C'*x(:,i)*x(:,i)'*C;

tempS=cell2mat(Sprime(i));
S=(S+tempS)/n;



end

Sigma=Sprime';

Spacing=10;
[Options]=FMisPCA_options([],p,n,1);
Options.dmax=p-1;
Options.Nrndm=4;
Options.GridSize=Spacing; 

% % Seq PCA
F_SMisPCA=SeqFMisPCA(Sigma,Options);

%clear NewTemp DataMat

%end


Masks=cell(iterPrime,1);
for i=1:iterPrime
   Masks{i}=ones(p,n);
end    
F_AMisPCA=FMisPCA(Sigma,Masks,Options);