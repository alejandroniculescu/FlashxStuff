#!/usr/bin/env Rscript
args<-commandArgs(TRUE)

numNodes<-args[1]
#probability<-args[2]

library(igraph)


#print(numEdges)
#print(probability/numEdges)
#.9 ish
#use (1000, 998/1000), where n = 1000 (n, 998/n)
g <- erdos.renyi.game(numNodes, 998/1000)
fileName<-paste("edgelist", numNodes, sep="_")
write.graph(g, fileName, format=c("edgelist"))
