object alquimista{
	var itemsDeCombate=[]
	var itemsDeRecoleccion=[]
	
	//PUNTO 1
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
	
	//PUNTO 2
	method esBuenExplorador(){
		return self.cantidadDeItemsDeRecoleccion() >= 3
	}
	method cantidadDeItemsDeRecoleccion(){
		return itemsDeRecoleccion.size()
	}
	method agregarItemDeRecoleccion(unItem){
		return itemsDeRecoleccion.add(unItem)
	}
	
	//PUNTO 3
	method capacidadOfensiva(){
		return bomba.capacidad() + pocion.capacidad() + debilitador.capacidad()
	}
	
	//PUNTO 4
	method esProfesional(){
		return self.calidadPromedio() > 50 && self.todosSusItemsDeCombateSonEfectivos() && self.esBuenExplorador()
	}
	
	method calidadPromedio(){
		return self.calidadTotalDeItemsDeCombate() + self.calidadTotalDeItemsDeRecoleccion()
		/ self.cantidadDeItemsDeCombate() + self.cantidadDeItemsDeRecoleccion()
	}
	method calidadDeItemsDeCombate(){
		return itemsDeCombate.map({
			unosItems =>
				itemsDeCombate.calidad()
		})
	}
	method calidadTotalDeItemsDeCombate(){
		return self.calidadDeItemsDeCombate().sum()
	}
	method calidadDeItemsDeRecoleccion(){
		return itemsDeRecoleccion.map({
			unosItems =>
				itemsDeRecoleccion.calidad()
		})
	}
	method calidadTotalDeItemsDeRecoleccion(){
		return self.calidadDeItemsDeRecoleccion().sum()
	}
	
	method todosSusItemsDeCombateSonEfectivos(){
		return itemsDeCombate.all({
			unosItems =>
			itemsDeCombate.esEfectivo()
		})
	}
}

//											ITEMS DE COMBATE

object bomba{
	var materiales=[]
	var danio = 20
	
	//PUNTO 1
	method esEfectivo(){
		return danio > 100
	}
	//PUNTO 3
	method capacidad(){
		return danio/2
	}
	
	//PUNTO 4
	method calidad(){
		return materiales.min({
			unMaterial =>
			unMaterial.calidad()
		}).calidad()
	}
}

object pocion{
	var materiales=[]
	var poderCurativo = 10
	
	//PUNTO 1
	method esEfectivo(){
		return poderCurativo > 50 and self.fueCreadoPorAlgunMaterialMistico()
	}
	method fueCreadoPorAlgunMaterialMistico(){
		return materiales.any({
			unMaterial =>
			materiales.esMistico()
		})
	}
	//PUNTO 3
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
	
	//PUNTO 4
	method calidad(){
		if (self.fueCreadoPorAlgunMaterialMistico()){
			return self.primerMaterialMistico().calidad()
		}
		else{
			return materiales.first().calidad()
		}
	}
	method susMaterialesMisticos(){
		return materiales.filter({
			unosMateriales =>
			unosMateriales.esMistico()
		})
	}
	method primerMaterialMistico(){
		return self.susMaterialesMisticos().first()
	}
}

object debilitador{
	var materiales=[]
	var potencia = 0
	
	//PUNTO 1
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
	
	//PUNTO 4
	method calidad(){
		return 
	}
}


//												ITEMS DE RECOLECCION

object florRoja{
	var property calidad = 30	//PUNTO 4
	
	//PUNTO 1
	method esMistico(){
		return false
	}
	
}
object uni{
	var property calidad = 50	//PUNTO 4
	//PUNTO 1
	method esMistico(){
		return true
	}
}
object polvora{
	var property calidad = 10	//PUNTO 4
	//PUNTO 1
	method esMistico(){
		return false
	}
}