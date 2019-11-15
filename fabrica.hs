data Producto = UnProducto {
  nombre :: String,
  precio :: Int,
  componentes :: [(Componente, Int)]
} deriving Show

data Pedido = UnPedido {
  cliente :: String,
  nombreProducto:: String,
  cantidad :: Int
} deriving Show

data PersonaACargo = Trabajador {
  descripcion:: String,
  especialidad:: Especialidad
}

type Especialidad = [Producto] -> Pedido -> Bool
type Componente = String

---------------------------------------------------------------------------------
-- 1) Lo primero que se quiere saber es:

--los productos pedidos sin precio
productosPedidosSinPrecio :: [Producto] -> [Pedido]-> [String]
productosPedidosSinPrecio productos pedidos =
   map nombreProducto (filter (not.existeEn productos) pedidos )

existeEn:: [Producto] ->Pedido -> Bool
existeEn productos pedido = any (coincide pedido) productos

coincide :: Pedido -> Producto -> Bool
coincide pedido producto = nombreProducto pedido == nombre producto

--los productos baratos
productosBaratos:: Int -> [Producto] -> [String]
productosBaratos importe productos = (map nombre. filter (esBarato importe)) productos

esBarato:: Int -> Producto -> Bool
esBarato importe producto = precio producto < importe

--los componentes que no son exclusivos
componentesNoExclusivos::[Producto] -> [Componente] -> [Componente] 
componentesNoExclusivos productos componentes 
  = filter (componenteNoExclusivo productos) componentes 

componenteNoExclusivo::[Producto] -> Componente -> Bool 
componenteNoExclusivo productos componente 
  = length (filter  (usa componente)  productos) > 1 
  
usa:: Componente -> Producto -> Bool
usa componente producto = any ((componente ==).fst) (componentes producto)

----------------------------------------------------------------------------------
-- 2) Además, se requiere ver la factibilidad de cumplir con los pedidos recibidos
-- A partir de todos los pedidos recibidos 
-- y de saber quién está a cargo de la fabrica en ese momento, 
-- encontrar aquellos que se puedan cumplir.

sePuedenCumplir::[Pedido] -> PersonaACargo -> [Producto] -> [Pedido]
sePuedenCumplir pedidos persona productos = filter ((especialidad persona) productos) pedidos


-- Especialidades
vendedor:: Int -> Especialidad
vendedor importe productos pedido = precio (productoDelPedido productos pedido) < importe

gerente:: Especialidad
gerente _ _ = True

ingeniero:: Especialidad
ingeniero productos pedido = cantidadComponentes (productoDelPedido productos pedido) * cantidad pedido < 100

cantidadComponentes :: Producto -> Int
cantidadComponentes producto = sum (map snd (componentes producto))

productoDelPedido:: [Producto] -> Pedido -> Producto
productoDelPedido productos pedido = head (filter (coincide pedido) productos)

-----------------------------------------------------------------------
-- EJEMPLOS DE PRUEBA

auto = UnProducto "auto" 1000 [("rueda",4),("motor",1)]
avion = UnProducto "avion" 5000 [("ala",2),("motor",4)]

pedidoAuto = UnPedido "acme" "auto" 100
pedidoAvion = UnPedido "acme" "avion" 1
pedidoBarco = UnPedido "pdep" "barco" 1
pedidoMasAutos = UnPedido "pdep" "auto" 3

pedidosEjemplo = [pedidoAuto, pedidoAvion,pedidoBarco,pedidoMasAutos]
pedidosEjemplo2 = [pedidoAuto, pedidoAvion,pedidoMasAutos]
componentesEjemplo = ["rueda","motor","ala"]
productosEjemplo = [auto,avion]


cacho = Trabajador "saraza" (vendedor 2000)
pepo = Trabajador "saraza" (vendedor 2000000)
tito = Trabajador "saraza" gerente
toni = Trabajador "saraza" ingeniero

---------------------------------------------------
-- CONSULTAS
{-
*Main> productosPedidosSinPrecio productosEjemplo pedidosEjemplo 
["barco"]

*Main> productosBaratos 2000 productosEjemplo 
["auto"]
*Main> productosBaratos 200000 productosEjemplo 
["auto","avion"]

*Main> componentesNoExclusivos productosEjemplo componentesEjemplo 
["motor"]

*Main> sePuedenCumplir pedidosEjemplo2 cacho productosEjemplo 
[UnPedido {cliente = "acme", nombreProducto = "auto", cantidad = 100},UnPedido {cliente = 
"pdep", nombreProducto = "auto", cantidad = 3}]
*Main> sePuedenCumplir pedidosEjemplo2 pepo productosEjemplo 
[UnPedido {cliente = "acme", nombreProducto = "auto", cantidad = 100},UnPedido {cliente = 
"acme", nombreProducto = "avion", cantidad = 1},UnPedido {cliente = "pdep", nombreProducto = "auto", cantidad = 3}]
*Main> sePuedenCumplir pedidosEjemplo2 tito productosEjemplo    
[UnPedido {cliente = "acme", nombreProducto = "auto", cantidad = 100},UnPedido {cliente = 
"acme", nombreProducto = "avion", cantidad = 1},UnPedido {cliente = "pdep", nombreProducto = "auto", cantidad = 3}]
*Main> sePuedenCumplir pedidosEjemplo2 toni productosEjemplo 
[UnPedido {cliente = "acme", nombreProducto = "avion", cantidad = 1},UnPedido {cliente = "pdep", nombreProducto = "auto", cantidad = 3}]

-}