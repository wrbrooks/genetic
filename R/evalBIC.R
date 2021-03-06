evalBIC <-
function(chromosome=c(), data, output) {
    returnVal = Inf
    minLV = 2
    if (sum(chromosome) >= minLV) {
        #Extract the selected variables, create the model formula and fit the model
        out.col = which(names(data)==output)
        selected = cbind(output=data[,output], data[,-out.col][,chromosome==1])
        f = as.formula("output~.")
		
		returnVal = tryCatch(
		{
			model = lm(f, data=selected)
			
			#Evaluate the model on the basis of the BIC:
			n = nrow(selected)
			returnVal = AIC(model, k=log(n))
		}, warning = function(w) {
			Inf
		})
    }
    return(returnVal)
}
