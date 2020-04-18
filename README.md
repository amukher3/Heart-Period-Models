# Any queries/questions/concerns can be addressed to: amukher3@rockets.utoledo.edu, abhi0787@gmail.com

# Heart-Period-Models
An effort to extract the different response functions for changes in heart period under the effect of suddden continous stimuli rated diversely in the Valence-Arousal scale.  

### Description of the previous ideas: 

Extracting response function for changes in heart period under different kinds of discrete/distinct stimuli(having distinct epochs of stimulus and response) has been previously characterized by Bach et. al. The model used to estimate the response function was basically a linear model initially reduced by dimensionality reduction techniques such as PCA. The extracted reponse function were validated with the physiological response(changes in heart period) of the subjects involved in the study. 
One of the apparent drawbacks of such an approach, apart from the potential limitation of having _`distinct epochs of stimulus-response cycles`_ seemed to be the "baseline" treatment of the _`arythmic component`_. Under various settings of the _`Valence-Arousal`_ scale the _`parasympathetic system`_,although seemingly minimal, has been shown to have a modulating effect on changes in heart period.

We make an effort to characterize the _`response function`_ and the _`arythmic component`_ under a continous stream of stimuli,in an uncontrolled setting, where the subjects involved in the study are watching audio-visual clips which are later rated diversely by the participants in the Valence-Arousal axis. 

### Estimation of the Arythmic component: 

Link to the repo: https://github.com/amukher3/Respiratory-Sinus-Arythmia-estimation
The above repo. has the detailed scripts of the methodology adopted and the different evaluation metrics taken into account. 
Link to the used data-set: https://www.eecs.qmul.ac.uk/mmv/datasets/deap/

### Heart Period Modelling: 
After the described the _`RSA estimation`_ and artifact removal technique our goal was to get reposne function that could explain the changes in the heart period over a period of time for different kinds of continous stimuli. 

There were two different methods that I had started with: 1) Dictionary-learning technique. 
                                                          2) misAligned PCA.  
                                                          
***Dictionary learning technique:*** 
 Used dictionary learning algorithm(K-SVD based) to learn the reposne function. The _`IBI time series`_ was broken into epochs of 5 seconds to form the matrix to be learnt using K-SVD. I decided to choose `5 second` as the window size because the time series being elicited from a continous stream of situmuli would be marred by sudden stimuli thereby the effect of the previous stimuli can be safely assumed to be less than 5 seconds. Another reason to choose a smaller window size was to induce sparsity in the learnt atoms. Having sparse atoms introduces advantages such as easier frequency domain analysis , easily represented de-convolution results etc.  
     One of the fundamental assumptions that I have made is that the _nature of the stimuli is invariant across the different users_, which potentially means that the effect of a partiular clip(or a particular segment) has a similar effect on all the participants. Going forward this might not be a completely prudent assumption but is generally considered a standard practice in the community. It is generally assumed that the response of subjects to standard stimuli functions(especially on the extreme end of the V-A spectrum) lead to very similar responses and strikingly the result seems to support this conjecture as well -- the embeddings(described later) in the 2D plane which seemed to be closer to the ratings(average/median/some central measure) were generally rated extremely in the spectrum. 
     The other way, i.e learning across all the videos for a particular user seemed unreasonable since the different stimuli function presented would manifest in markedly differnt response functions therefore the learnt atoms would not be interpretable. 
     
***Some of the learnt RFs:***

For video_1: 
![](Video1_Atoms.jpg)

