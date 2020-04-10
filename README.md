Any queries/questions/concerns can be sent to: amukher3@rockets.utoledo.edu, abhi0787@gmail.com

# Heart-Period-Models
An effort to extract the different response functions for changes in heart period under the effect of suddden continous stimuli rated diversely in the Valence-Arousal scale.  

# Description of the preliminary ideas: 
Extracting response function for changes in heart period under different kinds of discrete/distinct stimuli(having distinct epochs of stimulus and response) has been previously characterized by Bach et. al. The model used to estimate the response function was basically a linear model initially reduced by dimensionality reduction techniques such as PCA. The extracted reponse function were validated with the physiological response(changes in heart period) of the subjects involved in the study. 
One of the apparent drawbacks of such an approach, apart from the potential limitation of having distinct epochs of stimulus-response cycles seemed to be the "baseline" treatment of the arythmic component. Under various settings of the Valence-Arousal scale the parasympathetic system,at times minimal, has been shown to have a modulating effect on changes in heart period.

We make an effort to characterize the response function and the arythmic component under a continous stream of stimuli,in an uncontrolled setting, where the subjects involved in the study are watching audio-visual clips rated diversely in the Valence-Arousal axis. 

# Estimation of the Arythmic component: 
Link to the repo: https://github.com/amukher3/Respiratory-Sinus-Arythmia-estimation
The above repo. has the detailed scripts of the methodology adopted and the different evaluation metrics taken into account. 

Link to the used data-set: https://www.eecs.qmul.ac.uk/mmv/datasets/deap/

We started off with the goal to estimate the arythmic component from the raw BVP/PPG time series datat-sets.The first step was to extract a clean Interbeat interval(IBI)/R-R/Heart Rate(HR) time series from the data-set. It was proceeded by a MA removal algorithm previously adopted described literature. 

Previous research seemed to have taken a "baseline" approach while estimating the arythmic component from HR time series. The most general approach found was to directly filter the frequency component and thereby remove it from the time series. 

We decided to take a systemic approach of removing the RSA(Respiratory Sinus Arythmia) from the HR time series. RSA component being heavily affected by our repiration pattern tends to have a increasing effect(increase in tidal volume) during our inspiration and a slow reduction during our expiration. This nature of change enabled us to form a knowledge-based dictionary which could capture the latent structure in the time series and thereby estimating the component. 

The process has been detailed in the technical report described in the RSA repo.
Link to the repo: https://github.com/amukher3/Respiratory-Sinus-Arythmia-estimation 

# Heart Period Modelling: 

After the described the RSA estimation and removal technique our goal was to get reposne function that could explain the changes in the heart period over a period of time for different kinds of continous stimuli. 

There were two different methods that I had started with: 1) Dictionary-learning technique. 
                                                          2) misAligned PCA. 


     #1) Dictionary learning technique: 
     
     Used dictionary learning algorithm(K-SVD based) to learn the reposne function. The IBI time series was broken into epochs of 5 seconds to form the matrix to be learnt using K-SVD. I decided to choose 5 second as the window size because the time series being elicited from a continous stream of situmuli would be marred by suddent stimuli thereby the effect of the previous stimuli can be safely assumed to be less than 5 seconds. Another reason to choose a smaller window size was to induce sparsity in the learnt atoms. Having sparse atoms introduces advantages such as easier frequency domain analysis , easily represented de-convolution results etc.  
     Some of the atoms learnt throught the dictionary learning technique seemed to have a strong correlation with the physiogically extracted response functions shown by Bach et. al. 
     One of the caveats in this approach was the large number of atoms that were being learnt for the every subject and for every clip which were very diversely rated in the Valence-Arousal(V-A) scale. 
     To circumvent this I decided to find the embedding of the learnt reponse functions. The idea being that the 2D embeddings of the learnt response functions should have some semblance to the ratings(average/median) of the videos by the participants in the 2D plane of Valence-Arousal. 
     The clips rated extremely in the spectrum did seem to follow the conjecture i.e the 2D embeddings of the learnt response functions and the average ratings of the clips by the participants did seem to be in clusters, but the ratings being very diverse(probable reason being the bias across the participants) some of them could not be agglomerated into clusters surrounding the rating in the V-A scale. 
     I further decided to do some cluster analysis to make sense of the clustering under various measures of central tendency but the some of the result still remains inexplicable. At this point the problem seemed to have turned into a classic unsupervised clustering problem with some in-explicable clusters.Further analysis of the embeddings with different linkage functions or some kind of linkage research might hold the key. 
     A proportion of variance test on the learnt response was also done for the differnt IBI time series(across users and videos) the test seemed to explain a high percentage of variance in the time series for most of the clips. 
     The biggest caveat which still remains with the large number of learnt response functions is the virtually non-existent literature in the psycho-phys communinty when it comes to interpretation of these response functions. After a detailed literature survey I found that the community seemed to have only come up with interpretation of some of the often seen elicited rsponses which are generally derived under the extreme ends of the V-A spectrum i.e response functions(RFs) under the higher ends of the 2D plane of V-A. 
     
     At some point the community needs to realize that one aspect of AI is through generative modeling of our deep seated responses,  mitigated and modulated by our nervous system's electrical responses. The different RFs elicited which are placed in the different regions of the V-A scale gives us insight into how our sympathetic nervous sytem has reacted to the stimuli. The shape of the RF(accelaration/decclaration), a reflection of the modulation of the heart period, might then lead to some insights into why we react differently to certain stimulus/conditions. This generative distribution might lead to a better understanding of why certain age groups, gender react differently to different siutations which might refine our understanding of how evolution has affected us differently.
     
     2) misPCA:
