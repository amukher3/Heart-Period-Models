% clear all
% close all
% load('C:\DEAP\metadata\participant_ratings.csv');

%%% Extracting the ratings 
%%% defining class labels

function [ArousalMat,ValenceMat,...
    ArousalRatings,ValenceRatings,...
    DominenceRatings,LikingRatings]=...
ExtractingRatings(ParticipantRatings);

%Format of the data
%Participant_ID,Trial,Experiment_id,Start_time,Valence,Arousal
%Dominance,Liking,Familiarity

NumVideos=40; %Number of Videos
ArousalIdx=6; %Column Index of Arousal
Arousal=ParticipantRatings(:,ArousalIdx);
ArousalMat=buffer(Arousal,NumVideos); % Labeled ArousalMatrix

ValenceIdx=5; %Column index of Valence
Valence=ParticipantRatings(:,ValenceIdx);
ValenceMat=buffer(Valence,NumVideos); % Labeled Valence Matrix

DominenceIdx=7;
Dominence=ParticipantRatings(:,DominenceIdx);
DominenceMat=buffer(Dominence,NumVideos);

LikingIdx=8;
Liking=ParticipantRatings(:,LikingIdx);
LikingMat=buffer(Liking,NumVideos);


% Threshold above which its High Valence/Arousal
Threshold=7;

% Thresholding the ratings to get the classes
% Logical values 1 signifies High on Arousal and Valence
ArousalRatings=mean(ArousalMat,2);
ValenceRatings=mean(ValenceMat,2);
DominenceRatings=mean(DominenceMat,2);
LikingRatings=mean(LikingMat,2);

ArousalMat=ArousalMat>=Threshold; 
ValenceMat=ValenceMat>=Threshold; 



end