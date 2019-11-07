
data Producto = UnProducto {
	nombre :: String,
	precio :: Int,
	componentes :: [(String, Int)]
	} deriving Show
	
data Pedido = UnPedido {
	cliente :: String,
	nombreProducto:: String,
	cantidad :: Int} deriving Show

data PersonaACargo :: Trabajador {
	descripcion:: String
--  ... :: ...
}	
