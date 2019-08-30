object alquimista{
	var itemsDeCombate=[]
	var itemsDeRecoleccion=[]
	var todosSusItems = itemsDeCombate + itemsDeRecoleccion
	
	method itemsDeCombate(){
		return itemsDeCombate
	}
	method itemsDeRecoleccion(){
		return itemsDeRecoleccion
	}
	method todosSusItems(){
		return todosSusItems
	}
	
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
		return self.calidadTotalDeTodosSusItems() / self.cantidadDeTodosSusItems()
	}
	method calidadTotalDeTodosSusItems(){
		return self.calidadDeTodosSusItems().sum()
	}
	method calidadDeTodosSusItems(){
		return todosSusItems.map({
			unosItems =>
				todosSusItems.calidad()
		})
	}
	method cantidadDeTodosSusItems(){
		return todosSusItems.size()
	}
	
	method todosSusItemsDeCombateSonEfectivos(){
		return itemsDeCombate.all({
			unosItems =>
			itemsDeCombate.esEfectivo()
		})
	}
	
	method calidadDelPrimerItemDeMayorCalidad(){
		return self.primerItemDeMayorCalidad().calidad()
	}
	method primerItemDeMayorCalidad(){
		return self.todosSusItems().max({
			unItem =>
			unItem.calidad()
		})
	}
	method calidadDelSegundoItemDeMayorCalidad(){
		return self.segundoItemDeMayorCalidad().calidad()
	}
	method segundoItemDeMayorCalidad(){
		return self.todosSusItemsMenosElDeMayorCalidad().max({
			unItem =>
			unItem.calidad()
		})
	}
	method todosSusItemsMenosElDeMayorCalidad(){
		return todosSusItems.remove({self.primerItemDeMayorCalidad()})
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
		return alquimista.calidadDelPrimerItemDeMayorCalidad() + alquimista.calidadDelSegundoItemDeMayorCalidad() / 2
	}
}


//												MATERIALES

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


//											ITEMS DE RECOLECCION

object caniaDePescar{
	var materiales=[]
	
	method calidad(){
		return 30 + 0.1* self.calidadTotalDeSusMateriales()
	}
	method calidadTotalDeSusMateriales(){
		return self.calidadDeSusMateriales().sum()
	}
	method calidadDeSusMateriales(){
		return materiales.map({
			unosMateriales =>
				materiales.calidad()
		})
	}
	method agregarMaterial(unMaterial){
		return materiales.add(unMaterial)
	}
}
object redAtrapaInsectos{
	var materiales=[]
	
	method calidad(){
		return 30 + 0.1* self.calidadTotalDeSusMateriales()
	}
	method calidadTotalDeSusMateriales(){
		return self.calidadDeSusMateriales().sum()
	}
	method calidadDeSusMateriales(){
		return materiales.map({
			unosMateriales =>
				materiales.calidad()
		})
	}
	method agregarMaterial(unMaterial){
		return materiales.add(unMaterial)
	}
}
object bolsaDeVientoMagica{
	var materiales=[]
	
	method calidad(){
		return 30 + 0.1* self.calidadTotalDeSusMateriales()
	}
	method calidadTotalDeSusMateriales(){
		return self.calidadDeSusMateriales().sum()
	}
	method calidadDeSusMateriales(){
		return materiales.map({
			unosMateriales =>
				materiales.calidad()
		})
	}
	method agregarMaterial(unMaterial){
		return materiales.add(unMaterial)
	}
}