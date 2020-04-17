function[firstHalf,secondHalf,NumVideos,NumUsers]=...
    PreparingData;

NumVideos=40;
NumUsers=32;

for VidIdx=1:NumVideos
    

for UserIdx=1:NumUsers
    
%String formatting for loading the data   
formatSpec =...
       'C:\\Users\\amukher3\\Downloads\\RR_series_user%d.mat';

Num=UserIdx;
str=sprintf(formatSpec,Num);
load(str);

%%% removing the first 3 seconds of 
%%% baseline period. 

% SamplingFreqn of the PPG signal
SamplingFreqn=128;

removDuration=3; % in seconds
removSegment=removDuration*SamplingFreqn;


tempVid=cell2mat(RR_series(VidIdx));
VidPrime=tempVid(1,removSegment:length(tempVid));

bpFilt = designfilt('bandpassfir','FilterOrder',200, ...
'CutoffFrequency1',0.03,'CutoffFrequency2',0.15,...
'SampleRate',SamplingFreqn);

%Performing filtering as a pre-processing step
% as suggested in the literature...
Vid=filter(bpFilt,VidPrime);


% Dividing the video into 2 segments...
midPoint=round(size(Vid,2)/2);

% For every column(including all rows) one atom will be learnt. 
% Similarly, every column will be represented by one Principal
% Component. 
% Rows ~~~ Users
% Columns ~~~ Videos

%%%%%%%% Initial response %%%%%%%%%%
firstHalf{UserIdx,VidIdx}=...
    Vid(1,1:midPoint);

%%%%%%%%% Second response %%%%%%%%%%%
secondHalf{UserIdx,VidIdx}=...
    Vid(1,midPoint+1:length(Vid));

clear Vid

end


end
end