Some of the atoms learnt throught the dictionary learning technique seemed to have a strong correlation with the physiogically extracted response functions shown by Bach et. al. 
     One of the caveats in this approach was the large number of atoms that were being learnt for the every subject and for every clip which were very diversely rated in the Valence-Arousal(V-A) scale. 
     To circumvent this I decided to find the embedding of the learnt reponse functions. The idea being that the _`2D embeddings`_ of the learnt response functions should have some semblance to the ratings(average/median) of the videos by the participants in the 2D plane of Valence-Arousal. 
     The clips rated extremely in the spectrum did seem to follow the conjecture i.e the 2D embeddings of the learnt response functions and the average ratings of the clips by the participants did seem to be in clusters, but the ratings being very diverse(probable reason being the bias across the participants) some of them could not be agglomerated into clusters surrounding the rating in the V-A scale. 
     I further decided to do some cluster analysis to make sense of the clustering under various measures of central tendency but the some of the result still remains inexplicable. At this point the problem seemed to have turned into a classic unsupervised clustering problem with some in-explicable clusters.Further analysis of the embeddings with different linkage functions or some kind of linkage research might hold the key. 
     A proportion of variance test on the learnt response was also done for the differnt IBI time series(across users and videos) the test seemed to explain a high percentage of variance in the time series for most of the clips. 
     The biggest caveat which still remains with the large number of learnt response functions is the virtually non-existent literature in the psycho-phys communinty when it comes to interpretation of the learnt _`response functions(atoms)`_. After a detailed literature survey I found that the community seemed to have only come up with _interpretation of some of the often seen elicited rsponses which are generally derived under the extreme ends of the V-A spectrum i.e `response functions(RFs) in the extreme ends of the 2D plane of V-A_`. 
     At some point the community needs to realize that one aspect of AI is _'through generative modeling of our deep seated responses,  which are mitigated and modulated by our nervous system's electrical responses_'. The different `RFs` elicited which are placed in the different regions of the `V-A scale` gives us insight into how our sympathetic nervous sytem has reacted to the stimuli. The shape of the `RF(accelaration/decclaration, constant or variable)`, a reflection of the modulation of the heart period, might then lead to some insights as to why we react differently to certain stimulus/conditions. This generative distribution might lead to a better understanding of why certain age groups, gender react differently to different siutations which might refine our understanding of how evolution has affected us differently.
     
***misPCA:***

Earlier work and reference: 

http://web.eecs.umich.edu/~hero/Preprints/puig_asilomar11.pdf

https://github.com/atibaup/MisPCA

***Introduction:***

`misaligned PCA` is a combinatorially exhaustive search technique to estimate the misalignment in a particular principal component. One of the drawbacks of the PC techniques used by Bach et al. was that the estimated principal component did not have any estimate of the latency associated with the response after a stimulus. The latency turns out to be an important parameter when associated with _`Heart Period response`_ functions since it gives us an insight as to how the `V-A spectrum` associates itself with the dynamics of Heart Period changes. A stimuli with a _positive valence_ but _low arousal_ might have a _higher latency_ than a similarly scaled _arousal stimuli_ but with a _negative valence_. Some _PsychoPhys._ literature suggests that latency is a subjective parameter(not completely understood), highly modulated by the effect of Valence rather than Arousal.  This was our primary motivation in moving towards this direction as we had realized that only estimating the response funtion, without any idea of latency could potentially turn out to be a very 'dry' estimate of the effect of Valence. 
Following Bach et al.s methodology we decided to have a window of 30s for extracting the components.Although, as justified earlier a smaller window size might turn out to be a better choice. 

***A result on the simulated-data used by the author in his work:***
![](BestWorkingCase.jpg)

This is one of the preliminary result from one of his experimental scripts in the repository. In this the author(s) have shown that the approximation algorithm, `alternating-misPCA(A-misPCA)` reovrers the principal component and the misalignment correctly. 

### Results on the DEAP data-set: 

As described earlier the DEAP data-set had to be pre-processed and then converted to a usable R-R interval time series. Windowing was done as described earlier. 

Some of the estimated components are shown below with a few key points: 
![](misPC3_edited.jpg)

![](misPC40_edited.jpg)

As shown in the above estimated components(~ 30s) there are smaller epochs(~ 5s),shown by the bounding boxes which are strikingly similar to the common responses seen in the PsychoPhys. literature, such reponses were also extracted by Bach et. al. in his experiments. One of the bounding boxes,later in the first time-series shows deceleraton-accelaration which basically means the Heart Rate(HR) falls and then starts climbing. Sudden _impulse like shapes_ are indicative of sudden increase in the HR potentially due to some stimuli. 
Further analysis with the corresponding segment in the clip could give more insight as to how those reponses are related to the content in the clips. 

***2D embeddings of the estimated response functions***

![](2D_embeddings.jpg)









