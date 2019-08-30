object alquimista{
	var itemsDeCombate=[]
	var itemsDeRecoleccion=[]
	
	
	method tieneCriterio(){
		return self.cantidadDeItemsDeCombateEfectivos() >= self.cantidadDeItemsDeCombate()/2
	}
	method cantidadDeItemsDeCombateEfectivos(){
		return itemsDeCombate.count({
			itemsDeCombate.esEfectivo()
		})
	}
	method cantidadDeItemsDeCombate(){
		return itemsDeCombate.size()
	}
	method agregarItemDeCombate(unItem){
		return itemsDeCombate.add(unItem)
	}
	
	
	method esBuenExplorador(){
		return self.cantidadDeItemsDeRecoleccion() >= 3
	}
	method cantidadDeItemsDeRecoleccion(){
		return itemsDeRecoleccion.size()
	}
	method agregarItemDeRecoleccion(unItem){
		return itemsDeRecoleccion.add(unItem)
	}
	
	method capacidadOfensiva(){
		return bomba.capacidad() + pocion.capacidad()
	}
}

object bomba{
	var materiales=[]
	var danio = 20
	
	method esEfectivo(){
		return danio > 100
	}
	method capacidad(){
		return danio/2
	}
}

object pocion{
	var materiales=[]
	var poderCurativo = 10
	
	method esEfectivo(){
		return poderCurativo > 50 and self.fueCreadoPorAlgunMaterialMistico()
	}
	method fueCreadoPorAlgunMaterialMistico(){
		return materiales.any({
			unMaterial =>
			materiales.esMistico()
		})
	}
	
	method capacidad(){
		return poderCurativo + 10 * self.cantidadDeMaterialesMisticos()
	}
	method cantidadDeMateriales(){
		return materiales.size()
	}
	method cantidadDeMaterialesMisticos(){
		return materiales.count({
			materiales.esMistico()
		})
	}
	//method agregarMaterial(unMaterial){
	//	return materiales.add(unMaterial)
	//}
}

object debilitador{
	var materiales=["uni"]
	var potencia = 0
	
	method esEfectivo(){
		return potencia > 0 and not(self.fueCreadoPorAlgunMaterialMistico())
	}
	method fueCreadoPorAlgunMaterialMistico(){
		return materiales.any({
			unMaterial =>
			materiales.esMistico()
		})
	}
	
	//PUNTO 3
	method capacidad(){
		if(not (self.fueCreadoPorAlgunMaterialMistico())){
			return 5
		}
		else{
			return 12 * self.cantidadDeMaterialesMisticos()
		}
	}
	method cantidadDeMaterialesMisticos(){
		return materiales.count({
			materiales.esMistico()
		})
	}
}

object florRoja{
	
	method esMistico(){
		return false
	}
}
object uni{
	
	method esMistico(){
		return true
	}
}
object polvora{
	
	method esMistico(){
		return false
	}
}