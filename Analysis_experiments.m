clear all
close all

[firstHalf,secondHalf,NumVideos,NumUsers]=...
    PreparingData;

%% For doing MDS

for VidIdx=1:NumVideos

    
% Change the half here 
% First half signifies the first 30 seconds
% Second half signifies the next 30 seconds

tempMat=(firstHalf(:,VidIdx))';

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

[~,score]=pca(DataMat);

tempScore1{:,VidIdx}=score(:,1);
tempScore2{:,VidIdx}=score(:,2);
tempScore3{:,VidIdx}=score(:,3);

clear NewTemp DataMat

end

%making the cells of equal length
NewTempScore1 =...
cellfun(@(tempScore1) tempScore1(1:minLength), tempScore1, 'Uniform', 0);

%making the cells of equal length
NewTempScore2 =...
cellfun(@(tempScore2) tempScore2(1:minLength), tempScore2, 'Uniform', 0);

%making the cells of equal length
NewTempScore3 =...
cellfun(@(tempScore3) tempScore3(1:minLength), tempScore3, 'Uniform', 0);


tempScore1=[];
tempScore2=[];
tempScore3=[];

for num=1:length(NewTempScore1)
    
 tempScore1(:,num)=NewTempScore1{1,num};
 tempScore2(:,num)=NewTempScore2{1,num};
 tempScore3(:,num)=NewTempScore3{1,num};
 
end

% pairwise differences between the vectors 

Count=1;
for k=1:size(tempScore1,2)
    
for j=1:size(tempScore1,2)

diffVect1(:,Count)=...
    tempScore1(:,k) - tempScore1(:,j);

VidIdx=...
{'Vid1','Vid2','Vid3','Vid4','Vid5',...
'Vid6','Vid7','Vid8','Vid9','Vid10',...
'Vid11','Vid12','Vid13','Vid14','Vid15',...
'Vid16','Vid17','Vid18','Vid19','Vid20',...
'Vid21','Vid22','Vid23','Vid24','Vid25',...
'Vid26','Vid27','Vid28','Vid29','Vid30',...
'Vid31','Vid32','Vid33','Vid34','Vid35',...
'Vid36','Vid37','Vid38','Vid39','Vid40',...
};    
    
normMat1(j,k)=...
    norm(diffVect1(:,Count));

diffVect2(:,Count)=...
    tempScore2(:,k) - tempScore2(:,j);
 
normMat2(j,k)=...
    norm(diffVect2(:,Count));

diffVect3(:,Count)=...
    tempScore3(:,k) - tempScore3(:,j);
 
normMat3(j,k)=...
    norm(diffVect3(:,Count));

 Count=Count+1;
 
end

end

[Y1,eigvals] = cmdscale(normMat1);
[Y2,eigvals] = cmdscale(normMat2);
[Y3,eigvals] = cmdscale(normMat3);

figure
tempY=[Y1(:,1);Y1(:,2)];
% Z = linkage(tempY,'centroid');
% T = cluster(Z,'maxclust',3);
% dendrogram(Z);
plot(Y1(:,1),Y1(:,2),'d')
text(Y1(:,1),Y2(:,2),VidIdx)
% hold on
% plot(Y2(:,1),Y2(:,2),'*')
% hold on
% plot(Y3(:,1),Y3(:,2),'.')
% 
% legend('First PC','Second PC','Third PC');



%% cluster analysis part

X=[Y1(:,1),Y1(:,2)];

[idxPrime,C] = kmeans(X,2,'Distance','cityblock',...
    'Replicates',5);

figure;
plot(X(idxPrime==1,1),X(idxPrime==1,2),'r.','MarkerSize',12)
hold on
plot(X(idxPrime==2,1),X(idxPrime==2,2),'b.','MarkerSize',12)


plot(C(:,1),C(:,2),'kx',...
     'MarkerSize',15,'LineWidth',3) 
legend('Cluster 1','Cluster 2','Centroids',...
       'Location','NW')
title 'Cluster Assignments and Centroids'

hold off
figure;
silhouette(X,idxPrime)

% finding the video indices

% for cluster 1
c1_idx=find(idxPrime==1);

% for cluster 2
c2_idx=find(idxPrime==2);
