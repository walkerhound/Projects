rm(list = ls())

setwd("/Users/clemensl/LODPlots")


#############################################
##  Create R/qtl Data Files (Gary Format)  ##
#############################################

marker.data <- read.table(file = "BXD32_March2009.txt",sep="\t",skip=6,header=TRUE)

exprs.data <- read.table(file = "Traits32_RMA_Mar2009.txt",sep="\t",header=TRUE)
weights.data <- read.table(file = "Weights32_RMA_Mar2009.txt",sep="\t",header=TRUE)
eQTL.data <- read.table(file = "OneDScan_Output_05Mar09.txt",sep="\t",header=TRUE)

chrid <- marker.data$Chr
markerpos <- marker.data[,c("Locus","Mb")]
mnames <- marker.data[,c("Locus")]

geno <- t(marker.data[,colnames(exprs.data)[-1]])
geno[geno=="B"] <- 0
geno[geno=="b"] <- 0
geno[geno=="D"] <- 2
geno[geno=="H"] <- 9

pheno <- t(exprs.data[,-1])
pnames <- exprs.data$Trait
short.pheno <- t(exprs.data[1:10,-1])
short.pnames <- exprs.data$Trait[1:10]

write.table(chrid,file="chrid.dat",sep="\t",row.names=FALSE,col.names=FALSE, quote = FALSE)
write.table(markerpos,file="markerpos.txt",sep="\t",row.names=FALSE,col.names=FALSE, quote = FALSE)
write.table(mnames,file="mnames.txt",sep="\t",row.names=FALSE,col.names=FALSE, quote = FALSE)
write.table(geno,file="geno.dat",sep="\t",row.names=FALSE,col.names=FALSE, quote = FALSE)
write.table(pheno,file="pheno.dat",sep="\t",row.names=FALSE,col.names=FALSE, quote = FALSE)
write.table(pnames,file="pnames.txt",sep="\t",row.names=FALSE,col.names=FALSE, quote = FALSE)
write.table(short.pheno,file="phenoShort.dat",sep="\t",row.names=FALSE,col.names=FALSE, quote = FALSE)
write.table(short.pnames,file="pnamesShort.txt",sep="\t",row.names=FALSE,col.names=FALSE, quote = FALSE)

############################################
##  Create LOD Plots for Each Transcript  ##
############################################

library(qtl)
require(Cairo);

setwd("/Users/clemensl/LODPlots")

mydata <- read.cross(format="gary")
#mydata <- read.cross(format="gary",phefile="phenoShort.dat",pnamesfile="pnamesShort.txt")


setwd("/Users/clemensl/LODPlots")



nphe=(nphe(mydata)-2)


for(i in 1:nphe){
	
	probeID = substr(colnames(mydata$pheno)[i],2,20)
	weight<-as.double(1/weights.data[weights.data$VAR1==probeID,-1])

	out.mr<-scanone(mydata,pheno.col=i,method="mr",weights=weight)



	maxLOD=max(out.mr)$lod

	p001=eQTL.data$p001[eQTL.data$ProbeID==probeID] / (2*log(10))

	p05=eQTL.data$p05[eQTL.data$ProbeID==probeID] / (2*log(10))
	p10=eQTL.data$p10[eQTL.data$ProbeID==probeID] / (2*log(10))


	upper.bound = max(maxLOD,p001) + 1

	title = paste("LOD plot for",probeID,sep=" ")

	filename = paste("Probe",probeID,"svg",sep=".")



	CairoSVG(file=filename,width=18,height=6)

		plot(out.mr,ylim=c(0,upper.bound),main=title)

		#Line for p=0.001

		abline(h=p001,col="red")

		#Line for p=0.05

		abline(h=p05,col="green")

		#Line for p=0.10

		abline(h=p10,col="blue")

		#Lines to delimit chromosomes

		abline(v=c(203,403,582,758,927,1098,1254,1402,1540,1685,1827,1961,2094,2235,2360,2476,2590,2697,2780,2956),col="grey")

	dev.off()

}

