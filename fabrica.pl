
%requiere(producto, componente,cantidad).
requiere(auto, rueda, 4).
requiere(auto, motor, 1).
requiere(moto, rueda, 2). 
requiere(avion, motor, 4).
requiere(avion, ala, 2).

%precio(producto,importe).
precio(auto, 1000).
precio(camion, 2000).
precio(moto, 500).
precio(avion, 5000).

%pedido(cliente,producto, cantidad).
pedido(acme, auto, 10).
pedido(acme, avion, 1).
pedido(pdepTransportes, barco, 1).
pedido(pdepTransportes, auto, 3).

%stock(componente, stock).
stock(rueda,20).
stock(motor,10).
stock(ala,3).


productoPedidoSinPrecio(Producto):-
   pedido(_, Producto,_),
   not( precio(Producto,_)).
   

productoBarato(Tope,Producto):-
    precio(Producto,Precio),
    Precio < Tope.