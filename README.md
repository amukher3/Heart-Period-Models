# Heart-Period-Models
An effort to extract the different response function for changes in heart period under the effect of continous stimuli rated differently in the Valence-Arousal scale.

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


