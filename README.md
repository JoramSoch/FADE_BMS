# FADE_BMS

**Bayesian model selection for the FADE Paradigm**

This code belongs to the paper "Bayesian model selection favors parametric over categorical fMRI subsequent memory models in young and older adults" by Soch, Richter et al. (2020), publicly available from *bioRxiv* and currently under review at *NeuroImage*. For instructions how to process these data, see below.

- Preprint: https://www.biorxiv.org/content/10.1101/2020.07.27.220871v5
- Data (1): https://neurovault.org/collections/EKUNXKRB/
- Data (2): https://neurovault.org/collections/QBHNSRVW/
- Code: https://github.com/JoramSoch/FADE_BMS
- Toolbox: https://github.com/JoramSoch/MACS


### Requirements

This code was developed and run using the following software:
- Windows 10 Professional 64-bit
- [MATLAB R2018a/R2020a](https://de.mathworks.com/help/matlab/release-notes.html) (Version 9.4/9.8)
- [MATLAB Statistics and ML Toolbox](https://de.mathworks.com/products/statistics.html) (Version 11.7)
- [SPM12](https://www.fil.ion.ucl.ac.uk/spm/software/spm12/) (Revision 7771 as of 13/01/2020)
- [MACS Toolbox](https://github.com/JoramSoch/MACS) (Version 1.3)


### Instructions

For re-running analyses reported in the paper, you need to perform the following steps:
1. Create a folder on your computer that hereafter is referred to as the "study directory".
2. Download the [cvLME maps](https://neurovault.org/collections/EKUNXKRB/) and place them into a sub-folder of the study directory called "cvLME_maps".
3. Download the [contrast images](https://neurovault.org/collections/QBHNSRVW/) and place them into a sub-folder of the study directory called "con_images".
4. Download the [analysis scripts](https://github.com/JoramSoch/FADE_BMS/archive/master.zip) and place them into a sub-folder of the study directory called "FADE_BMS".
5. Open MATLAB, set your current directory to this sub-folder, edit the study directory [in line 12](https://github.com/JoramSoch/FADE_BMS/blob/master/analyses_FADE_BMS.m#L12) of `analyses_FADE_BMS.m` and run this script.
6. Dedicated scripts to generate Figure plots as shown in the paper are added to this repository soon.