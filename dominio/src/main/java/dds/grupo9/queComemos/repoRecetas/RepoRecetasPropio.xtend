package dds.grupo9.queComemos.repoRecetas

import java.util.Collection
import dds.grupo9.queComemos.excepciones.NoLoTieneException
import dds.grupo9.queComemos.Receta
import dds.grupo9.queComemos.repoUsuarios.RepoDefault
import org.hibernate.Criteria
import org.hibernate.criterion.Restrictions

class RepoRecetasPropio extends RepoDefault<Receta> implements dds.grupo9.queComemos.repoRecetas.RepoRecetas {
	
	var Collection <Receta> recetasPublicas = newHashSet()
	
	def tieneRecetaPublica(String nombreReceta){
		recetasPublicas.exists[it.nombre==nombreReceta]
		
	}
	
	def void agregarRecetaPublica(Receta receta){
		recetasPublicas.add(receta)
	}
	
		
	def quitarRecetaPublica(Receta receta){
		if(tieneRecetaPublica(receta.nombre))
		recetasPublicas.remove(receta)
		else throw new NoLoTieneException ("No existe esta receta publica")
		
	}
	
	override Collection<Receta> getRecetas(){
		
		this.recetasPublicas
	}
	
	override Receta buscarRecetaPorNombre(String nombre){
		recetasPublicas.findFirst[it.nombre==nombre]
	}
	override getEntityType() {
		typeof(Receta)
	}

	override addQueryByExample(Criteria criteria, Receta candidato) {
		if (candidato.nombre != null) {
			criteria.add(Restrictions.eq("nombre", candidato.nombre))
		}
	}
	
	
}