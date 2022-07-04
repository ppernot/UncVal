[![DOI](https://zenodo.org/badge/506150404.svg)](https://zenodo.org/badge/latestdoi/506150404)


# UncVal
Implements the methods reviewed in

[Pernot, P. (2022). Prediction uncertainty validation for computational chemists. 
arXiv preprint arXiv:2204.13477.](https://arxiv.org/abs/2204.13477)

## Docker container

The [uncval](https://hub.docker.com/repository/docker/ppernot1/uncval)
Docker container has all elements preinstalled.

To run the container:

0. Install [Docker](https://www.docker.com/products/docker-desktop)

1. Type the following commands in a terminal
```
docker run -d -p 3830:3830 --name uncval ppernot1/uncval
```      

2. Access UncVal at `http://localhost:3830` in your favorite browser

3. When finished
```
docker kill uncval
```

4. For further sessions
```
docker restart uncval
```

4. To cleanup
```
docker remove -v uncval
```

## How to cite UncVal

If you use UncVal in one of your publications, do not forget to cite it 
and include the version you used for reproducibility:

* Pernot, P. (2022) UncVal: Validation of prediction uncertainty (Version X.X). 
https://doi.org/10.5281/zenodo.6793688 

* Pernot, P. (2022). Prediction uncertainty validation for computational chemists. 
arXiv preprint arXiv:2204.13477.    
@article{Pernot2022Apr,    
	author = {Pernot, Pascal},     
	title = {{Prediction uncertainty validation for computational chemists}},     
	journal = {arXiv:2204.13477},    
	year = {2022},    
	doi = {10.48550/arXiv.2204.13477}    
}
