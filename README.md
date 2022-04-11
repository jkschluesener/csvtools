# csv concat
Concatenate a pattern of csv files into one file.

## usecase
Assuming a data directory such as this:

```console
$ ls ./data/*.csv
./data/01.csv   ./data/02.csv   ./data/03.csv
```

With file contents such as:
```console
$ cat ./data/*.csv

category1,category2,modification1,modification2,feature,score,pvalue
'aardvark','banana','original','powermatch','luminance',0.36,0.34
category1,category2,modification1,modification2,feature,score,pvalue
'lamp','chaiselounge','original','powermatch','luminance',0.59,0.14
category1,category2,modification1,modification2,feature,score,pvalue
'glasses','pen','original','powermatch','luminance',0.76,0.84
```

As you can see, every file has its own header, as csv files usually do.

So what if you quickly need to concatenate these files, skipping the header for every file except the first?

This script is your answer! :tada:

```console
$ ./csvconcat.sh -i "./data/*.csv" -o "./data/data.csv" 
```

```console
$ cat ./data/data.csv
category1,category2,modification1,modification2,feature,score,pvalue
'aardvark','banana','original','powermatch','luminance',0.36,0.34
'lamp','chaiselounge','original','powermatch','luminance',0.59,0.14
'glasses','pen','original','powermatch','luminance',0.76,0.84
```

## features
- If the output file already exists, the script exits with an error
- To overwrite an output file, supply the `-w` flag
- The output file is excluded from the concatenation to avoid recursion
- The column titles are taken from the first file of the sorted file list



:fire: This script is NOT smart - it does not run any heuristics on your csv data.  
If you column labels/count/datatypes/etc. don't match, it won't notice.

## script flags

`-i`: input pattern as one would use in `ls`, in ".."  
`-o`: output file, in ".."  
`-w`: overWrite the output file if it already exists  
