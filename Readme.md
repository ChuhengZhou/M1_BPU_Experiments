# __Apple M1 Branch Prediction Unit Reversing__
Performance counters is assumed to be accurate enough in our experiment.

BPU on two CPU clusters (firestorm and icestorm) may not be same, experiment should be implemented on both clusters.

## __Branch Script__
`prepare_branch.py` is the script for preparing different types of branch instruction, including conditional jump, unconditional jump, and indirect branch, in a single function. The number and interval of the branches can be set manually.

`test.sh` is the script for one-click test.

Through varing the branch type, branch number and branch interval, we can manipulate different microarchitectural elements of M1 BPU, and then find out their structure and prediction pattern.

## __Pattern History Table__

### __Prediction Pattern__
M1 PHT only remember the branch result of last one conditional branch on both firestorm and icestorm.

Prepare a small number of conditional branches that can all fit in the PHT. Instead of only profiling a sinlge branch function after mistrain , now we vary the number of branch function been run in our benchmark code. It's obvious that, no matter how many times we call the branch function, the total mispredictions are always same and close to branch number. This tells M1 PHT only remembers the branch result of last one conditional branch.

### __Branch Interval__
Branch interval will affect the accuracy of prediction on both firestorm and icestorm. 

Prepare a small number of conditional branches. Ideally，no matter how the branch interval change, the total misprediction and branch number should always be the same as long as all branches can fit in the PHT. However, as the branch interval increase, the misprediction will be less and less than expected.

One guess of this phenomenon is that branch interval has correlation with the prediction of global predictor.

### __Bias to Not Taken__
The prediction has a bias to not taken on both firestorm and icestorm. 

Prepare a small number of conditional branches that can all fit in the PHT, if we mistrain them to taken and profile not taken branches once, the misprediciton number will only be around half of the branch number, which should be the same as expected. This phenomenon doesn't exist when mistrain to not taken and profile taken branch function.

One guess of this phenomenon is that global predictor learn not taken branch more quickly than taken branch.

### __PHT Size__
| | |
| ---- | ---- |
| icestorm | 32768 entries, indexed by bits[17:3] |
| firestorm | <TO DO> |

On icestorm, the misprediction will achieve a threshold and stop increasing when branch number * branch interval >= 4 * 32768.

Experiment result on firestorm is super unstable and weird, need more research.

## __indirect Branch Target Buffer__

### __iBTB Structure__
iBTB are not address indexed on both icestorm and firestorm.

Increasing the branch number and interval gradually, if iBTB is indexed by branch address, there will be address collisions when branch number * branch interval is big enough and the misprediction should stop at a fix number. However, the experiment shows that no matter how we change branch number and interval, the misprediction is always equal to the branch number. We can learn that M1 iBTB is not address indexed cache.

Instead, it is a tagged cache that stores branch address and target address (maybe some other information) from each taken indirect branch, and scan the whole iBTB to see if there is any record when next time an indirect branch needs to be predicted. We will prove this later. 

### __iBTB Size__
| | |
| ---- | ---- |
| icestorm | 512 entries |
| firestorm | 1024 entries |

Because iBTB is not address indexed, The idea of finding branch collision can not be reused anymore. So, we change a little bit in our benchmark code.

First, the branch interval can be excluded. 

Second, instead of producing misprediction by running branch function on two opposite sides (like taken and not taken branch), we now use same branch function with same branch target in both mistrain and profile stage. 

When branch number < iBTB size, most of the entries from mistrain stage, except those replaced by irregular replacement algorithm accidently, will still stay in iBTB in profile stage. So, the total misprediction of prfile stage will be very close to 0.

On the contrary, when branch number > iBTB size, only part of the branches can stay in iBTB after mistrain. And the following profile stage will generate lots of mispredictions.

Experiment shows the misprediction increase sharply when branch number increase from 512 to 1024 on icestrom, from 1024 to 2048 on firestorm, which means the size of iBTB is 512 entries on icestorm, 1024 entries on firestorm.

### __Tagged iBTB__
iBTB is tagged on both icestorm and firestorm.

Prepare a very small number of indirect branches that can all fit in the iBTB. With the change of branch interval, the mispredition also changes, irregularly. However, it should be always close to 0 as expected.

One guess of this phenomenon is that iBTB is tagged cache. And the bits used for tagging are distributed irregularly, so that the change of branch interval will produce irregular misprediction.

### __Replacement Algorithm__
There should also be a replacement algorithem to decide which entry has to be updated when iBTB is full. 
<TO DO>

        
